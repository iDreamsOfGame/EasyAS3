/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-27 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.display.pixel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ... 像素级交互对象代理 ...
	 * @author Jerry
	 */
	public class PixelInteractiveDisplayObjectProxy
	{
		/**
		 * 鼠标事件数组
		 * @private
		 */
		private static const MOUSE_EVENTS:Array = [
			MouseEvent.ROLL_OVER,
			MouseEvent.ROLL_OUT,
			MouseEvent.MOUSE_OVER,
			MouseEvent.MOUSE_OUT,
			MouseEvent.MOUSE_MOVE
		];
		
		/**
		 * 基础坐标点
		 * @private
		 */
		private static const BASE_POINT:Point = new Point();
		
		/**
		 * 指定此对象是否使用像素级交互
		 * @private
		 */
		private var _pixelIntactiveEnabled:Boolean;
		
		/**
		 * 位图点击
		 * @private
		 */
		private var _bitmapHit:Boolean;
		
		/**
		 * 透明模式
		 * @private
		 */
		private var _transparentMode:Boolean;
		
		/**
		 * buttonMode属性缓存
		 * @private
		 */
		private var _buttonModeCache:Number;
		
		/**
		 * 探测鼠标鼠标事件用位图对象
		 * @private
		 */
		private var _bitmapForHitDetection:Bitmap;
		
		/**
		 * 鼠标指针所在坐标
		 * @private
		 */
		private var _mousePoint:Point;
		
		/**
		 * 交互对象
		 * @private
		 */
		private var _interactiveObject:IPixelInteractiveDisplayObject;
		
		/**
		 * 透明度检测阀值
		 */
		private var _alphaThreshold:uint = PixelAlphaThreshold.MAX_VALUE;
		
		/**
		 * 构造函数
		 * @param interactiveObject:InteractiveObject — 交互对象
		 */		
		public function PixelInteractiveDisplayObjectProxy(interactiveObject:IPixelInteractiveDisplayObject)
		{
			_interactiveObject = interactiveObject;
			_mousePoint = new Point();
			pixelIntactiveEnabled = true;
		}
		
		/**
		 * 透明度检测阀值
		 */
		public function get alphaThreshold():uint 
		{
			return _alphaThreshold;
		}
		
		/**
		 * 透明度检测阀值
		 */
		public function set alphaThreshold(value:uint):void 
		{
			_alphaThreshold = Math.min(PixelAlphaThreshold.MAX_VALUE, value);
		}
		
		/**
		 * 指定此对象是否使用像素级交互
		 */
		public function get pixelIntactiveEnabled():Boolean 
		{
			return _pixelIntactiveEnabled;
		}
		
		/**
		 * 指定此对象是否使用像素级交互
		 */
		public function set pixelIntactiveEnabled(value:Boolean):void 
		{
			value?enablePixelInteractive():disablePixelInteractive();
		}
		
		/**
		 * 位图点击测试结果
		 */
		public function get bitmapHitTest():Boolean 
		{
			if (_bitmapForHitDetection == null)
			{
				//绘制位图点击区域
				drawBitmapHitArea();
			}
			
			//鼠标点赋值
			_mousePoint.x = _bitmapForHitDetection.mouseX;
			_mousePoint.y = _bitmapForHitDetection.mouseY;
			
			return _bitmapForHitDetection.bitmapData.hitTest(BASE_POINT, _alphaThreshold, _mousePoint);
		}
		
		/**
		 * 指定此对象是否接收鼠标或其他用户输入、消息。
		 */
		public function set mouseEnabled(value:Boolean):void 
		{
			if (isNaN(_buttonModeCache) == false)
			{
				pixelIntactiveEnabled = false;
			}
		}
		
		/**
		 * 指定一个 sprite 用作另一个 sprite 的点击区域。
		 */
		public function set hitArea(value:Sprite):void
		{
			if (value != null && _interactiveObject.hitArea == null) {
				pixelIntactiveEnabled = false;
			}
			else if (value == null && _interactiveObject.hitArea != null) {
				pixelIntactiveEnabled = true;
			}
		}
		
		/**
		 * 绘制位图点击区域
		 * @private
		 */
		private function drawBitmapHitArea():void 
		{
			var bounds:Rectangle;
			var matrix:Matrix;
			var bmpData:BitmapData;
			var left:Number = 0;
			var top:Number = 0;
			var isRedraw:Boolean = (_bitmapForHitDetection != null);
			
			if (isRedraw)
			{
				try
				{
					//删除原始位图对象，可能会报错，所以加入容错处理
					_interactiveObject.removeChild(_bitmapForHitDetection);
				}
				catch (e:Error)
				{
					//容错处理
				}
			}
			
			bounds = _interactiveObject.getBounds(_interactiveObject as DisplayObject);
			left = bounds.left;
			top = bounds.top;
			
			bmpData = new BitmapData(bounds.width, bounds.height, true, 0x00000000);
			_bitmapForHitDetection = new Bitmap(bmpData);
			_bitmapForHitDetection.name = "pixelInteractiveHitMap";
			_bitmapForHitDetection.visible = false;
			_bitmapForHitDetection.x = left;
			_bitmapForHitDetection.y = top;
			
			matrix = new Matrix();
			matrix.translate( -left, -top);
			bmpData.draw(_interactiveObject, matrix);
			_interactiveObject.addChildAt(_bitmapForHitDetection, 0);
		}
		
		/**
		 * 启用像素级交互方式
		 * @private
		 */
		private function enablePixelInteractive():void 
		{
			disablePixelInteractive();
			
			if (_interactiveObject.hitArea != null)
			{
				return;
			}
			
			activeMouseEventCapture();
			_pixelIntactiveEnabled = true;
		}
		
		/**
		 * 禁用像素级交互方式
		 * @private
		 */
		private function disablePixelInteractive():void 
		{
			deactiveMouseEventCapture();
			_interactiveObject.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			try
			{
				_interactiveObject.removeChild(_bitmapForHitDetection);
			}
			catch (e:Error)
			{
				//容错处理
			}
			
			_bitmapForHitDetection = null;
			_interactiveObject.originalMouseEnabled = true;
			_transparentMode = false;
			setButtonModeCache(true);
			_bitmapHit = false;
			_pixelIntactiveEnabled = false;
		}
		
		/**
		 * 激活鼠标事件捕捉
		 * @private
		 */
		private function activeMouseEventCapture():void 
		{
			var mouseEvent:String;
			var length:int = MOUSE_EVENTS.length;
			
			for (var i:int = 0; i < length; i++) 
			{
				mouseEvent = MOUSE_EVENTS[i];
				_interactiveObject.addEventListener(mouseEvent, captureMouseEventHandler, false, int.MAX_VALUE, true);
			}
		}
		
		/**
		 * 关闭鼠标事件捕捉
		 * @private
		 */
		private function deactiveMouseEventCapture():void 
		{
			var mouseEvent:String;
			var length:int = MOUSE_EVENTS.length;
			
			for (var i:int = 0; i < length; i++) 
			{
				mouseEvent = MOUSE_EVENTS[i];
				_interactiveObject.removeEventListener(mouseEvent, captureMouseEventHandler);
			}
		}
		
		/**
		 * 设置buttonMode缓存
		 * @param	restore
		 * @param	retain
		 */
		private function setButtonModeCache(restore:Boolean = false, retain:Boolean = false):void 
		{
			if (restore) {
				
				if (_buttonModeCache == 1)
				{
					_interactiveObject.buttonMode = true;
				}
				
				if (!retain)
				{
					_buttonModeCache = NaN;
				}
				
				return;
			}
			
			_buttonModeCache = (_interactiveObject.buttonMode == true ? 1 : 0);
			_interactiveObject.buttonMode = false;
		}
		
		/**
		 * 捕捉鼠标事件监听器
		 * @private
		 * @param	e:MouseEvent — 鼠标事件对象
		 */
		private function captureMouseEventHandler(e:MouseEvent):void 
		{
			if (!_transparentMode)
			{
				if (e.type == MouseEvent.MOUSE_OVER || e.type == MouseEvent.ROLL_OVER)
				{
					setButtonModeCache();
					_transparentMode = true;
					_interactiveObject.originalMouseEnabled = false;
					_interactiveObject.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, int.MAX_VALUE, true);
					trackMouseWhileInBounds();
				}
			}
			
			if (!_bitmapHit)
			{
				//阻止事件向上冒泡
				e.stopImmediatePropagation();
			}
		}
		
		/**
		 * 帧事件监听器
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function enterFrameHandler(e:Event):void 
		{
			trackMouseWhileInBounds();
		}
		
		/**
		 * 追踪鼠标是否在交互对象上
		 * @private
		 */
		private function trackMouseWhileInBounds():void 
		{
			var localMousePoint:Point;
			
			if (_bitmapHit != bitmapHitTest)
			{
				_bitmapHit = !_bitmapHit;
				
				if (_bitmapHit)
				{
					deactiveMouseEventCapture();
					setButtonModeCache(true, true);
					_transparentMode = false;
					_interactiveObject.originalMouseEnabled = true;
				}
				else if (!_bitmapHit)
				{
					_transparentMode = true;
					_interactiveObject.originalMouseEnabled = false;
				}
			}
			
			localMousePoint = _bitmapForHitDetection.localToGlobal(_mousePoint);
			
			if (_interactiveObject.hitTestPoint(localMousePoint.x, localMousePoint.y) == false)
			{
				_interactiveObject.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				_transparentMode = false;
				setButtonModeCache(true);
				_interactiveObject.originalMouseEnabled = true;
				activeMouseEventCapture();
			}
		}
	}
}
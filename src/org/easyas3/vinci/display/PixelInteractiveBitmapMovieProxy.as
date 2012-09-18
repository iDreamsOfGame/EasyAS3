/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.easyas3.utils.ColorUtil;
	import org.easyas3.vinci.events.PixelMouseEvent;
	
	/**
	 * 像素级交互位图动画代理
	 * @author Jerry 
	 */	
	public class PixelInteractiveBitmapMovieProxy
	{
		/**
		 * 鼠标事件集合
		 * @private
		 */
		private static const MOUSE_EVENTS:Object = { };
		
		MOUSE_EVENTS[MouseEvent.CLICK] = PixelMouseEvent.CLICK;											//鼠标单击事件
		MOUSE_EVENTS[MouseEvent.DOUBLE_CLICK] = PixelMouseEvent.DOUBLE_CLICK;				//鼠标双击事件
		MOUSE_EVENTS[MouseEvent.MOUSE_DOWN] = PixelMouseEvent.MOUSE_DOWN;				//鼠标按键按下事件
		MOUSE_EVENTS[MouseEvent.MOUSE_MOVE] = PixelMouseEvent.MOUSE_MOVE;					//鼠标移动事件
		MOUSE_EVENTS[MouseEvent.MOUSE_UP] = PixelMouseEvent.MOUSE_UP;							//鼠标按键弹起事件
		
		/**
		 * 坐标点
		 * @private
		 */
		private static var point:Point = new Point();
		
		/**
		 * 位图动画
		 * @private
		 */
		private var _bitmapMovie:BitmapMovieBase;
		
		/**
		 * 最小Alpha通道值
		 * @private
		 */
		private var _alphaThreshold:uint;
		
		/**
		 * 鼠标在对象中标识
		 * @private
		 */
		private var _mouseIn:Boolean;
		
		/**
		 * 是否支持鼠标Roll事件
		 * @private
		 */
		private var _rollEnabled:Boolean = true;
		
		/**
		 * 构造函数
		 * @param	bitmapMovie:Sprite — 位图动画
		 */
		public function PixelInteractiveBitmapMovieProxy(bitmapMovie:BitmapMovieBase)
		{
			if (bitmapMovie == null)
			{
				throw "bitmapMovie can not be null !";
			}
			
			_bitmapMovie = bitmapMovie;
			
			for (var key:String in MOUSE_EVENTS) 
			{
				bitmapMovie.addEventListener(key, commonMouseEventHandler);
			}
		}
		
		/**
		 * 位图对象
		 */
		public function get bitmap():Bitmap 
		{
			return _bitmapMovie?_bitmapMovie.bitmap:null;
		}
		
		/**
		 * 最小Alpha通道值
		 */
		public function get alphaThreshold():uint 
		{
			return _alphaThreshold / 255;
		}
		
		/**
		 * 最小Alpha通道值
		 */
		public function set alphaThreshold(value:uint):void 
		{
			_alphaThreshold = value * 255;
		}
		
		/**
		 * 是否支持鼠标Roll事件
		 */
		public function get rollEnabled():Boolean 
		{
			return _rollEnabled;
		}
		
		/**
		 * 是否支持鼠标Roll事件
		 */
		public function set rollEnabled(value:Boolean):void 
		{
			_rollEnabled = value;
		}
		
		/**
		 * 鼠标在对象中标识
		 */
		public function set mouseIn(value:Boolean):void 
		{
			var mouseEventType:String;
			
			if (value == _mouseIn)
			{
				return;
			}
			
			_mouseIn = value;
			
			mouseEventType = _mouseIn?PixelMouseEvent.ROLL_OVER:PixelMouseEvent.ROLL_OUT;
			_bitmapMovie.dispatchEvent(new PixelMouseEvent(mouseEventType, _bitmapMovie.mouseX, _bitmapMovie.mouseY));
		}
		
		/**
		 * 初始化
		 */
		public function initialize():void 
		{
			this.alphaThreshold * 0.01;
			mouseIn = false;
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	index:int — 帧索引
		 */
		public function gotoFrameIndex(index:int):void 
		{
			if (_rollEnabled)
			{
				//判断是否支持鼠标Roll事件则检测ROLL_OVER和ROLL_OUT事件是否触发
				checkMouseInOut();
			}
		}
		
		/**
		 * 检测坐标点是否为透明颜色
		 * @param	x:int — x轴位移值
		 * @param	y:int — y轴位移值
		 * @return	Boolean — 如果坐标点为透明则为true，否则为false。
		 */
		public function isPointTransparent(x:int, y:int):Boolean 
		{
			return ColorUtil.getAlpha(bitmap.bitmapData.getPixel32(x, y)) <= _alphaThreshold;
		}
		
		/**
		 * 计算显示对象，以确定它是否与x和y参数指定的点重叠或相交。x和y时舞台坐标空间中的点。
		 * @param	x:Number — 要测试的此对象的x轴坐标
		 * @param	y:Number — 要测试的此对象的y轴坐标
		 * @param	shapeFlag:Boolean (default = false) — 是检查对象的实际像素（true），还是检查边框的实际像素（false）
		 * @return Boolean — 如果显示对象与指定的点重叠或相交则为true，否则为false。
		 */
		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean 
		{
			if (shapeFlag)
			{
				point.x = x;
				point.y = y;
				point = bitmap.globalToLocal(point);
					
				return !isPointTransparent(point.x, point.y);
			}
			else
			{
				return _bitmapMovie.hitTestPoint(x, y, shapeFlag);
			}
		}
		
		/**
		 * 检测鼠标是在对象内部还是外部
		 */
		public function checkMouseInOut():void 
		{
			mouseIn = !isPointTransparent(bitmap.mouseX, bitmap.mouseY);
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			//移除事件监听
			for each (var key:String in MOUSE_EVENTS) 
			{
				_bitmapMovie.removeEventListener(key, commonMouseEventHandler);
			}
		}
		
		/**
		 * 通用鼠标事件监听
		 * @private
		 * @param	e:MouseEvent — 鼠标事件对象
		 */
		private function commonMouseEventHandler(e:MouseEvent):void 
		{
			if (!isPointTransparent(bitmap.mouseX, bitmap.mouseY))
			{
				_bitmapMovie.dispatchEvent(new PixelMouseEvent(MOUSE_EVENTS[e.type], _bitmapMovie.mouseX, _bitmapMovie.mouseY));
			}
		}
	}
}
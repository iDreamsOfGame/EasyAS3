/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.easyas3.utils.ColorUtil;
	import org.easyas3.vinci.events.PixelMouseEvent;
	
	/**
	 * 像素级交互位图动画对象
	 * @author Jerry
	 */
	public class PixelInteractiveBitmapMovie extends BitmapMovie
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
		 * @param	frames:Vector.<BitmapFrameInfo> (default = null) — 位图动画帧信息序列
		 */
		public function PixelInteractiveBitmapMovie(frames:Vector.<BitmapFrameInfo>=null)
		{
			super(frames);
			
			for (var key:String in MOUSE_EVENTS) 
			{
				addEventListener(key, commonMouseEventHandler);
			}
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
			
			dispatchEvent(new PixelMouseEvent(mouseEventType, mouseX, mouseY));
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
		 * 计算显示对象，以确定它是否与x和y参数指定的点重叠或相交。x和y时舞台坐标空间中的点。
		 * @param	x:Number — 要测试的此对象的x轴坐标
		 * @param	y:Number — 要测试的此对象的y轴坐标
		 * @param	shapeFlag:Boolean (default = false) — 是检查对象的实际像素（true），还是检查边框的实际像素（false）
		 * @return Boolean — 如果显示对象与指定的点重叠或相交则为true，否则为false。
		 */
		override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean 
		{
			if (shapeFlag)
			{
				point.x = x;
				point.y = y;
				
				point = _bmp.globalToLocal(point);
				
				return !isPointTransparent(point.x, point.y);
			}
			else
			{
				return super.hitTestPoint(x, y, shapeFlag);
			}
		}
		
		/**
		 * 初始化
		 */
		override public function reset():void 
		{
			initialize();
		}
		
		/**
		 * 销毁对象
		 */
		override public function dispose():void 
		{
			super.dispose();
			
			//移除事件监听
			for each (var key:String in MOUSE_EVENTS) 
			{
				removeEventListener(key, commonMouseEventHandler);
			}
		}
		
		/**
		 * 初始化
		 */
		override protected function initialize():void 
		{
			super.initialize();
			
			this.alphaThreshold * 0.01;
			mouseIn = false;
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	index:int — 帧索引
		 */
		override protected function gotoFrameIndex(index:int):void 
		{
			super.gotoFrameIndex(index);
			
			if (_rollEnabled)
			{
				//判断是否支持鼠标Roll事件则检测ROLL_OVER和ROLL_OUT事件是否触发
				checkMouseInOut();
			}
		}
		
		/**
		 * 检测坐标点是否为透明颜色
		 * @private
		 * @param	x:int — x轴位移值
		 * @param	y:int — y轴位移值
		 * @return	Boolean — 如果坐标点为透明则为true，否则为false。
		 */
		private function isPointTransparent(x:int, y:int):Boolean 
		{
			return ColorUtil.getAlpha(_bmp.bitmapData.getPixel32(x, y)) <= _alphaThreshold;
		}
		
		/**
		 * 检测鼠标是在对象内部还是外部
		 * @private
		 */
		private function checkMouseInOut():void 
		{
			mouseIn = !isPointTransparent(_bmp.mouseX, _bmp.mouseY);
		}
		
		/**
		 * 通用鼠标事件监听
		 * @private
		 * @param	e:MouseEvent — 鼠标事件对象
		 */
		private function commonMouseEventHandler(e:MouseEvent):void 
		{
			if (!isPointTransparent(_bmp.mouseX, _bmp.mouseY))
			{
				dispatchEvent(new PixelMouseEvent(MOUSE_EVENTS[e.type], mouseX, mouseY));
			}
		}
	}
}
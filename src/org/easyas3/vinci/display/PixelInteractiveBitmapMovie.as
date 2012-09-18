/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display
{
	
	/**
	 * 像素级交互位图动画对象
	 * @author Jerry
	 */
	public class PixelInteractiveBitmapMovie extends BitmapMovie
	{
		/**
		 * 像素级交互代理
		 * @private
		 */
		private var _proxy:PixelInteractiveBitmapMovieProxy;
		
		/**
		 * 构造函数
		 * @param	frames:Vector.<BitmapFrameInfo> (default = null) — 位图动画帧信息序列
		 */
		public function PixelInteractiveBitmapMovie(frames:Vector.<BitmapFrameInfo> = null)
		{
			super(frames);
			
			_proxy = new PixelInteractiveBitmapMovieProxy(this);
			_proxy.initialize();
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
			return _proxy.hitTestPoint(x, y);
		}
		
		/**
		 * 是否支持鼠标Roll事件
		 */
		public function get rollEnabled():Boolean 
		{
			return _proxy.rollEnabled;
		}
		
		/**
		 * 是否支持鼠标Roll事件
		 */
		public function set rollEnabled(value:Boolean):void 
		{
			_proxy.rollEnabled = value;
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
		}
		
		/**
		 * 初始化
		 */
		override protected function initialize():void 
		{
			super.initialize();
			
			if(_proxy)
			{
				_proxy.initialize();
			}
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	index:int — 帧索引
		 */
		override public function gotoFrameIndex(index:int):void 
		{
			super.gotoFrameIndex(index);
			
			_proxy.gotoFrameIndex(index);
		}
	}
}
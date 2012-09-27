/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import org.easyas3.vinci.VinciPixelInteractiveContext;
	
	/**
	 * 像素级精灵序列图位图动画
	 * @author Jerry 
	 */	
	public class PixelInteractiveSpriteSheetBitmapMovie extends SpriteSheetBitmapMovie implements IPixelInteractiveBitmap
	{
		/**
		 * 像素级交互代理
		 * @private
		 */
		private var _proxy:PixelInteractiveBitmapMovieProxy;
		
		/**
		 * 构造函数
		 * @param	spriteSheetBmpInfo:SpriteSheetBitmapInfo — 精灵序列图位图数据信息
		 * @param	frameRate:Number (default = NaN) — 帧速率
		 * @param	direction:String (default = "horizontal") — 精灵序列图布局方向
		 * @param	centerPointPosition:String (default = "center") — 位图动画中心点位置
		 */
		public function PixelInteractiveSpriteSheetBitmapMovie(spriteSheetBmpInfo:SpriteSheetBitmapInfo = null, frameRate:Number = NaN, direction = "horizontal", centerPointPosition:String = "center")
		{
			_proxy = new PixelInteractiveBitmapMovieProxy(this);
			_proxy.initialize();
			
			super(spriteSheetBmpInfo, frameRate, direction, centerPointPosition);
			
			pixelInteractiveContext.addPixelInteractiveBitmapMovie(this);
		}
		
		/**
		 * Vinci渲染引擎像素级交互控制器
		 */
		public function get pixelInteractiveContext():VinciPixelInteractiveContext 
		{
			return VinciPixelInteractiveContext.getInstance();
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
		 * 检测鼠标是否在动画上
		 */
		public function checkMouseInOut():void 
		{
			_proxy.checkMouseInOut();
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
			
			pixelInteractiveContext.removePixelInteractiveBitmapMovie(this);
			_proxy.dispose();
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
	}
}
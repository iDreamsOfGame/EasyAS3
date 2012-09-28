/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-27 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.display.pixel
{
	import flash.display.Sprite;
	
	/**
	 * ... 像素级交互Sprite对象 ...
	 * @author Jerry
	 */
	public class PixelInteractiveSprite extends Sprite implements IPixelInteractiveDisplayObject
	{
		/**
		 * 像素级交互代理对象
		 * @private
		 */
		private var _pixelInteractiveProxy:PixelInteractiveDisplayObjectProxy;
		
		/**
		 * 构造函数
		 */
		public function PixelInteractiveSprite()
		{
			super();
			
			//初始化代理对象
			_pixelInteractiveProxy = new PixelInteractiveDisplayObjectProxy(this);
		}
		
		/**
		 * 指示是否支持原生鼠标交互
		 */
		public function set originalMouseEnabled(value:Boolean):void 
		{
			super.mouseEnabled = value;
		}
		
		/**
		 * 指定此对象是否接收鼠标或其他用户输入、消息
		 */
		override public function set mouseEnabled(value:Boolean):void 
		{
			_pixelInteractiveProxy.mouseEnabled = super.mouseEnabled = value;
		}
		
		/**
		 * 指定一个 sprite 用作另一个 sprite 的点击区域。
		 */
		override public function set hitArea(value:Sprite):void 
		{
			_pixelInteractiveProxy.hitArea = super.hitArea = value;
		}
		
		/**
		 * 指定此对象是否使用像素级交互
		 */
		public function get pixelIntactiveEnabled():Boolean 
		{
			return _pixelInteractiveProxy.pixelIntactiveEnabled;
		}
		
		/**
		 * 指定此对象是否使用像素级交互
		 */
		public function set pixelIntactiveEnabled(value:Boolean):void 
		{
			_pixelInteractiveProxy.pixelIntactiveEnabled = value;
		}
		
		/**
		 * 透明度阀值
		 */
		public function get alphaThreshold():uint 
		{
			return _pixelInteractiveProxy.alphaThreshold;
		}
		
		/**
		 * 透明度阀值
		 */
		public function set alphaThreshold(value:uint):void 
		{
			_pixelInteractiveProxy.alphaThreshold = value;
		}
	}
}
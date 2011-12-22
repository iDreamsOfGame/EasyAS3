package org.easyas3.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.easyas3.utils.DisplayObjectProxy;
	
	/**
	 * ... 位图对象基类 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class BitmapBase extends Bitmap implements IDisplayObject 
	{
		/**
		 * 显示对象代理
		 */
		protected var displayObjProxy:DisplayObjectProxy;
		
		/**
		 * 构造函数
		 * @param	bitmapData
		 * @param	pixelSnapping
		 * @param	smoothing
		 * @param	autoDispose
		 */
		public function BitmapBase(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false, autoDispose:Boolean = false) 
		{
			super(bitmapData, pixelSnapping, smoothing);
			displayObjProxy = new DisplayObjectProxy(this, autoDispose);
		}
		
		/**
		 * 添加事件监听
		 * @param	type
		 * @param	listener
		 * @param	useCapture
		 * @param	priority
		 * @param	useWeakReference
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if (displayObjProxy)
			{
				displayObjProxy.addEventListener(type, listener, useCapture);
			}
			
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * 移除事件监听
		 * @param	type
		 * @param	listener
		 * @param	useCapture
		 */
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if (displayObjProxy)
			{
				displayObjProxy.removeEventListener(type, listener, useCapture);
			}
			
			super.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * 销毁对象方法
		 */
		public function dispose():void 
		{
			if (displayObjProxy)
			{
				displayObjProxy.disposeDisplayObj();
			}
		}
		
	}

}
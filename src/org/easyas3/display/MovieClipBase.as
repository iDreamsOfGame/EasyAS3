package org.easyas3.display 
{
	import flash.display.MovieClip;
	import org.easyas3.utils.DisplayObjectContainerProxy;
	
	/**
	 * ... MovieClip基类 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class MovieClipBase extends MovieClip implements IDisplayObjectContainer
	{
		/**
		 * 显示容器对象代理
		 */
		protected var containerProxy:DisplayObjectContainerProxy;
		
		/**
		 * 构造函数
		 * @param	autoDispose:Boolean (default = false)
		 */
		public function MovieClipBase(autoDispose:Boolean = false) 
		{
			containerProxy = new DisplayObjectContainerProxy(this, autoDispose);
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
			if (containerProxy)
			{
				containerProxy.addEventListener(type, listener, useCapture);
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
			containerProxy.removeEventListener(type, listener, useCapture);
			super.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * 对象销毁
		 */
		public function dispose():void 
		{
			if (containerProxy)
			{
				containerProxy.disposeDisplayObj();
			}
		}
		
		/**
		 * 移除子显示对象
		 */
		public function clear():void 
		{
			if (containerProxy)
			{
				containerProxy.clear();
			}
		}
	}

}
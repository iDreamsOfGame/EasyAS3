package org.easyas3.utils 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ... 显示对象代理 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class DisplayObjectProxy extends Object
	{
		/**
		 * 显示对象
		 */
		protected var displayObj:DisplayObject;
		
		/**
		 * 自动销毁显示对象标识
		 */
		protected var autoDispose:Boolean;
		
		/**
		 * 事件监听列表
		 */
		protected var listenersList:Vector.<Object>;
		
		/**
		 * 构造函数
		 * @param	displayObj:DisplayObject (default = null) —— 显示对象
		 * @param	autoDispose:Boolean (default = true) —— 自动销毁显示对象标识
		 */
		public function DisplayObjectProxy(displayObj:DisplayObject = null, autoDispose:Boolean = true) 
		{
			this.displayObj = displayObj;
			this.autoDispose = autoDispose;
			listenersList = new Vector.<Object>;
			displayObj.addEventListener(Event.REMOVED, displayObjRemovedHandler);
		}
		
		/**
		 * 显示对象从显示列表中移除事件
		 * @param	e
		 */
		protected function displayObjRemovedHandler(e:Event):void 
		{
			if (autoDispose)
			{
				disposeDisplayObj();
			}
		}
		
		/**
		 * 添加事件监听到列表
		 * @param	type
		 * @param	listener
		 * @param	useCapture
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			listenersList.push( { type:type, listener:listener, useCapture:useCapture } );
		}
		
		/**
		 * 从列表移除事件监听
		 * @param	type
		 * @param	listener
		 * @param	useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			var eventListener:Object;
			
			for (var i:int = 0, l:int = listenersList.length; i < l; i++) 
			{
				eventListener = listenersList[i];
				
				if (eventListener.type == type && eventListener.listener == listener && eventListener.useCapture == useCapture)
				{
					listenersList.splice(i, 1);
					return;
				}
			}
		}
		
		/**
		 * 销毁显示对象
		 */
		public function disposeDisplayObj():void 
		{
			var eventListener:Object;
			
			//销毁第一步：先移除所有事件监听
			addEventListener(Event.REMOVED, displayObjRemovedHandler);
			for (var i:int = 0, l:int = listenersList.length; i < l; i++) 
			{
				eventListener = listenersList[i];
				displayObj.removeEventListener(eventListener.type, eventListener.listener, eventListener.useCapture);
				l--;
			}
			
			//第二步：销毁所有动态属性
			for (var prop:String in displayObj)
			{
				delete displayObj[prop];
			}
		}
	}

}
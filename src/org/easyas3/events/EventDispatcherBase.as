package org.easyas3.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ... EasyEventDispatcher 类是可分派EasyEvent事件的所有运行时类的基类。...
	 * @author Jerry ...
	 */
	public class EventDispatcherBase extends EventDispatcher
	{
		/**
		 * 构造函数
		 * @param	target:IEventDispatcher (default = null) —— 分派到 EventDispatcher 对象的事件的目标对象。
		 */
		public function EventDispatcherBase(target:IEventDispatcher = null)
		{
			super(target);
		}
	}

}


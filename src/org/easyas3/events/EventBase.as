package org.easyas3.events
{
	import flash.events.Event;
	
	/**
	 * ... EasyAS3类库事件基类 ...
	 * @author Jerry
	 * @version 0.1.2
	 */
	public class EventBase extends Event
	{
		
		/** @private 数据对象 */
		private var _data:Object;
		
		/**
		 * 构造函数
		 * @param	type:String —— 事件类型
		 * @param	data:Object (default = null) —— 数据对象
		 * @param	bubbles:Boolean (default = false) —— 是否冒泡
		 * @param	cancelable:Boolean (default = false) —— 是否可以取消事件
		 */
		public function EventBase(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		/** 获取数据对象 */
		public function get data() : Object
		{
			return _data;
		}
	}

}


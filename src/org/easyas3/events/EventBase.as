/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.events
{
	import flash.events.Event;
	
	/**
	 * EasyAS3类库事件基类
	 * @author Jerry
	 */
	public class EventBase extends Event
	{
		
		/**
		 * 事件传递携带的数据对象
		 * @private
		 */
		private var _data:Object;
		
		/**
		 * 构造函数
		 * @param	type:String — 事件类型
		 * @param	data:Object (default = null) — 事件传递携带的数据对象
		 * @param	bubbles:Boolean (default = false) — 是否冒泡
		 * @param	cancelable:Boolean (default = false) — 是否可以取消事件
		 */
		public function EventBase(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		/**
		 * 事件传递携带的数据对象
		 */
		public function get data() : Object
		{
			return _data;
		}
	}

}


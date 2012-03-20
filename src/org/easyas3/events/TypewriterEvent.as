package org.easyas3.events 
{
	/**
	 * ... 打字机事件 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class TypewriterEvent extends EventBase 
	{
		/**
		 * 打字效果完成
		 */
		public static const TYPE_COMPLETE:String = "typeComplete";
		
		/**
		 * 构造函数
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function TypewriterEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, data, bubbles, cancelable);
		}
	}

}
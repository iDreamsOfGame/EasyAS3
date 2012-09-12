/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.events 
{
	/**
	 * 打字机事件
	 * @author Jerry
	 */
	public class TypewriterEffectEvent extends EventBase 
	{
		/**
		 * 打字效果完成
		 */
		public static const TYPE_COMPLETE:String = "typeComplete";
		
		/**
		 * 构造函数
		 * @param	type:String — 事件类型
		 * @param	data:Object (default = null) — 事件携带数据对象
		 */
		public function TypewriterEffectEvent(type:String, data:Object = null) 
		{
			super(type, data, false, false);
		}
	}

}
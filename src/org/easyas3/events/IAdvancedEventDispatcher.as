/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.events
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 高级事件调度接口
	 * @author Jerry 
	 */	
	public interface IAdvancedEventDispatcher extends IEventDispatcher
	{
		/**
		 * 销毁对象
		 */
		function dispose():void;
	}
}
/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.pool 
{
	import org.easyas3.events.IAdvancedEventDispatcher;
	
	/**
	 * 池对象接口
	 * @author Jerry
	 */
	public interface IPoolObject extends IAdvancedEventDispatcher
	{
		/**
		 * 使用中标识
		 */
		function get using():Boolean;
		
		/**
		 * 使用中标识
		 */
		function set using(value:Boolean):void;
		
		/**
		 * 池对象克隆方法
		 * @return IPoolObject — 克隆的池对象
		 */
		function clone():IPoolObject;
		
		/**
		 * 重置对象属性
		 */
		function reset():void;
	}
	
}
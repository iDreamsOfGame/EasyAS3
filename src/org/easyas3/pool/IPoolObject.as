package org.easyas3.pool 
{
	
	/**
	 * ... 池对象接口 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public interface IPoolObject 
	{
		/**
		 * 使用中标识 - getter方法
		 */
		function get using():Boolean;
		
		/**
		 * 使用中标识 - setter方法
		 */
		function set using(value:Boolean):void;
		
		/**
		 * 池对象克隆方法
		 * @return
		 */
		function clone():IPoolObject;
		
		/**
		 * 重置对象属性
		 */
		function reset():void;
		
		/**
		 * 销毁对象
		 */
		function dispose():void;
	}
	
}
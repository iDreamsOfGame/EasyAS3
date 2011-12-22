package org.easyas3.display 
{
	
	/**
	 * ... 显示容器对象接口 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public interface IDisplayObjectContainer extends IDisplayObject
	{
		/**
		 * 移除子显示对象
		 */
		function clear():void;
	}
	
}
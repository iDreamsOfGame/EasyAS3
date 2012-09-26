/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-26 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci 
{
	
	/**
	 * ... 渲染器接口 ...
	 * @author Jerry
	 */
	public interface IRenderer 
	{
		/**
		 * 动画帧频
		 */
		function get frameRate():Number
		
		/**
		 * 渲染
		 */
		function render():void;
	}
	
}
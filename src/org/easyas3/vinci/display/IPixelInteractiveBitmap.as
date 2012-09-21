/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-20 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import org.easyas3.pool.IPoolObject;
	import org.easyas3.vinci.VinciPixelInteractiveContext;
	
	/**
	 * 像素级交互位图动画接口
	 * @author Jerry 
	 */	
	public interface IPixelInteractiveBitmap extends IPoolObject
	{
		/**
		 * Vinci渲染引擎像素级交互控制器
		 */
		function get pixelInteractiveContext():VinciPixelInteractiveContext;
		
		/**
		 * 是否支持鼠标Roll事件 
		 */		
		function get rollEnabled():Boolean;
		
		/**
		 *  是否支持鼠标Roll事件
		 */		
		function set rollEnabled(value:Boolean):void;
		
		/**
		 * 检测鼠标是否在动画上
		 */
		function checkMouseInOut():void;
	}
}
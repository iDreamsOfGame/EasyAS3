/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.preloaders 
{
	import org.easyas3.events.IAdvancedEventDispatcher;
	
	/**
	 * 预加载器接口
	 * @author Jerry
	 */
	public interface IPreloader extends IAdvancedEventDispatcher
	{
		/**
		 * 开始播放预载动画
		 */
		function play():void;
		
		/**
		 * 预载进度
		 */
		function get progress():Number;
		
		/**
		 * 预载进度
		 */
		function set progress(value:Number):void;
		
		/**
		 * 停止播放预载动画
		 */
		function stop():void;
	}
	
}
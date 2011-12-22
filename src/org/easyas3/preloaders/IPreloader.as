package org.easyas3.preloaders 
{
	
	/**
	 * ... 预加载器接口 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public interface IPreloader 
	{
		/**
		 * 开始播放预载动画
		 */
		function play():void;
		
		/**
		 * 预载进度 - getter方法
		 */
		function get progress():Number;
		
		/**
		 * 预载进度 - setter方法
		 */
		function set progress(value:Number):void;
		
		/**
		 * 停止播放预载动画
		 */
		function stop():void;
	}
	
}
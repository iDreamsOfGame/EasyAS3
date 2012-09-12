/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.preloaders 
{
	import flash.display.Sprite;
	
	/**
	 * 预载器基类
	 * @author Jerry
	 */
	public class Preloader extends Sprite implements IPreloader 
	{
		/**
		 * 预载进度，取值范围从0到1
		 */
		protected var _progress:Number = 0;
		
		/**
		 * 构造函数
		 */
		public function Preloader() 
		{
			super();
			
		}
		
		/**
		 * 预载进度
		 */
		public function get progress():Number 
		{
			return _progress;
		}
		
		/**
		 * 预载进度
		 */
		public function set progress(value:Number):void 
		{
			_progress = value;
		}
		
		/**
		 * 播放预载动画
		 */
		public function play():void 
		{
			
		}
		
		/**
		 * 停止播放动画
		 */
		public function stop():void 
		{
			
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			
		}
	}

}
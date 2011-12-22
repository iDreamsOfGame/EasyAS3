package org.easyas3.preloaders 
{
	import flash.display.Sprite;
	import org.easyas3.display.SpriteBase;
	
	/**
	 * ... 预载器基类 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class Preloader extends SpriteBase implements IPreloader 
	{
		/**
		 * 预载进度（范围[0, 1]）
		 */
		protected var _progress:Number = 0;
		
		/**
		 * 构造函数
		 */
		public function Preloader() 
		{
			super();
			
		}
		
		/* INTERFACE org.easyas3.preloaders.IPreloader */
		
		/**
		 * 播放预载动画
		 */
		public function play():void 
		{
			
		}
		
		/**
		 * 预载进度 - getter方法
		 */
		public function get progress():Number 
		{
			return _progress;
		}
		
		/**
		 * 预载进度 - setter方法
		 */
		public function set progress(value:Number):void 
		{
			_progress = value;
		}
		
		/**
		 * 停止播放动画
		 */
		public function stop():void 
		{
			
		}
	}

}
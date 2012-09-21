/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-20 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	import org.easyas3.utils.StringUtil;
	import org.easyas3.vinci.display.BitmapMovie;
	
	/**
	 * Vinci位图渲染引擎控制器
	 * @author Jerry 
	 */	
	public class VinciContext
	{
		/**
		 * 舞台对象
		 */
		public static var stage:Stage;
		
		/**
		 * 单例模式实例对象
		 * @private
		 */
		private static var _instance:VinciContext;
		
		/**
		 * 位图动画集合
		 * @private
		 */
		private var _movies:Vector.<BitmapMovie>;
		
		/**
		 * 时间差值
		 * @private
		 */
		private var _deltaTime:Number = 0;
		
		/**
		 * 上一次记录时间
		 * @private
		 */
		private var _lastTime:Number = 0;
		
		/**
		 * 构造函数
		 * @param	enforcer:SingletonEnforcer — 单例模式强制实现内部类
		 */
		public function VinciContext(enforcer:SingletonEnforcer)
		{
			if (enforcer == null)
			{
				throw "The class is designed by Singleton Pattern, please use getInstance method to get instance of this class. ";
			}
			
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * 帧频
		 */
		public function get frameRate():Number
		{
			return stage?stage.frameRate:24;
		}
		
		/**
		 * 帧频的一半
		 */
		public function get halfFrameRate():Number 
		{
			return frameRate >> 1;
		}
		
		/**
		 * 间隔时间
		 */
		public function get intervalTime():uint 
		{
			return StringUtil.MSEL_STEP / frameRate;
		}
		
		/**
		 * 获取单例模式实例对象
		 * @return	VinciContext — 单例模式实例对象
		 */
		public static function getInstance():VinciContext
		{
			return _instance?_instance:_instance = new VinciContext(new SingletonEnforcer());
		}
		
		/**
		 * 添加位图动画到字典中
		 * @param	bitmapMovie:BitmapMovie — 位图动画对象
		 */
		public function addBitmapMovie(bitmapMovie:BitmapMovie):void 
		{
			if (_movies == null)
			{
				_movies = new Vector.<BitmapMovie>();
			}
			
			_movies.push(bitmapMovie);
		}
		
		/**
		 * 从字典中移除位图动画
		 * @param	bitmapMovie
		 */
		public function removeBitmapMovie(bitmapMovie:BitmapMovie):void 
		{
			_movies.splice(_movies.indexOf(bitmapMovie), 1);
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			_movies = null;
			
			_instance = null;
		}
		
		/**
		 * 帧事件监听
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function enterFrameHandler(e:Event):void 
		{
			var realFrame:uint;
			var tweenFrames:uint;
			var nowTime:uint = getTimer();
			
			_deltaTime = nowTime - _lastTime;
			_lastTime = nowTime;
			realFrame = uint(StringUtil.MSEL_STEP / _deltaTime);			//上一帧的实际帧频
			
			if (realFrame >= halfFrameRate)
			{
				//正常播放
				render();
			}
			else
			{
				//补帧
				tweenFrames = frameRate / realFrame;
				
				for (var i:int = 0; i < tweenFrames; i++) 
				{
					render();
				}
			}
		}
		
		/**
		 * 渲染动画
		 * @private
		 */
		private function render():void 
		{
			for each (var movie:BitmapMovie in _movies) 
			{
				if (movie.isPlaying && movie.maxIndex)
				{
					movie.nextFrame();
				}
			}
		}
	}
}

/**
 * 单例模式强制实现内部类
 * @author Jerry 
 */	
internal class SingletonEnforcer
{
	
}
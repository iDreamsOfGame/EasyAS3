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
	import org.easyas3.vinci.display.IPixelInteractiveBitmap;
	
	/**
	 * Vinci渲染引擎像素级交互控制器
	 * @author Jerry 
	 */	
	public class VinciPixelInteractiveContext
	{
		/**
		 * 单例模式对象
		 * @private
		 */
		private static var _instance:VinciPixelInteractiveContext;
		
		/**
		 * 交互位图动画队列
		 * @private
		 */
		private var _movies:Vector.<IPixelInteractiveBitmap>;
		
		/**
		 * 构造函数
		 * @param	enforcer:SingletonEnforcer — 单例模式强制实现内部类
		 */
		public function VinciPixelInteractiveContext(enforcer:SingletonEnforcer)
		{
			if (enforcer == null)
			{
				throw "The class is designed by Singleton Pattern, please use getInstance method to get instance of this class. ";
			}
			
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * 舞台对象
		 */
		public function get stage():Stage 
		{
			return VinciContext.stage;
		}
		
		/**
		 * 获取单例模式对象
		 * @return	VinciPixelInteractiveContext — 单例对象
		 */
		public static function getInstance():VinciPixelInteractiveContext
		{
			return _instance?_instance:_instance = new VinciPixelInteractiveContext(new SingletonEnforcer());
		}
		
		/**
		 * 添加像素级交互位图动画到队列
		 * @param	bitmapMovie:IPixelInteractiveBitmap — 像素级交互位图动画对象
		 */
		public function addPixelInteractiveBitmapMovie(bitmapMovie:IPixelInteractiveBitmap):void 
		{
			if (_movies == null)
			{
				_movies = new Vector.<IPixelInteractiveBitmap>();
			}
			
			_movies.push(bitmapMovie);
		}
		
		/**
		 * 从队列中移除像素级交互位图动画
		 * @param	bitmapMovie:IPixelInteractiveBitmap — 像素级交互位图动画对象
		 */
		public function removePixelInteractiveBitmapMovie(bitmapMovie:IPixelInteractiveBitmap):void 
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
			for each (var movie:IPixelInteractiveBitmap in _movies) 
			{
				movie.checkMouseInOut();
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
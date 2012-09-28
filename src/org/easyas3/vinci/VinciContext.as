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
	
	/**
	 * Vinci位图渲染引擎控制器
	 * @author Jerry 
	 */	
	public class VinciContext implements IRenderer
	{
		/**
		 * 手动设置动画帧频
		 */
		public static var frameRate:Number;
		
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
		private var _movies:Vector.<IRenderer>;
		
		/**
		 * 渲染管理器
		 * @private
		 */
		private var _renderManager:VinciRenderManager;
		
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
			
			_renderManager = new VinciRenderManager(this);
		}
		
		/**
		 * 帧频，如果手动给frameRate赋值过，则返回之前赋值过的值，否则返回舞台对象的帧频。
		 */
		public function get frameRate():Number
		{
			return VinciContext.frameRate?VinciContext.frameRate:(stage?stage.frameRate:24);
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
		public function addBitmapMovie(bitmapMovie:IRenderer):void 
		{
			if (_movies == null)
			{
				_movies = new Vector.<IRenderer>();
			}
			
			_movies.push(bitmapMovie);
		}
		
		/**
		 * 从字典中移除位图动画
		 * @param	bitmapMovie
		 */
		public function removeBitmapMovie(bitmapMovie:IRenderer):void 
		{
			_movies.splice(_movies.indexOf(bitmapMovie), 1);
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			_renderManager.dispose();
			_renderManager = null;
			
			_movies = null;
			
			_instance = null;
		}
		
		/**
		 * 渲染动画
		 */
		public function render():void 
		{
			var movie:IRenderer;
			var length:int = _movies.length;
			
			for (var i:int = 0; i < length; i++) 
			{
				(_movies[i] as IRenderer).render();
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
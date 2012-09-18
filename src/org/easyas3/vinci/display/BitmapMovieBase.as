/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import org.easyas3.pool.IPoolObject;
	
	/**
	 * 位图动画基类
	 * @author Jerry 
	 */	
	public class BitmapMovieBase extends Sprite implements IPoolObject
	{
		/**
		 * 自定义数据
		 */
		protected var _data:Object;
		
		/**
		 * 位图对象
		 */
		protected var _bitmap:Bitmap;
		
		/**
		 * 动画是否在播放中
		 */
		protected var _isPlaying:Boolean;
		
		/**
		 * 对象使用中标识
		 */
		protected var _using:Boolean;
		
		/**
		 * 构造函数 
		 */		
		public function BitmapMovieBase()
		{
			super();
		}
		
		/**
		 * 自定义数据
		 */
		public function get data():Object 
		{
			return _data;
		}
		
		/**
		 * 自定义数据
		 */
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		/**
		 * 位图对象
		 */
		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
		/**
		 * 位图是否启用平滑处理
		 */
		public function get smoothing():Boolean 
		{
			return _bitmap?_bitmap.smoothing:false;
		}
		
		/**
		 * 位图是否启用平滑处理
		 */
		public function set smoothing(value:Boolean):void 
		{
			if (_bitmap != null)
			{
				_bitmap.smoothing = value;
			}
		}
		
		/**
		 * 动画是否在播放中
		 */
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		/**
		 * 标识对象是否从对象池中取出并正在使用
		 */
		public function get using():Boolean 
		{
			return _using;
		}
		
		/**
		 * 标识对象是否从对象池中取出并正在使用
		 */
		public function set using(value:Boolean):void 
		{
			_using = value;
		}
		
		/**
		 * 播放动画
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
		 * 从指定帧开始播放动画
		 * @param	frame:int — 帧数
		 */
		public function gotoAndPlay(frame:int):void 
		{
			
		}
		
		/**
		 * 将播放头移到动画指定帧并停在那里
		 * @param	frame:int — 帧数
		 */
		public function gotoAndStop(frame:int):void 
		{
			
		}
		
		/**
		 * 将播放头转到下一帧并停止
		 */
		public function nextFrame():void
		{
			
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	index:int — 帧索引
		 */
		public function gotoFrameIndex(index:int):void 
		{
			
		}
		
		/**
		 * 克隆对象
		 * @return IPoolObject — 对象池接口对象
		 */
		public function clone():IPoolObject
		{
			return null;
		}
		
		/**
		 * 重置对象属性
		 */
		public function reset():void 
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
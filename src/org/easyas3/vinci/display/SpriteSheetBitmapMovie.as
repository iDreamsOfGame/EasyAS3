/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import org.easyas3.pool.IPoolObject;
	import org.easyas3.vinci.utils.BitmapBuffer;
	
	/**
	 * 精灵序列图位图动画
	 * @author Jerry 
	 */	
	public class SpriteSheetBitmapMovie extends BitmapMovie implements IPoolObject
	{
		/**
		 * 精灵序列图位图二维数组
		 */
		protected var _spriteSheetBitmaps:Array;
		
		/**
		 * 精灵序列图布局方向
		 */
		protected var _direction:String;
		
		/**
		 * 组内播放模式
		 */
		protected var _groupPlayMode:Boolean;
		
		/**
		 * 构造函数
		 * @param	spriteSheetBitmaps:Array — 精灵序列图位图二维数组
		 * @param	direction:String — 精灵序列图布局方向
		 * @param	groupPalyMode:Boolean — 组内播放模式，如果为true则可实现组内播放，如果为false则使用默认的循环播放方式
		 */
		public function SpriteSheetBitmapMovie(spriteSheetBitmaps:Array, direction = "horizontal", groupPalyMode:Boolean = false)
		{
			_spriteSheetBitmaps = spriteSheetBitmaps;
			_direction = direction;
			_groupPlayMode = groupPalyMode;
			
			super(BitmapBuffer.generateFrames(spriteSheetBitmaps, direction));
		}
		
		/**
		 * 克隆对象方法
		 * @return	IPoolObject 对象池对象
		 */
		override public function clone():IPoolObject
		{
			return new SpriteSheetBitmapMovie(_spriteSheetBitmaps, _direction, _groupPlayMode);
		}
	}
}
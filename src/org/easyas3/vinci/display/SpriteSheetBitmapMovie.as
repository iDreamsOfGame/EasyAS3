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
		 * 精灵序列图位图数据信息
		 */
		protected var _spriteSheetBmpInfo:SpriteSheetBitmapInfo;
		
		/**
		 * 精灵序列图布局方向
		 */
		protected var _direction:String;
		
		/**
		 * 组内播放模式
		 */
		protected var _groupPlayMode:Boolean;
		
		/**
		 * 组索引
		 */
		protected var _groupIndex:int;
		
		/**
		 * 构造函数
		 * @param	spriteSheetBmpInfo:SpriteSheetBitmapInfo — 精灵序列图位图数据信息
		 * @param	direction:String — 精灵序列图布局方向
		 * @param	groupPalyMode:Boolean — 组内播放模式，如果为true则可实现组内播放，如果为false则使用默认的循环播放方式
		 */
		public function SpriteSheetBitmapMovie(spriteSheetBmpInfo:SpriteSheetBitmapInfo = null, direction = "horizontal", groupPalyMode:Boolean = false)
		{
			_spriteSheetBmpInfo = spriteSheetBmpInfo;
			_direction = direction;
			_groupPlayMode = groupPalyMode;
			 
			super(BitmapBuffer.generateFrames(spriteSheetBitmaps, row, column, direction));
		}
		
		/**
		 * 克隆对象方法
		 * @return	IPoolObject 对象池对象
		 */
		override public function clone():IPoolObject
		{
			return new SpriteSheetBitmapMovie(_spriteSheetBmpInfo, _direction, _groupPlayMode);
		}
		
		/**
		 * 精灵序列图布局方向
		 */
		public function get direction():String 
		{
			return _direction;
		}
		
		/**
		 * 组内播放模式
		 */
		public function get groupPlayMode():Boolean 
		{
			return _groupPlayMode;
		}
		
		/**
		 * 组索引
		 */
		public function get groupIndex():int 
		{
			return _groupIndex;
		}
		
		/**
		 * 组索引
		 */
		public function set groupIndex(value:int):void 
		{
			_groupIndex = value;
			
			//播放该组内容
		}
		
		/**
		 * 精灵序列图位图二维数组
		 */
		public function get spriteSheetBitmaps():Array 
		{
			return _spriteSheetBmpInfo?_spriteSheetBmpInfo.spriteSheetBitmaps:null;
		}
		
		/**
		 * 行数
		 */
		public function get row():int 
		{
			return _spriteSheetBmpInfo?_spriteSheetBmpInfo.row:0;
		}
		
		/**
		 * 列数
		 */
		public function get column():int 
		{
			return _spriteSheetBmpInfo?_spriteSheetBmpInfo.column:0;
		}
	}
}
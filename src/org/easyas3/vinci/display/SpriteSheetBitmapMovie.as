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
		protected var _spriteSheetBmpInfo:SpriteSheetBitmap;
		
		/**
		 * 精灵序列图布局方向
		 */
		protected var _direction:String;
		
		/**
		 * 构造函数
		 * @param	spriteSheetBmpInfo:SpriteSheetBitmap — 精灵序列图位图数据信息
		 * @param	frameRate:Number (default = NaN) — 帧速率
		 * @param	direction:String (default = "horizontal") — 精灵序列图布局方向
		 * @param	centerPointPosition:String (default = "center") — 位图动画中心点位置
		 */
		public function SpriteSheetBitmapMovie(spriteSheetBmpInfo:SpriteSheetBitmap = null, frameRate:Number = NaN, direction:String = "horizontal", 
											   centerPointPosition:String = "center")
		{
			_spriteSheetBmpInfo = spriteSheetBmpInfo;
			_direction = direction;
			 
			super(BitmapBuffer.generateFrames(spriteSheetBitmaps, row, column, direction), frameRate, centerPointPosition);
		}
		
		/**
		 * 精灵序列图位图数据信息
		 */
		public function set spriteSheetBmpInfo(value:SpriteSheetBitmap):void 
		{
			_spriteSheetBmpInfo = value;
			
			if (_spriteSheetBmpInfo)
			{
				frames = BitmapBuffer.generateFrames(spriteSheetBitmaps, row, column, direction)
			}
		}
		
		/**
		 * 精灵序列图布局方向
		 */
		public function get direction():String 
		{
			return _direction;
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
		
		/**
		 * 克隆对象方法
		 * @return	IPoolObject 对象池对象
		 */
		override public function clone():IPoolObject
		{
			return new SpriteSheetBitmapMovie(_spriteSheetBmpInfo, _frameRate, _direction);
		}
	}
}
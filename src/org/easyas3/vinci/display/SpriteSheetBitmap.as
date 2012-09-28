/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import flash.display.BitmapData;
	
	/**
	 * Sprite Sheet位图信息
	 * @author Jerry 
	 */	
	public class SpriteSheetBitmap
	{
		/**
		 * 行数
		 * @private 
		 */		
		private var _row:int;
		
		/**
		 * 列数
		 * @private
		 */
		private var _column:int;
		
		/**
		 * 精灵位图宽度
		 * @private
		 */
		private var _spriteWidth:int;
		
		/**
		 * 精灵位图高度
		 * @private
		 */
		private var _spriteHeight:int;
		
		/**
		 * 有效宽度
		 * @private
		 */
		private var _validWidth:int;
		
		/**
		 * 有效高度
		 * @private
		 */
		private var _validHeight:int;
		
		/**
		 * 精灵位图二维数组
		 * @private
		 */
		private var _spriteSheetBitmaps:Array;
		
		/**
		 * 构造函数 
		 */		
		public function SpriteSheetBitmap()
		{
			
		}
		
		/**
		 * 行数
		 */
		public function get row():int 
		{
			return _row;
		}
		
		/**
		 * 行数
		 */
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		/**
		 * 列数
		 */
		public function get column():int 
		{
			return _column;
		}
		
		/**
		 * 列数
		 */
		public function set column(value:int):void 
		{
			_column = value;
		}
		
		/**
		 * 精灵位图宽度
		 */
		public function get spriteWidth():int 
		{
			return _spriteWidth;
		}
		
		/**
		 * 精灵位图宽度
		 */
		public function set spriteWidth(value:int):void 
		{
			_spriteWidth = value;
		}
		
		/**
		 * 精灵位图高度
		 */
		public function get spriteHeight():int 
		{
			return _spriteHeight;
		}
		
		/**
		 * 精灵位图高度
		 */
		public function set spriteHeight(value:int):void 
		{
			_spriteHeight = value;
		}
		
		/**
		 * 有效宽度
		 */
		public function get validWidth():int 
		{
			return _validWidth;
		}
		
		/**
		 * 有效宽度
		 */
		public function set validWidth(value:int):void 
		{
			_validWidth = value;
		}
		
		/**
		 * 有效高度
		 */
		public function get validHeight():int 
		{
			return _validHeight;
		}
		
		/**
		 * 有效高度
		 */
		public function set validHeight(value:int):void 
		{
			_validHeight = value;
		}
		
		/**
		 * 精灵位图二维数组
		 */
		public function get spriteSheetBitmaps():Array 
		{
			return _spriteSheetBitmaps;
		}
		
		/**
		 * 精灵位图二维数组
		 */
		public function set spriteSheetBitmaps(value:Array):void 
		{
			_spriteSheetBitmaps = value;
		}
	}
}
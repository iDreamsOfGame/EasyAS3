/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-27 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display 
{
	
	/**
	 * ... 精灵序列图组 ...
	 * @author Jerry
	 */
	public class SpriteSheetGoup 
	{
		/**
		 * 组名称，在同一个SpriteSheet中要保持唯一
		 */
		protected var _name:String;
		
		/**
		 * 行索引范围
		 */
		protected var _rowIndexRange:Array;
		
		/**
		 * 列索引范围
		 */
		protected var _columnIndexRange:Array;
		
		/**
		 * 构造函数
		 */
		public function SpriteSheetGoup() 
		{
			_rowIndexRange = [0, -1];
			_columnIndexRange = [0, -1];
		}
		
		/**
		 * 组名称
		 */
		public function get name():String 
		{
			return _name;
		}
		
		/**
		 * 组名称
		 */
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		/**
		 * 行索引范围
		 */
		public function set rowIndexRange(value:Array):void 
		{
			if (value != null)
			{
				_rowIndexRange = value;
			}
		}
		
		/**
		 * 列索引范围
		 */
		public function set columnIndexRange(value:Array):void 
		{
			if (value != null)
			{
				_columnIndexRange = value;
			}
		}
		
		/**
		 * 行索引起始值
		 */
		public function get startRowIndex():int
		{
			return _rowIndexRange[0];
		}
		
		/**
		 * 行索引结束值
		 */
		public function get endRowIndex():int
		{
			return _rowIndexRange[1];
		}
		
		/**
		 * 列索引起始值
		 */
		public function get startColumnIndex():int 
		{
			return _columnIndexRange[0];
		}
		
		/**
		 * 列索引结束值
		 */
		public function get endColumnIndex():int 
		{
			return _columnIndexRange[1];
		}
	}

}
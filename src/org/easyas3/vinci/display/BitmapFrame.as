/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display
{
	import flash.display.BitmapData;
	
	/**
	 * 位图影片帧信息
	 * @author Jerry 
	 */	
	public class BitmapFrame
	{
		/**
		 * x轴偏移值
		 * @private
		 */
		private var _x:Number;
		
		/**
		 * y轴偏移值
		 * @private
		 */
		private var _y:Number;
		
		/**
		 * 位图数据
		 * @private
		 */
		private var _bitmapData:BitmapData;
		
		/**
		 * 构造函数
		 * @param	x:Number (default = NaN) — x轴偏移值
		 * @param	y:Number (default = NaN) — y轴偏移值
		 * @param	bitmapData:BitmapData (default = null) — 位图数据
		 */		
		public function BitmapFrame(x:Number = NaN, y:Number = NaN, bitmapData:BitmapData = null)
		{
			_x = x;
			_y = y;
			_bitmapData = bitmapData;
		}
		
		/**
		 * x轴偏移值
		 */
		public function get x():Number 
		{
			return _x;
		}
		
		/**
		 * x轴偏移值
		 */
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		/**
		 * y轴偏移值
		 */
		public function get y():Number 
		{
			return _y;
		}
		
		/**
		 * y轴偏移值
		 */
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		/**
		 * 位图数据
		 */
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
		/**
		 * 位图数据
		 */
		public function set bitmapData(value:BitmapData):void 
		{
			_bitmapData = value;
		}
	}
}
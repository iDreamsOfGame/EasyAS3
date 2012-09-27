/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-27 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display 
{
	import flash.geom.Point;
	
	/**
	 * ... 位图动画中心点位置 ...
	 * @author Jerry
	 */
	public final class BitmapMovieCenterPointPosition 
	{
		/**
		 * 中心
		 */
		public static const CENTER:String = "center";
		
		/**
		 * 左上角
		 */
		public static const TOP_LEFT:String = "topLeft";
		
		/**
		 * 计算获取中心点在中心时坐标
		 * @param	width:int — 位图动画宽度
		 * @param	height:int — 位图动画高度
		 * @return
		 */
		public static function center(width:int, height:int):Point
		{
			return new Point();
		}
		
		/**
		 * 计算获取中心点在左上角时坐标
		 * @param	width:int — 位图动画宽度
		 * @param	height:int — 位图动画高度
		 * @return
		 */
		public static function topLeft(width:int, height:int):Point
		{
			return new Point( -width / 2, -height / 2);
		}
	}

}
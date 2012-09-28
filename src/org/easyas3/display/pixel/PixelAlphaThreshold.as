/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-28 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.display.pixel 
{
	/**
	 * ... 像素点透明度阀值 ...
	 * @author Jerry
	 */
	public final class PixelAlphaThreshold 
	{
		/**
		 * 透明度阀值最小值，当阀值为0时，程序将探测任何不完全透明的像素
		 */
		public static const MIN_VALUE:uint = 0;
		
		/**
		 * 透明度阀值最大值，阀值为255时，程序只探测不透明的像素
		 */
		public static const MAX_VALUE:uint = 255;
	}

}
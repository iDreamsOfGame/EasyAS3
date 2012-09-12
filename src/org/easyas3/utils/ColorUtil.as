/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-12 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.utils
{
	/**
	 * 颜色值工具类
	 * @author Jerry 
	 */	
	public final class ColorUtil
	{
		/**
		 * ARGB颜色值转换为RGB颜色值
		 * @param	argb:uint — 一个正整数值，ARGB所表示的颜色值
		 * @return	uint — 一个正整数值，RGB所表示的颜色值
		 */
		public static function getRGB(argb:uint):uint 
		{
			return (0xFFFFFF & argb);
		}
		
		/**
		 * RGB颜色值转换为ARGB颜色值
		 * @param	rgb:uint — 一个正整数值，RGB所表示的颜色值
		 * @param	alpha:uint — 一个正整数值，转换成ARGB所需增加的Alpha通道值
		 * @return	uint — 一个正整数值，ARGB所表示的颜色值
		 */
		public static function getARGB(rgb:uint, alpha:uint = 0xFF):uint
		{
			return (alpha << 24) | rgb;
		}
		
		/**
		 * 从ARPG颜色值中获取Alpha通道的颜色值
		 * @param	argb:uint — 一个正整数值，ARPG所表示的颜色值
		 * @return	uint — 一个正整数值，ARPG颜色值中Alpha通道所表示的颜色值
		 */
		public static function getAlpha(argb:uint):uint 
		{
			return (argb >> 24) & 0xFF;
		}
	}
}
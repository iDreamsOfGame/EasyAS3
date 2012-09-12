/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	import com.adobe.utils.ArrayUtil;
	
	/**
	 * 数组工具类
	 * @author Jerry
	 */
	public final class ArrayUtil extends com.adobe.utils.ArrayUtil
	{
		/**
		 * 生成指定长度的随机数数组
		 * @param	startNum:int (default = 1) — 开始数字
		 * @param	endNum:int (default = 10) — 结束数字
		 * @return	Array — 生成的随机数组
		 */
		public static function generateRandomNumbersList(startNum:int = 1, endNum:int = 10):Array
		{
			var source:Array = [];
			var list:Array = [];
			
			for(var i:int = startNum, l:int = endNum + 1; i < l; i++)
			{
				source.push(i);
			}
			
			while(source.length > 0)
			{
				var index:int = Math.floor(Math.random() * source.length);
				list.push(source[index]);
				source.splice(index, 1);
			}
			
			return list;
		}
		
		/**
		 * 从数组中获取不重复的随机对象
		 * @param	source:Array — 原数组
		 * @param	length:int (default = 1) — 获取对象的数量
		 * @return	Array — 无重复对象的随机数组
		 */
		public static function getRandomItemsFromArray(source:Array, length:int = 1):Array
		{
			var list:Array = [];
			var count:int;
			source = shallowCopy(source);
			
			while(source.length > 0 && count < length)
			{
				var index:int = Math.floor(Math.random() * source.length);
				list.push(source[index]);
				source.splice(index, 1);
				count++;
			}
			
			return list;
		}
		
		/**
		 * 数组浅复制
		 * @param	source:Array —— 数据源
		 * @return	Array — 复制的数组
		 */
		public static function shallowCopy(source:Array):Array
		{
			return source.concat();
		}
	}

}

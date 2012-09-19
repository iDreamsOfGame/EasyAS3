/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	
	/**
	 * 算术运算工具类
	 * @author Jerry
	 */
	public final class MathUtil
	{
		/**
		 * 快速获取输入数的绝对值（可以用来取代Math.abs方法，运算效率远高于Math.abs方法）
		 * @param	value:Number — 一个数字，输入值
		 * @return	int — 一个整数值，计算得到的输入数的绝对值
		 */
		public static function abs(value:Number):int
		{
			return (value ^ (value >> 31)) - (value >> 31);
		}
		
		/**
		 * 快速返回输入数的上限值（可以用来取代Math.ceil方法，运算效率远高于Math.ceil方法）
		 * @param	value:Number — 一个数字，输入值
		 * @return	int — 一个整数值，计算得到的输入数上限整数值
		 */
		public static function ceil(value:Number):int
		{
			return (value is int)?value >> 0:(value >> 0) + 1;
		}
		
		/**
		 * 快速返回输入数的下限值（可以用来取代Math.floor方法，运算效率远高于Math.floor方法）
		 * @param	value:Number — 一个数字，输入值
		 * @return	int — 一个整数值，计算得到的输入数下限整数值
		 */
		public static function floor(value:Number):int
		{
			return value >> 0;
		}
		
		/**
		 * 获取随机数
		 * @param	min:Number (default = 0) — 一个数字，随机数的最小值
		 * @param	max:Number (default = 1) 一 个数字，随机数的最大值
		 * @param	rounded:Boolean (default = true) — 一个布尔值，为true时对结果进行取整计算；为false时直接输出
		 * @return	Number — 一个数字，随机计算得到的数字
		 */
		public static function getRandomNum(min:Number = 0, max:Number = 1, rounded:Boolean = true):Number
		{
			return rounded ? round(Math.random() * (max - min) + min) : Math.random() * (max - min) + min;
		}
		
		/**
		 * 快速判断输入数值是否为偶数（相当于i = -i;）
		 * @param	value:int — 一个数字，输入值
		 * @return	Boolean — 一个布尔值，为true时，结果为偶数；为false时，结果为非偶数
		 */
		public static function isEven(value:int):Boolean
		{
			return (value & 1) == 0;
		}
		
		/**
		 * 快速判断输入数值是否为奇数
		 * @param	value:int — 一个数字，输入值
		 * @return	Boolean — 一个布尔值，为true时，结果为奇数；为false时，结果为非奇数
		 */
		public static function isOdd(value:int):Boolean
		{
			return (value & 1) == 1;
		}
		
		/**
		 * 快速取反
		 * @param	value:Number — 一个数字，输入值
		 * @return	int — 一个整数值，计算得到输入值的取反值
		 */
		public static function not(value:Number):int
		{
			return ~value + 1;
		}
		
		/**
		 * 快速返回输入数的四舍五入值（可以用来取代Math.round方法，运算效率远高于Math.round方法）
		 * @param	value:Number — 一个数字，输入值
		 * @return	int — 一个整数值，计算得到的输入数的四舍五入整数值
		 */
		public static function round(value:Number):int
		{
			var source:Number = value;
			var result:int = (value >> 0);
			var decimal:Number = source - result;
			return (decimal < 0.5) ? result : (++result);
		}
		
		/**
		 * 定点表示法返回数字 
		 * @param	value:Number — 一个数字，输入值
		 * @param	fractionDigits:uint (default = 2) — 一个数字，保留的小数位数，此数字范围在0-20
		 * @return	Number — 使用定点表示法表示的数字
		 */		
		public static function toFixed(value:Number, fractionDigits:uint = 2):Number
		{
			return Number(value.toFixed(fractionDigits));
		}
	}

}


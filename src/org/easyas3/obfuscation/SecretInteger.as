/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.obfuscation
{
	import org.easyas3.utils.MathUtil;

	/**
	 * 整数内存混淆
	 * @author Jerry 
	 */	
	public class SecretInteger
	{
		/**
		 * 基础值
		 * @private 
		 */		
		private var _baseValue:int;
		
		/**
		 * 随机值 
		 */		
		private var _randomValue:int;
		
		/**
		 * 构造函数
		 * @param value:int — 需要被混淆的整数
		 */		
		public function SecretInteger(value:int)
		{
			this.value = value;
		}
		
		/**
		 * 取值 
		 */		
		public function get value():int
		{
			return _baseValue + _randomValue;
		}
		
		/**
		 * 赋值 
		 */		
		public function set value(value:int):void
		{
			_randomValue = MathUtil.floor(Math.random() * value);
			_baseValue = value - _randomValue;
		}
	}
}
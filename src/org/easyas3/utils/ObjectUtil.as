/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 对象工具类
	 * @author Jerry
	 */
	public final class ObjectUtil
	{
		
		/**
		 * 克隆对象（深复制）
		 * @param source:Object — 源对象，克隆对象的主体
		 * @return * — 源对象的克隆对象
		 */
		public static function clone(source:Object):*
		{
			var bytes:ByteArray = new ByteArray();
			var className:String = getQualifiedClassName(source);
			var cls:Class = getDefinitionByName(className) as Class;
			
			registerClassAlias(className, cls);
			bytes.writeObject(source);
			bytes.position = 0;
			return bytes.readObject();
		}
		
		/**
		 * 判断对象是否为空
		 * @param	value:Object — 被检测对象。
		 * @return	Boolean — 布尔值，对象为空返回true；反之返回false。
		 */
		public static function isNull(value:Object):Boolean
		{
			return Boolean(value == null);
		}
	}

}


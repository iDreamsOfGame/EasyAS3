/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	import flash.external.ExternalInterface;
	
	/**
	 * 外部容器交互工具类
	 * @author Jerry
	 */
	public final class ExternalInterfaceUtil
	{
		/**
		 * 函数名称记录列表（用于注销已注册的接口方法）
		 * @private
		 */
		private static var recordList:Array;
		
		/**
		 * 注册外部容器调用ActionScript的接口方法，将closure设为null则可删除回调注册
		 * @param	functionName:String — 一个函数名称，JavaScript函数名称
		 * @param	closure:Function — 一个闭包函数，指定JavaScript调用的函数
		 */
		public static function addCallback(functionName:String, closure:Function):void
		{
			if(ExternalInterface.available)
			{
				try
				{
					ExternalInterface.addCallback(functionName, closure);
					
					if(closure != null)
					{
						addFunctionNameToList(functionName);
					}
					else
					{
						removeFunctionNameFromList(functionName);
					}
				}
				catch(e : Error)
				{
					throw "[异常错误]：" + e.message;
				}
				catch(e : SecurityError)
				{
					throw "[安全错误]：" + e.message;
				}
			}
			else
			{
				throw "[错误]：外部容器接口不可用！";
			}
		}
		
		/**
		 * ActionScript调用外部容器方法
		 * @param	functionName:String — 一个字符串，外部容器中被AS调用的函数名
		 * @param	...rest — 传递到容器函数中的参数
		 * @return	 * — 从容器接收的响应。如果调用失败，则会返回 null 并引发错误。
		 */
		public static function call(functionName:String, ... rest):*
		{
			if(ExternalInterface.available)
			{
				try
				{
					rest.splice(0, 0, functionName);
					return ExternalInterface.call.apply(null, rest);
				}
				catch(e : Error)
				{
					throw "[异常错误]：" + e.message;
				}
				catch(e : SecurityError)
				{
					throw "[安全错误]：" + e.message;
				}
			}
			else
			{
				throw "[错误]：外部容器接口不可用！";
			}
		}
		
		/**
		 * 删除所有的回调函数注册
		 */
		public static function clearClosureFromList():void
		{
			if(!recordList)
			{
				return;
			}
			
			for each(var funcName : String in recordList)
			{
				addCallback(funcName, null);
			}
			recordList = null;
		}
		
		/**
		 * 设置一个布尔值，指示FlashPlayer与容器之前是否可以传递错误异常信息
		 */
		public static function set marshallExceptions(value:Boolean):void
		{
			ExternalInterface.marshallExceptions = value;
		}
		
		/**
		 * 添加函数名称到列表中
		 * @private
		 * @param	functionName:String — 一个字符串，需添加列表中的函数名
		 */
		private static function addFunctionNameToList(functionName:String):void
		{
			if(!recordList)
			{
				recordList = [];
			}
			
			for each(var funcName : String in recordList)
			{
				if(funcName == functionName)
				{
					return;
				}
			}
			recordList.push(functionName);
		}
		
		/**
		 * 从列表中删除指定函数名称
		 * @param	functionName:String —  一个字符串，需添加列表中的函数名
		 */
		private static function removeFunctionNameFromList(functionName:String):void
		{
			if(!recordList)
			{
				return;
			}
			
			for(var i:int = 0, length:int = recordList.length; i < length; i++)
			{
				if(recordList[i] == functionName)
				{
					recordList.splice(i, 1);
					return;
				}
			}
		}
	}

}


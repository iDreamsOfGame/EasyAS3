/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 显示对象工具类
	 * @author Jerry 
	 */	
	public final class DisplayObjectUtil
	{
		/**
		 * 按显示对象类型递归查找子显示对象
		 * @param	container:DisplayObjectContainer — 父级容器
		 * @param	type:Class — 显示对象类型
		 * @return	Array — 包含指定显示对象类型的全部子显示对象数组
		 */
		public static function searchChild(container:DisplayObjectContainer, type:Class):Array
		{
			var child:DisplayObject;
			var childs:Array = [];
			var numChildren:int = container.numChildren;
			
			for (var i:int = 0; i < numChildren; i++) 
			{
				child = container.getChildAt(i);
				
				if (child is type)
				{
					childs.push(child);
				}
				else if (child is DisplayObjectContainer)
				{
					childs = childs.concat(searchChild(child as DisplayObjectContainer, type));
				}
			}
			
			return childs;
		}
	}
}
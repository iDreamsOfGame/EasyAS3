package org.easyas3.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ... 显示对象容器代理 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class DisplayObjectContainerProxy extends DisplayObjectProxy 
	{
		/**
		 * 构造函数
		 * @param	displayObj
		 * @param	autoDispose
		 */
		public function DisplayObjectContainerProxy(displayObj:DisplayObject = null, autoDispose:Boolean = true) 
		{
			super(displayObj, autoDispose);
		}
		
		/**
		 * 显示对象容器
		 */
		public function get displayObjContainer():DisplayObjectContainer 
		{
			return displayObj as DisplayObjectContainer;
		}
		
		/**
		 * 销毁显示对象
		 */
		override public function disposeDisplayObj():void 
		{
			//移除子显示对象
			clear();
			super.disposeDisplayObj();
		}
		
		/**
		 * 移除子显示对象
		 */
		public function clear():void 
		{
			while (displayObjContainer.numChildren > 0)
			{
				displayObjContainer.removeChildAt(0);
			}
		}
	}

}
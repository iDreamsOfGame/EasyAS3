/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 像素级别鼠标交互事件
	 * @author Jerry 
	 */	
	public class PixelMouseEvent extends MouseEvent
	{
		/**
		 * 定义 rollOver 事件对象的 type 属性值。
		 */
		public static const ROLL_OVER:String = "pixelMouseEventRollOver";
		
		/**
		 * 定义 rollOut 事件对象的 type 属性值。
		 */
		public static const ROLL_OUT:String = "pixelMouseEventRollOut";
		
		/**
		 * 定义 mouseDown 事件对象的 type 属性值。
		 */
		public static const MOUSE_DOWN:String = "pixelMouseEventMouseDown";
		
		/**
		 * 定义 mouseUp 事件对象的 type 属性值。
		 */
		public static const MOUSE_UP:String = "pixelMouseEventMouseUp";
		
		/**
		 * 定义 mouseMove 事件对象的 type 属性值。
		 */
		public static const MOUSE_MOVE:String = "pixelMouseEventMouseMove";
		
		/**
		 * 定义 click 事件对象的 type 属性值。
		 */
		public static const CLICK:String = "pixelMouseEventClick";
		
		/**
		 * 定义 doubleClick 事件对象的 type 属性值。
		 */
		public static const DOUBLE_CLICK:String = "pixelMouseEventDoubleClick";
		
		/**
		 * 构造函数
		 * @param	type:String - 事件名称
		 * @param	localX:Number - 事件发生x轴坐标
		 * @param	localY:Number - 事件发生y轴坐标
		 * @param	bubbles:Boolean - 是否冒泡
		 * @param	cancelable:Boolean - 事件是否可以取消
		 */
		public function PixelMouseEvent(type:String, localX:Number = NaN, 
										localY:Number = NaN, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable, localX, localY);
		}
		
		/**
		 * 创建 PixelMouseEvent 对象的副本，并设置每个属性的值以匹配原始属性值。
		 * @return	PixelMouseEvent — 其属性值与原始属性值匹配的新的 PixelMouseEvent 对象。
		 */
		override public function clone():Event 
		{ 
			return new PixelMouseEvent(type, localX, localY, bubbles, cancelable);
		} 
		
		/**
		 * 返回一个字符串，其中包含 PixelMouseEvent 对象的所有属性。
		 * @return	String — 一个字符串，其中包含 PixelMouseEvent 对象的所有属性。
		 */
		override public function toString():String
		{ 
			return formatToString("PixelMouseEvent", "type", "localX", "localY", "bubbles", "cancelable", "eventPhase");
		}
	}
}
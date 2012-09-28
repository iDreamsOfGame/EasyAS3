/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-28 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.display.pixel 
{
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ... 像素级交互显示对象 ...
	 * @author Jerry
	 */
	public interface IPixelInteractiveDisplayObject extends IBitmapDrawable
	{
		/**
		 * 指定此对象是否使用像素级交互
		 */
		function get pixelIntactiveEnabled():Boolean;
		
		/**
		 * 指定此对象是否使用像素级交互
		 */
		function set pixelIntactiveEnabled(value:Boolean):void;
		
		/**
		 * 透明度阀值
		 */
		function get alphaThreshold():uint;
		
		/**
		 * 透明度阀值
		 */
		function set alphaThreshold(value:uint):void;
		
		/**
		 * 指定一个 sprite 用作另一个 sprite 的点击区域。
		 */
		function get hitArea():Sprite;
		
		/**
		 * 指定此 sprite 的按钮模式。
		 */
		function get buttonMode():Boolean;
		
		/**
		 * 指定此 sprite 的按钮模式。
		 */
		function set buttonMode(value:Boolean):void;
		
		/**
		 * 指示是否支持原生鼠标交互
		 */
		function set originalMouseEnabled(value:Boolean):void;
		
		/**
		 * 将一个 DisplayObject 子实例添加到该 DisplayObjectContainer 实例中。
		 * @param	child:DisplayObject — 要作为该 DisplayObjectContainer 实例的子项添加的 DisplayObject 实例。
		 * @return	 DisplayObject — 在 child 参数中传递的 DisplayObject 实例。 
		 */
		function addChild(child:DisplayObject):DisplayObject;
		
		/**
		 * 将一个 DisplayObject 子实例添加到该 DisplayObjectContainer 实例中。
		 * @param	child:DisplayObject — 要作为该 DisplayObjectContainer 实例的子项添加的 DisplayObject 实例。
		 * @param	index:int — 添加该子项的索引位置。 如果指定当前占用的索引位置，则该位置以及所有更高位置上的子对象会在子级列表中上移一个位置。 
		 * @return	DisplayObject — 在 child 参数中传递的 DisplayObject 实例。 
		 */
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		
		/**
		 * 从 DisplayObjectContainer 实例的子列表中删除指定的 child DisplayObject 实例。
		 * @param	child:DisplayObject — 要删除的 DisplayObject 实例。
		 * @return	DisplayObject — 在 child 参数中传递的 DisplayObject 实例。 
		 */
		function removeChild(child:DisplayObject):DisplayObject;
		
		/**
		 * 计算显示对象，以确定它是否与 x 和 y 参数指定的点重叠或相交。x 和 y 参数指定舞台的坐标空间中的点，而不是包含显示对象的显示对象容器中的点（除非显示对象容器是舞台）。 
		 * @param	x:Number — 要测试的此对象的 x 坐标。 
		 * @param	y:Number — 要测试的此对象的 y 坐标。 
		 * @param	shapeFlag:Boolean (default = false) — 是检查对象 (true) 的实际像素，还是检查边框 (false) 的实际像素。
		 * @return	Boolean — 如果显示对象与指定的点重叠或相交，则为 true；否则为 false
		 */
		function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean;
		
		/**
		 * 使用 EventDispatcher 对象注册事件侦听器对象，以使侦听器能够接收事件通知。
		 * @param	type:String — 事件的类型。 
		 * @param	listener:Function — 处理事件的侦听器函数。
		 * @param	useCapture:Boolean (default = false) — 确定侦听器是运行于捕获阶段还是运行于目标和冒泡阶段。
		 * @param	priority:int (default = 0) — 事件侦听器的优先级。
		 * @param	useWeakReference:Boolean (default = false) — 确定对侦听器的引用是强引用，还是弱引用。
		 */
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		
		/**
		 * 从 EventDispatcher 对象中删除侦听器。
		 * @param	type:String — 事件的类型。 
		 * @param	listener:Function — 要删除的侦听器对象。 
		 * @param	useCapture:Boolean (default = false) — 指出是为捕获阶段还是为目标和冒泡阶段注册了侦听器。
		 */
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		
		/**
		 * 返回一个矩形，该矩形定义相对于 targetCoordinateSpace 对象坐标系的显示对象区域。
		 * @param	 targetCoordinateSpace:DisplayObject — 定义要使用的坐标系的显示对象。 
		 * @return	 Rectangle — 定义与 targetCoordinateSpace 对象坐标系统相关的显示对象面积的矩形。 
		 */
		function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
	}
	
}
/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.ui 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	import org.easyas3.events.IAdvancedEventDispatcher;
	
	/**
	 * 键盘按键状态记录类
	 * @author Jerry
	 */
	public class EasyKeyState extends EventDispatcher implements IAdvancedEventDispatcher
	{
		/**
		 * 单例模式实例对象
		 * @private
		 */
		private static var _instance:EasyKeyState;
		
		/**
		 * 按键列表
		 */
		protected var keys:Object;
		
		/**
		 * 舞台对象
		 */
		protected var _stage:Stage;
		
		/**
		 * 构造函数
		 */
		public function EasyKeyState() 
		{
			super(null);
			keys = { };
		}
		
		/**
		 * 获取单例模式实例对象
		 * @return	EasyKeyState
		 */
		public static function getInstance():EasyKeyState 
		{
			if (!_instance)
			{
				_instance = new EasyKeyState();
			}
			
			return _instance;
		}
		
		/**
		 * 设置舞台对象
		 */
		public function set stage(value:Stage):void 
		{
			if (value)
			{
				_stage = value;
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKeyDownHandler, false, 2);
				_stage.addEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler, false, 2);
				_stage.addEventListener(Event.DEACTIVATE, stageDeactiveHandler, false, 2);
			}
			else
			{
				dispose();
			}
		}
		
		/**
		 * 舞台对象
		 */
		public function get stage():Stage 
		{
			return _stage;
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			if (_stage)
			{
				try
				{
					_stage.removeEventListener(KeyboardEvent.KEY_DOWN, stageKeyDownHandler, false);
					_stage.removeEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler, false);
					_stage.removeEventListener(Event.DEACTIVATE, stageDeactiveHandler, false);
				}
				catch (e:Error)
				{
					trace("[错误]: " + e.message);
				}
			}
		}
		
		/**
		 * 按键是否处于按下状态
		 * @param	keyCode:uint — 按键代码
		 * @return	Boolean — 如果键盘按键处于按下状态，则返回 (true)，否则返回 (false)。
		 */
		public function isKeyDown(keyCode:uint):Boolean 
		{
			if (keys[keyCode])
			{
				return keys[keyCode];
			}
			
			return false;
		}
		
		/**
		 * 按键按下事件处理
		 * @param	e:KeyboardEvent — 键盘事件对象
		 */
		protected function stageKeyDownHandler(e:KeyboardEvent):void 
		{
			keys[e.keyCode] = true;
		}
		
		/**
		 * 按键弹起事件处理
		 * @param	e:KeyboardEvent — 键盘事件对象
		 */
		protected function stageKeyUpHandler(e:KeyboardEvent):void 
		{
			keys[e.keyCode] = false;
		}
		
		/**
		 * 舞台失去焦点后处理
		 * @param	e:KeyboardEvent — 键盘事件对象
		 */
		protected function stageDeactiveHandler(e:Event):void 
		{
			for (var key:String in keys) 
			{
				keys[key] = false;
			}
		}
	}

}
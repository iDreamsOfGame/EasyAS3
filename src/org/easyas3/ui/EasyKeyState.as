package org.easyas3.ui 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * ... 键盘按键状态记录类 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class EasyKeyState extends EventDispatcher 
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
		 * @return
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
						
					}
				}
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
		 * 按键是否处于按下状态
		 * @param	keyCode
		 * @return
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
		 * @param	e
		 */
		protected function stageKeyDownHandler(e:KeyboardEvent):void 
		{
			keys[e.keyCode] = true;
		}
		
		/**
		 * 按键弹起事件处理
		 * @param	e
		 */
		protected function stageKeyUpHandler(e:KeyboardEvent):void 
		{
			keys[e.keyCode] = false;
		}
		
		/**
		 * 舞台失去焦点后处理
		 * @param	e
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
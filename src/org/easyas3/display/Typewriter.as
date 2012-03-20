package org.easyas3.display 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import org.easyas3.events.TypewriterEvent;
	
	/**
	 * ... 打字机特效类 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public class Typewriter extends EventDispatcher
	{
		/**
		 * 字符数组
		 */
		protected var chars:Array;
		
		/**
		 * 文本域对象
		 */
		protected var textField:TextField;
		
		/**
		 * 计时器
		 */
		protected var timer:Timer;
		
		/**
		 * 打字效果实现
		 * @param	text
		 * @param	textField
		 * @param	delay
		 */
		public function write(text:String, textField:TextField, delay:Number):void 
		{
			chars = text.split("");																//拆分字符串
			this.textField = textField;														//设置文本域
			
			if (!timer)
			{
				timer = new Timer(delay, text.length);								//设定计时器
			}
			else
			{
				timer.delay = delay;
				timer.repeatCount = text.length;
			}
											
			timer.addEventListener(TimerEvent.TIMER, writeChar);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, writeComplete);
			timer.start();
		}
		
		/**
		 * 销毁方法
		 */
		public function dispose():void 
		{
			chars = null;
			textField = null;
			
			if (timer)
			{
				timer.stop();
				
				if (timer.hasEventListener(TimerEvent.TIMER))
				{
					timer.removeEventListener(TimerEvent.TIMER, writeChar);
				}
				
				if (timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
				{
					timer.removeEventListener(TimerEvent.TIMER_COMPLETE, writeComplete);
				}
			}
		}
		
		/**
		 * 写入字符
		 * @param	e
		 */
		protected function writeChar(e:TimerEvent):void 
		{
			var index:int = timer.currentCount - 1;
			textField.appendText(chars[index]);
		}
		
		/**
		 * 完成写入字符
		 * @param	e
		 */
		protected function writeComplete(e:TimerEvent):void 
		{
			timer.removeEventListener(TimerEvent.TIMER, writeChar);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, writeComplete);
			dispatchEvent(new TypewriterEvent(TypewriterEvent.TYPE_COMPLETE));
		}
	}

}
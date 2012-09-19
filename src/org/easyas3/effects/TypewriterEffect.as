/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.effects 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import org.easyas3.events.IAdvancedEventDispatcher;
	import org.easyas3.events.TypewriterEffectEvent;
	
	/**
	 * 打字机文字特效类
	 * @author Jerry
	 */
	public class TypewriterEffect extends EventDispatcher implements IAdvancedEventDispatcher
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
		 * 构造函数 
		 */		
		public function TypewriterEffect()
		{
			super();
		}
		
		/**
		 * 打字效果实现
		 * @param	text:String — 需要显示的字符串
		 * @param	textField:TextField — 显示字符串的文本域
		 * @param	delay:Number — 打字延迟时间
		 */
		public function write(text:String, textField:TextField, delay:Number):void 
		{
			//拆分字符串
			chars = text.split("");
			
			//设置文本域
			this.textField = textField;														
			
			if (!timer)
			{
				//设定计时器
				timer = new Timer(delay, text.length);
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
		 * @param	e:TimerEvent — 计时器事件对象
		 */
		protected function writeChar(e:TimerEvent):void 
		{
			var index:int = timer.currentCount - 1;
			textField.appendText(chars[index]);
		}
		
		/**
		 * 完成写入字符
		 * @param	e:TimerEvent — 计时器事件对象
		 */
		protected function writeComplete(e:TimerEvent):void 
		{
			timer.removeEventListener(TimerEvent.TIMER, writeChar);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, writeComplete);
			dispatchEvent(new TypewriterEffectEvent(TypewriterEffectEvent.TYPE_COMPLETE));
		}
	}

}
/*
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-09-26 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci 
{
	import flash.utils.getTimer;
	
	import org.computus.utils.timekeeper.Timekeeper;
	import org.computus.utils.timekeeper.TimekeeperEvent;
	import org.easyas3.utils.StringUtil;
	
	/**
	 * 达芬奇引擎渲染管理器
	 * @author Jerry
	 */
	public class VinciRenderManager 
	{
		/**
		 * 渲染器
		 * @private
		 */
		private var _renderer:IRenderer;
		
		/**
		 * 时间差值
		 * @private
		 */
		private var _deltaTime:Number = 0;
		
		/**
		 * 上一次记录时间
		 * @private
		 */
		private var _lastTime:Number = 0;
		
		/**
		 * 计时器
		 * @private
		 */
		private var _timer:Timekeeper;
		
		/**
		 * 构造函数
		 * @param	renderer:IRenderer — 渲染器
		 */
		public function VinciRenderManager(renderer:IRenderer) 
		{
			_renderer = renderer;
			
			initialize();
		}
		
		/**
		 * 帧速率
		 */
		protected function get frameRate():Number 
		{
			return _renderer?_renderer.frameRate:24;
		}
		
		/**
		 * 舞台帧速率
		 */
		protected function get stageFrameRate():Number 
		{
			return VinciContext.stage.frameRate;
		}
		
		/**
		 * 间隔时间
		 */
		protected function get intervalTime():uint 
		{
			return uint(StringUtil.MSEL_STEP / frameRate);
		}
		
		/**
		 * 舞台帧速率的一半
		 */
		protected function get halfFrameRate():Number 
		{
			return frameRate >> 1;
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			_timer.stopTicking();
			_timer.removeEventListener(TimekeeperEvent.CHANGE, timekeeperChangeHandler);
			_timer.destroy();
			_timer = null;
		}
		
		/**
		 * 初始化
		 * @private
		 */
		private function initialize():void 
		{
			_timer = new Timekeeper();
			_timer.setRealTimeValue();
			_timer.tickDuration = intervalTime;
			_timer.tickFrequency = intervalTime;
			_timer.addEventListener(TimekeeperEvent.CHANGE, timekeeperChangeHandler);
			_timer.startTicking();
		}
		
		/**
		 * 计时器计时事件
		 * @private
		 * @param	e
		 */
		private function timekeeperChangeHandler(e:TimekeeperEvent):void 
		{
			var realFrame:uint;
			var tweenFrames:uint;
			var nowTime:uint = getTimer();
			
			_deltaTime = nowTime - _lastTime;
			_lastTime = nowTime;
			realFrame = uint(StringUtil.MSEL_STEP / _deltaTime);			//上一帧的实际帧频
			
			if (realFrame >= halfFrameRate)
			{
				//正常渲染
				_renderer.render();
			}
			else
			{
				//补帧渲染
				tweenFrames = frameRate / realFrame;
				
				for (var i:int = 0; i < tweenFrames; i++) 
				{
					_renderer.render();
				}
			}
		}
	}

}
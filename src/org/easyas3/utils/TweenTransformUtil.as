/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	/**
	 * 缓动转场特效工具类
	 * @author Jerry
	 */
	public final class TweenTransformUtil
	{
		/**
		 * 淡入特效
		 * @param	target:Object — 目标对象
		 * @param	duration:Number (default = 1.0) — 缓动持续时间
		 * @param	from:Number (default = 0.0) — 透明度起始值
		 * @param	to:Number (default = 1.0) — 透明度结束值
		 * @param	onStart:Function (default = null) — 动画开始回调方法
		 * @param	onStartParams:Array (default = null) — 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) — 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) — 动画结束回调方法参数
		 */
		public static function fadeIn(target:Object, duration:Number = 1.0, from:Number = 0.0, to:Number = 1.0, onStart:Function = null, 
									  onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null):void
		{
			fade(target, duration, from, to, onStart, onStartParams, onComplete, onCompleteParams);
		}
		
		/**
		 * 淡出特效
		 * @param	target:Object — 目标对象
		 * @param	duration:Number (default = 1.0) — 缓动持续时间
		 * @param	from:Number (default = 1.0) — 透明度起始值
		 * @param	to:Number (default = 0.0) — 透明度结束值
		 * @param	onStart:Function (default = null) — 动画开始回调方法
		 * @param	onStartParams:Array (default = null) — 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) — 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) — 动画结束回调方法参数
		 */
		public static function fadeOut(target:Object, duration:Number = 1.0, from:Number = 1.0, to:Number = 0.0, onStart:Function = null, 
									   onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null):void
		{
			fade(target, duration, from, to, onStart, onStartParams, onComplete, onCompleteParams);
		}
		
		/**
		 * 模拟运动模糊特效
		 * @param	target:Object — 目标对象
		 * @param	duration:Number — 缓动持续时间
		 * @param	toX:Number — 目标x轴位置
		 * @param	toY:Number — 目标y轴位置
		 * @param	strength:Number — 模糊强度
		 * @param	quality:int — 模糊质量
		 * @param	onStart:Function (default = null) — 动画开始回调方法
		 * @param	onStartParams:Array (default = null) — 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) — 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) — 动画结束回调方法参数
		 */
		public static function motionBlur(target:Object, duration:Number, toX:Number, toY:Number, strength:Number = 1.0, quality:int = 2, 
										  onStart:Function = null, onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null):void 
		{
			TweenPlugin.activate([MotionBlurPlugin]);
			TweenLite.to(target, duration, { x: toX, y: toY, motionBlur: { strength:strength, quality:quality }, ease: Cubic.easeInOut, onStart: onStart, 
				onStartParams: onStartParams, onComplete: onComplete, onCompleteParams: onCompleteParams } );
		}
		
		/**
		 * 淡入淡出特效
		 * @private
		 * @param	target:Object — 目标对象
		 * @param	duration:Number (default = 1.0) — 缓动持续时间
		 * @param	from:Number (default = 0.0) — 透明度起始值
		 * @param	to:Number (default = 1.0) — 透明度结束值
		 * @param	onStart:Function (default = null) — 动画开始回调方法
		 * @param	onStartParams:Array (default = null) — 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) — 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) — 动画结束回调方法参数
		 */
		private static function fade(target:Object, duration:Number = 1.0, from:Number = 0.0, to:Number = 1.0, onStart:Function = null, 
									 onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null):void
		{
			TweenLite.from(target, duration, {alpha: from, onStart: onStart, onStartParams: onStartParams});
			TweenLite.to(target, duration, {alpha: to, onComplete: onComplete, onCompleteParams: onCompleteParams});
		}
		
		
	}

}
package org.easyas3.utils
{
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	/**
	 * ... 缓动转场特效工具类 ...
	 * @author Jerry
	 * @version 1.1.0
	 */
	public final class TweenTransformUtil
	{
		/**
		 * 淡入特效
		 * @param	target:Object —— 目标对象
		 * @param	duration:Number (default = 1.0) —— 缓动持续时间
		 * @param	from:Number (default = 0.0) —— 透明度起始值
		 * @param	to:Number (default = 1.0) —— 透明度结束值
		 * @param	onStart:Function (default = null) —— 动画开始回调方法
		 * @param	onStartParams:Array (default = null) —— 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) —— 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) —— 动画结束回调方法参数
		 */
		public static function fadeIn(target:Object, duration:Number = 1.0, from:Number = 0.0, to:Number = 1.0, onStart:Function = null, onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null) : void
		{
			fade(target, duration, from, to, onStart, onStartParams, onComplete, onCompleteParams);
		}
		
		/**
		 * 淡出特效
		 * @param	target:Object —— 目标对象
		 * @param	duration:Number (default = 1.0) —— 缓动持续时间
		 * @param	from:Number (default = 1.0) —— 透明度起始值
		 * @param	to:Number (default = 0.0) —— 透明度结束值
		 * @param	onStart:Function (default = null) —— 动画开始回调方法
		 * @param	onStartParams:Array (default = null) —— 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) —— 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) —— 动画结束回调方法参数
		 */
		public static function fadeOut(target:Object, duration:Number = 1.0, from:Number = 1.0, to:Number = 0.0, onStart:Function = null, onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null) : void
		{
			fade(target, duration, from, to, onStart, onStartParams, onComplete, onCompleteParams);
		}
		
		/**
		 * 模拟运动模糊特效
		 * @param	target
		 * @param	duration
		 * @param	toX
		 * @param	toY
		 * @param	blurX
		 * @param	blurY
		 * @param	remove
		 * @param	onStart
		 * @param	onStartParams
		 * @param	onComplete
		 * @param	onCompleteParams
		 */
		public static function motionBlur(target:Object, duration:Number, toX:Number, toY:Number, blurX:Number = 10, blurY:Number = 10, remove:Boolean = false, onStart:Function = null, onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null):void 
		{
			TweenPlugin.activate([BlurFilterPlugin]);
			TweenLite.to(target, duration, { x: toX, y: toY, ease: Quint.easeIn, onStart: onStart, onStartParams: onStartParams, onComplete: onComplete, onCompleteParams: onCompleteParams } );
			TweenMax.to(target, duration / 2, { blurFilter: { blurX:blurX, blurY:blurY, remove:remove }, ease: Quint.easeIn } );
			TweenMax.to(target, duration / 2, { blurFilter: { blurX:0, blurY:0, remove:remove }, ease: Quint.easeIn } );
		}
		
		/**
		 * 淡入淡出特效
		 * @private
		 * @param	target:Object —— 目标对象
		 * @param	duration:Number (default = 1.0) —— 缓动持续时间
		 * @param	from:Number (default = 0.0) —— 透明度起始值
		 * @param	to:Number (default = 1.0) —— 透明度结束值
		 * @param	onStart:Function (default = null) —— 动画开始回调方法
		 * @param	onStartParams:Array (default = null) —— 动画开始回调方法参数
		 * @param	onComplete:Function (default = null) —— 动画结束回调方法
		 * @param	onCompleteParams:Array (default = null) —— 动画结束回调方法参数
		 */
		private static function fade(target:Object, duration:Number = 1.0, from:Number = 0.0, to:Number = 1.0, onStart:Function = null, onStartParams:Array = null, onComplete:Function = null, onCompleteParams:Array = null) : void
		{
			TweenLite.from(target, duration, {alpha: from, onStart: onStart, onStartParams: onStartParams});
			TweenLite.to(target, duration, {alpha: to, onComplete: onComplete, onCompleteParams: onCompleteParams});
		}
		
		
	}

}
/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.preloaders
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	/**
	 * 仿Mac系统预载动画
	 * @author Jerry
	 */
	public class MacWheelPreloader extends Preloader implements IPreloader
	{
		/**
		 * 物体旋转角度
		 * @private
		 */
		private const ITEM_ROTATION:Number = 15;
		
		/**
		 * 容器旋转角度
		 * @private
		 */
		private const CONTAINER_ROTATION:Number = 3;
		
		/**
		 * 旋转间隔时间
		 * @private
		 */
		private const ROTATE_DURATION:Number = 0.9;
		
		/**
		 * 图形宽度
		 * @private
		 */
		private var shapeWidth:Number = 2;
		
		/**
		 * 图形高度
		 * @private
		 */
		private var shapeHeight:Number = 7;
		
		/**
		 * 图形颜色
		 * @private
		 */
		private var shapeColor:uint = 0xFFFFFF;
		
		/**
		 * 图形半径
		 * @private
		 */
		private var shapeRadius:Number = 6;
		
		/**
		 * 索引
		 * @private
		 */
		private var index:Number = 0;
		
		/**
		 * 帧速率
		 * @private
		 */
		private var frameRate:Number = 2;
		
		/**
		 * 初始化完毕标识
		 * @private
		 */
		private var initialized:Boolean;
		
		/**
		 * 容器
		 * @private
		 */
		private var container:Sprite;
		
		/**
		 * 构造函数
		 * @param	shapeWidth:Number (default = 2)	— 图形宽度
		 * @param	shapeHeight:Number (default = 7) — 图形高度
		 * @param	shapeColor:uint (default = 0xFFFFFF) — 图形颜色
		 * @param	shapreRadius:Number (default = 6) — 图形半径
		 */
		public function MacWheelPreloader(shapeWidth:Number = 2, shapeHeight:Number = 7, shapeColor:uint = 0xFFFFFF, shapeRadius:Number = 6)
		{
			index = frameRate;
			this.shapeWidth = shapeWidth;
			this.shapeHeight = shapeHeight;
			this.shapeColor = shapeColor;
			this.shapeRadius = shapeRadius;
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		/**
		 * 播放预载动画
		 */
		override public function play():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * 停止播放预载动画
		 */
		override public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * 销毁方法
		 */
		override public function dispose():void
		{
			stop();
			setNull(container);
		}
		
		/**
		 * 添加到舞台事件
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function addedHandler(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			initialize();
		}
		
		/**
		 * 图形旋转帧事件调度
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function enterFrameHandler(e:Event):void
		{
			if (initialized)
			{
				container.alpha = 0;
				if (index == frameRate)
				{
					drawNewShape();
					index = 0;
				}
				index++;
				container.rotation += ITEM_ROTATION;
				rotation -= CONTAINER_ROTATION;
			}
		}
		
		/**
		 * 绘制新图形
		 * @private
		 */
		private function drawNewShape():void
		{
			var sp:Sprite = drawShape(shapeRadius, shapeColor);
			sp.rotation = container.rotation;
			addChild(sp);
			TweenLite.to(sp, ROTATE_DURATION, {alpha: 0, onComplete: rotateCompleteHandler, onCompleteParams: [sp]});
		}
		
		/**
		 * 旋转完毕事件调度
		 * @private
		 * @param	sp:Sprite — 容器对象
		 */
		private function rotateCompleteHandler(sp:Sprite):void
		{
			setNull(sp);
		}
		
		/**
		 * 设置某个显示对象为空
		 * @param	obj:DisplayObject — 需要被置空的显示对象
		 */
		private function setNull(obj:DisplayObject):void
		{
			if (obj)
			{
				TweenLite.killTweensOf(obj);
				removeChild(obj);
				obj = null;
			}
		}
		
		/**
		 * 初始化方法
		 * @private
		 */
		private function initialize():void
		{
			container = drawShape(shapeRadius, shapeColor);
			container.alpha = 0;
			initialized = true;
			addChild(container);
		}
		
		/**
		 * 绘制图形
		 * @private
		 * @param	pY:Number — 坐标y值
		 * @param	color:uint — 颜色
		 * @return	Sprite — 生成的Sprite对象
		 */
		private function drawShape(pY:Number = 0, color:uint = 0xFFFFFF):Sprite
		{
			var sp:Sprite = new Sprite();
			var shape:Shape = new Shape();
			var graph:Graphics = shape.graphics;
			var gf:GlowFilter = new GlowFilter(0, 1, 2, 2, 2, 3);
			graph.beginFill(color);
			graph.drawRect((-shapeWidth * 0.5), -shapeHeight, shapeWidth, shapeHeight);
			graph.endFill();
			shape.x = 0;
			shape.y = pY;
			sp.addChild(shape);
			shape.filters = [gf];
			return sp;
		}
	}

}
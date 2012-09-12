/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.components 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.easyas3.events.IAdvancedEventDispatcher;
	
	/**
	 * 新手引导遮罩类
	 * @author Jerry
	 */
	public class TutorialMask extends Sprite implements IAdvancedEventDispatcher
	{
		/**
		 * 圆角矩形镂空宽度
		 */
		public var maskHoleEllipseWidth:Number = 4;
		
		/**
		 * 圆角矩形镂空高度
		 */
		public var maskHoleEllipseHeight:Number = 4;
		
		/**
		 * 遮罩对象
		 */
		public var maskDisplay:Shape;
		
		/**
		 * 遮罩颜色
		 */
		protected var maskColor:uint;
		
		/**
		 * 遮罩透明度
		 */
		protected var maskAlpha:Number;
		
		/**
		 * 构造函数
		 * @param	maskColor:uint (default = 0x000000) — 遮罩颜色
		 * @param	maskAlpha:Number (default = 0.5) — 遮罩透明度
		 */
		public function TutorialMask(maskColor:uint = 0x000000, maskAlpha:Number = 0.5)
		{
			super();
			
			this.maskColor = maskColor;
			this.maskAlpha = maskAlpha;
			maskDisplay = new Shape();
			addChild(maskDisplay);
		}
		
		/**
		 * 显示遮罩
		 * @param	maskX:Number (default = 0) — 遮罩x轴坐标
		 * @param	maskY:Number (default = 0) — 遮罩y轴坐标
		 * @param	maskWidth:Number (default = 1) — 遮罩宽度
		 * @param	maskHeight:Number (default = 1) — 遮罩高度
		 * @param	interactiveDisplayObj:DisplayObject (default = null) — 遮罩下可交互对象
		 * @param	maskHolePadding:Number (default = 0) — 镂空填充像素值
		 * @param	holeShape:String (default = "nothing") — 镂空形状
		 */
		public function show(maskX:Number = 0, maskY:Number = 0, maskWidth:Number = 1, maskHeight:Number = 1,
							 interactiveDisplayObj:DisplayObject = null, maskHolePadding:Number = 0,
							 holeShape:String = TutorialMaskHoleShape.NOTHING):void
		{
			var shapeX:Number;
			var shapeY:Number;
			var a:Number;
			var b:Number;
			var radius:Number;
			var p:Point;
			var g:Graphics = maskDisplay.graphics;
			
			//显示之前先隐藏遮罩
			hide();
			
			//转换交互对象的全局坐标为图形的本地坐标
			p = interactiveDisplayObj.parent.localToGlobal(new Point(interactiveDisplayObj.x, interactiveDisplayObj.y));
			
			g.beginFill(maskColor, maskAlpha);
			g.drawRect(maskX, maskY, maskWidth, maskHeight);
			
			a = interactiveDisplayObj.width + maskHolePadding;
			b = interactiveDisplayObj.height + maskHolePadding;
			
			switch (holeShape)
			{
				case TutorialMaskHoleShape.CIRCLE: 
				{
					//绘制圆形
					radius = Math.sqrt(Math.pow(a / 2, 2) + Math.pow(b / 2, 2));
					shapeX = interactiveDisplayObj.width / 2 + p.x;
					shapeY = interactiveDisplayObj.height / 2 + p.y;
					g.drawCircle(shapeX, shapeY, radius);
					break;
				}
				
				case TutorialMaskHoleShape.ELIPSE: 
				{
					//绘制椭圆
					a = (Math.sqrt(2) / 2 * (interactiveDisplayObj.width + maskHolePadding)) * 2;
					b = (Math.sqrt(2) / 2 * (interactiveDisplayObj.height + maskHolePadding)) * 2;
					shapeX = (interactiveDisplayObj.width - a) / 2 + p.x;
					shapeY = (interactiveDisplayObj.height - b) / 2 + p.y;
					g.drawEllipse(shapeX, shapeY, a, b);
					break;
				}
				
				case TutorialMaskHoleShape.RECTANGLE: 
				{
					//绘制矩形
					shapeX = -maskHolePadding + p.x;
					shapeY = -maskHolePadding + p.y;
					g.drawRect(shapeX, shapeY, a + maskHolePadding, b + maskHolePadding);
					break;
				}
				
				case TutorialMaskHoleShape.ROUND_RECTANGLE: 
				{
					//绘制圆角矩形
					a += maskHoleEllipseWidth;
					b += maskHoleEllipseHeight;
					shapeX = p.x - (maskHoleEllipseWidth + maskHolePadding) / 2;
					shapeY = p.y - (maskHoleEllipseHeight + maskHolePadding) / 2;
					g.drawRoundRect(shapeX, shapeY, a, b, maskHoleEllipseWidth, maskHoleEllipseHeight);
					break;
				}
			}
			
			g.endFill();
		}
		
		/**
		 * 隐藏遮罩
		 */
		public function hide():void
		{
			maskDisplay.graphics.clear();
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			hide();
			removeChild(maskDisplay);
			maskDisplay = null;
		}
	}

}
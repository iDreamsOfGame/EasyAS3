/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.easyas3.utils.DisplayObjectUtil;
	import org.easyas3.utils.MathUtil;
	import org.easyas3.vinci.display.BitmapFrameInfo;
	
	/**
	 * 位图缓存器
	 * @author Jerry 
	 */	
	public final class BitmapBuffer
	{
		/**
		 * copyPixels目标点
		 * @private
		 */
		private static var _destPoint:Point = new Point();
		
		/**
		 * 位图映射数据
		 * @private
		 */
		private static var _mapData:Object = {};
		
		/**
		 * 存储位图帧信息序列
		 * @param	id:String — 位图帧信息序列标识
		 * @param	data:Vector.<BitmapFrameInfo> — 位图帧信息序列
		 */
		public static function storeBitmapFrameInfos(id:String, data:Vector.<BitmapFrameInfo>):void 
		{
			_mapData[id] = data;
		}
		
		/**
		 * 获取位图帧信息序列
		 * @param	id:String — 位图帧信息序列标识
		 * @return	Vector.<BitmapFrameInfo> — 位图帧信息序列
		 */
		public static function getBitmapFrameInfos(id:String):Vector.<BitmapFrameInfo> 
		{
			return _mapData[id];
		}
		
		/**
		 * 缓存单个位图
		 * @param	source:DisplayObject — 被绘制的目标显示对象
		 * @param	transparent:Boolean — 是否透明
		 * @param	fillColor:uint — 填充颜色
		 * @param	scale:Number — 缓存成位图之后的缩放值
		 * @return BitmapFrameInfo — 缓存成位图的帧信息
		 */
		public static function cacheBitmap(source:DisplayObject, transparent:Boolean = true, fillColor:uint = 0x00000000,
										   scale:Number = 1):BitmapFrameInfo
		{
			var bitmapData:BitmapData;
			var validRect:Rectangle;
			var validBitmapData:BitmapData;
			var bitmapFrameInfo:BitmapFrameInfo;
			var rect:Rectangle = source.getBounds(source);
			var x:int = Math.round(rect.x * scale);
			var y:int = Math.round(rect.y * scale);
			
			if (rect.isEmpty())
			{
				//防止无效的BitmapData异常
				rect.width = 1;
				rect.height = 1;
			}
			
			//绘制位图
			bitmapData = new BitmapData(MathUtil.ceil(rect.width * scale), MathUtil.ceil(rect.height * scale), transparent, fillColor);
			bitmapData.draw(source, new Matrix(scale, 0, 0, scale, -x, -y), null, null, null, true);
			
			//剔除边缘空白像素
			validRect = bitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
			
			if (validRect.isEmpty() == false && (bitmapData.width != validRect.width || bitmapData.height != validRect.height))
			{
				//矩形有效且位图的高或宽与原素材不相等
				validBitmapData = new BitmapData(validRect.width, validRect.height, transparent, fillColor);
				validBitmapData.copyPixels(bitmapData, validRect, _destPoint);
				
				bitmapData.dispose();
				bitmapData = validBitmapData;
				x += validRect.x;
				y += validRect.y;
			}
			
			//构造位图帧信息数据
			bitmapFrameInfo = new BitmapFrameInfo(x, y, bitmapData);
			
			return bitmapFrameInfo;
		}
		
		/**
		 * 缓存位图影片剪辑
		* @param	source:DisplayObject — 被绘制的目标显示对象
		 * @param	transparent:Boolean — 是否透明
		 * @param	fillColor:uint — 填充颜色
		 * @param	scale:Number — 缓存成位图之后的缩放值
		 * @return Vector.<BitmapFrameInfo> — 缓存成位图的帧信息序列
		 */
		public static function cacheBitmapMovieClip(source:DisplayObject, transparent:Boolean = true, 
													fillColor:uint = 0x00000000, scale:Number = 1):Vector.<BitmapFrameInfo> 
		{
			var mcChildren:Array;
			var mcNumChildren:int;
			var mcTotalFrames:int;
			var mcChild:MovieClip;
			var mc:MovieClip = source as MovieClip;
			var bitmapFrameInfos:Vector.<BitmapFrameInfo>;
			
			if (mc == null)
			{
				//不是影片剪辑对象
				bitmapFrameInfos = new Vector.<BitmapFrameInfo>(1, true);
				bitmapFrameInfos[0] = cacheBitmap(source, transparent, fillColor, scale);
			}
			else
			{
				mcTotalFrames = mc.totalFrames;
				mc.gotoAndStop(1);
				bitmapFrameInfos = new Vector.<BitmapFrameInfo>(mcTotalFrames, true);
				
				for (var i:int = 0; i < mcTotalFrames; i++) 
				{
					//按照影片剪辑长度播放影片剪辑，同时将各帧影像缓存为位图
					bitmapFrameInfos[i] = cacheBitmap(mc, transparent, fillColor, scale);
					mcChildren = DisplayObjectUtil.searchChild(mc, MovieClip);
					mc.nextFrame();
					
					//对于影片剪辑的子影片剪辑对象同样需要播放
					mcNumChildren = mcChildren.length;
					
					for (var j:int = 0; j < mcNumChildren; j++) 
					{
						mcChild = mcChildren[j];
						mcChild.nextFrame();
					}
				}
			}
			
			return bitmapFrameInfos;
		}
	}
}
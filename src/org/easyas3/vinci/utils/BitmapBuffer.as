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
	import org.easyas3.vinci.display.SpriteSheetBitmapInfo;
	import org.easyas3.vinci.display.SpriteSheetLayout;
	
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
			storeMapData(id, data);
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
		 * 存储精灵位图序列
		 * @param	id:String — 精灵序列图信息序列标识
		 * @param	data:SpriteSheetBitmapInfo — 精灵位图动画信息
		 */
		public static function storeSpriteSheetBitmapInfos(id:String, data:SpriteSheetBitmapInfo):void 
		{
			storeMapData(id, data);
		}
		
		/**
		 * 获取精灵位图序列数据信息
		 * @param	id:String — 精灵序列图信息序列标识
		 * @return	SpriteSheetBitmapInfo — 精灵位图动画信息
		 */
		public static function getSpriteSheetBitmapInfos(id:String):SpriteSheetBitmapInfo
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
		
		/**
		 * 缓存精灵序列图
		 * @param	source:DisplayObject — 被绘制的目标显示对象
		 * @param	spriteWidth:int (default = 0) — 精灵序列图宽度
		 * @param	spriteHeight:int (default = 0) — 精灵序列图高度
		 * @param	rowCount:int (default = 0) — 精灵序列图行数
		 * @param	columnCount:int (default = 0) — 精灵序列图列数
		 * @param	direction:String (default = "horizontal") — 精灵序列图排列方向
		 * @param	transparent:Boolean (default = true) — 精灵序列图是否透明
		 * @param	fillColor:uint (default = 0x00000000) — 精灵序列图填充的颜色（ARGB） 
		 * @param	scale:Number (default = 1.0) — 精灵序列图缩放比例
		 * @return	SpriteSheetBitmapInfo — 精灵序列图信息
		 */
		public static function cacheSpriteSheet(source:DisplayObject, spriteWidth:int = 0, spriteHeight:int = 0, rowCount:int = 0, columnCount:int = 0, 
												direction:String = SpriteSheetLayout.HORIZONTAL, transparent:Boolean = true, fillColor:uint = 0x00000000, 
												scale:Number = 1.0):SpriteSheetBitmapInfo 
		{
			var bmpData:BitmapData;
			var spriteSheetBmpInfo:SpriteSheetBitmapInfo;
			var spriteSheetBitmaps:Array;
			
			//获取整张图片的范围
			var rect:Rectangle = source.getBounds(source);
			
			//有效宽度和高度
			var validWidth:int = (rect.width + MathUtil.round(rect.x)) * scale;
			var validHeight:int = (rect.height + MathUtil.round(rect.y)) * scale;
			
			//计算精灵序列图宽度和高度
			if ((spriteWidth == 0 || spriteHeight == 0) && rowCount != 0 && columnCount != 0)
			{
				spriteWidth = MathUtil.ceil(validWidth / columnCount);
				spriteHeight = MathUtil.ceil(validHeight / rowCount);
			}
			
			//计算行数和列数
			if ((rowCount == 0 || columnCount == 0) && spriteWidth != 0 && spriteHeight != 0)
			{
				rowCount = MathUtil.ceil(validHeight / spriteHeight);
				columnCount = MathUtil.ceil(validWidth / spriteWidth);
			}
			
			//初始化精灵序列图存储
			spriteSheetBitmaps = new Array(rowCount);
			
			//获取BitmapData二维数组对象
			for (var i:int = 0; i < rowCount; i++) 
			{
				spriteSheetBitmaps[i] = new Array(columnCount);
				
				for (var j:int = 0; j < columnCount; j++) 
				{
					bmpData = new BitmapData(spriteWidth, spriteHeight, transparent, fillColor);
					bmpData.draw(source, new Matrix(scale, 0, 0, scale, -spriteWidth * j, -spriteHeight * i), null, null, null, true);
					spriteSheetBitmaps[i][j] = bmpData;
				}
			}
			
			//存储精灵序列表对象数据
			spriteSheetBmpInfo = new SpriteSheetBitmapInfo();
			spriteSheetBmpInfo.row = rowCount;
			spriteSheetBmpInfo.column = columnCount;
			spriteSheetBmpInfo.validWidth = validWidth;
			spriteSheetBmpInfo.validHeight = validHeight;
			spriteSheetBmpInfo.spriteWidth = spriteWidth;
			spriteSheetBmpInfo.spriteHeight = spriteHeight;
			spriteSheetBmpInfo.spriteSheetBitmaps = spriteSheetBitmaps;
			
			return spriteSheetBmpInfo;
		}
		
		/**
		 * 生成帧序列对象
		 * @private
		 * @param	spriteSheetBitmaps:Array — 精灵序列图位图集合
		 * @param	direction:String — 精灵序列图排列布局
		 * @return	Vector.<BitmapFrameInfo> — 帧信息队列
		 */
		public static function generateFrames(spriteSheetBitmaps:Array, direction:String = "horizontal"):Vector.<BitmapFrameInfo> 
		{
			var bmpFrameInfo:BitmapFrameInfo;
			var columnCount:int;
			var rowCount:int;
			var frames:Vector.<BitmapFrameInfo>;
			
			if(spriteSheetBitmaps == null)
			{
				return null;
			}
			
			rowCount = spriteSheetBitmaps.length;
			frames = new Vector.<BitmapFrameInfo>();
			
			for (var i:int = 0; i < rowCount; i++) 
			{
				columnCount = (spriteSheetBitmaps[i] as Array).length;
				
				for (var j:int = 0; j < columnCount; j++) 
				{
					bmpFrameInfo = new BitmapFrameInfo(0, 0, spriteSheetBitmaps[i][j]);
					frames.push(bmpFrameInfo);
				}
			}
			
			return frames;
		}
		
		/**
		 * 存储映射对象
		 * @private
		 * @param	id:String — 映射对象标识
		 * @param	data:* — 映射对象
		 */
		private static function storeMapData(id:String, data:*):void 
		{
			if (_mapData[id])
			{
				throw "Can not store the object, please change id !";
			}
			
			_mapData[id] = data;
		}
	}
}
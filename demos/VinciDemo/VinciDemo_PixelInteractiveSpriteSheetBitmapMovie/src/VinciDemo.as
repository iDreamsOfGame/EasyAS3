/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-12 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import org.easyas3.vinci.display.BitmapMovie;
	import org.easyas3.vinci.display.BitmapMovieCenterPointPosition;
	import org.easyas3.vinci.display.SpriteSheetBitmap;
	import org.easyas3.vinci.display.SpriteSheetBitmapMovie;
	import org.easyas3.vinci.display.SpriteSheetLayout;
	import org.easyas3.vinci.utils.BitmapBuffer;
	
	[SWF(width="1300", height="800", frameRate="24", backgroundColor="0x000000")]
	public class VinciDemo extends BaseDemo
	{
		private var list_mc:Array;
		private var pool:Array = [];
		private var mcFilters:Array = [new GlowFilter(0xFFF4A6, 0.1, 150, 150, 0.8, 1, true), new GlowFilter(0xFFF4A6, 0.9, 3, 3, 8, 3)];
		
		public function VinciDemo()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			Fps.setup(this);
			Fps.visible = true;
			
			list_mc = [];
			
			var i:int = 0;
			var c:int = 400;
			while (i < c) 
			{
				
				var mc:SpriteSheetBitmapMovie = new SpriteSheetBitmapMovie(null, 12, SpriteSheetLayout.HORIZONTAL, 
					BitmapMovieCenterPointPosition.TOP_LEFT);
				mc.addEventListener(MouseEvent.ROLL_OVER, mcPixelRollOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, mcPixelRollOut);
				mc.addEventListener(MouseEvent.CLICK, mcClick);
				pool.push(mc);
				i++;
			}
			
			cacheBitmapMC();
			
			container.mouseEnabled = false;
		}
		
		private function mcRollOver(e:MouseEvent):void 
		{
			(e.target as BitmapMovie).filters = mcFilters;
		}
		
		private function mcRollOut(e:MouseEvent):void 
		{
			var mc:BitmapMovie = e.target as BitmapMovie;
			mc.filters = null;
		}
		
		private function mcPixelRollOver(evt:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
			(evt.target as BitmapMovie).filters = mcFilters;
		}
		
		private function mcPixelRollOut(evt:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
			var mc:BitmapMovie = evt.target as BitmapMovie;
			mc.filters = null;
			
		}
		
		private function mcClick(evt:MouseEvent):void
		{
			
			var mc:BitmapMovie = evt.target as BitmapMovie;
			if (mc.isPlaying)
			{
				mc.stop();
			}
			else
			{
				mc.play();
				//container.addChild(mc);
			}
			
		}
		
		/**
		 * 预先缓存好位图动画
		 */
		private function cacheBitmapMC():void
		{
			var i:int = 0;
			while (i < DemoConfig.ItemTypeNumber)
			{
				var mc:MovieClip = getItem(i);
				//BitmapBuffer.storeSpriteSheetBitmapInfos(String(i), BitmapBuffer.cacheSpriteSheet(mc, 0, 0, 4, 16, SpriteSheetLayout.HORIZONTAL, true));
				BitmapBuffer.storeSpriteSheetBitmapInfos(String(i), BitmapBuffer.cacheSpriteSheet(mc, 0, 0, 12, 1, SpriteSheetLayout.VERTICAL, true));
				i++;
			}
		}
		
		/**
		 * 生成一个显示对象
		 * @param	row			当前行
		 * @param	column		当前列
		 */
		override protected function initItem(row:int, column:int):void
		{
			//var mc:BitmapMovie = new BitmapMovie(BitmapFrameInfoManager.getBitmapFrameInfo(String(Math.random() * DemoConfig.ItemTypeNumber ^ 0)));
			
			//mc.x = column * DemoConfig.ColumnSpace;
			//mc.y = row * DemoConfig.RowSpace;
			//container.addChild(mc);
			
			//mc.stop();
			
			//arr_item[row][column] = mc;
			arr_item[row][column] = String(Math.random() * DemoConfig.ItemTypeNumber ^ 0);
		}
		
		/**
		 * 拖动容器时触发
		 * @param	strRow			开始行数
		 * @param	endRow			结束行数
		 * @param	strColumn		开始列数
		 * @param	endColumn		结束列数
		 */
		override protected function containerMove(strRow:int, endRow:int, strColumn:int, endColumn:int):void
		{
			//clearContainer();
			
			var i:int = 0;
			var c:int = list_mc.length;
			while (i < c) 
			{
				
				pool.push(list_mc[i]);
				
				i++;
			}
			list_mc = [];
			
			//for each(var mc:BitmapMovie in list_mc)
			//{
			//pool.putObj(mc);
			//}
			//list_mc.splice(0);
			
			while (strRow < endRow)
			{
				var tmpColumn:int = strColumn;
				while (tmpColumn < endColumn)
				{
					var mc:BitmapMovie;
					mc = pool.pop();
					//mc = pool.getObj();
					//mc = new BitmapMovie();
					//mc.frames = BitmapBuffer.getBitmapFrameInfos(arr_item[strRow][tmpColumn]);
					var id:int = Math.round(Math.random() * 6);
					var spriteSheetBmpInfo:SpriteSheetBitmap = BitmapBuffer.getSpriteSheetBitmapInfos(id.toString());
					var spriteSheetBitmaps:Array = spriteSheetBmpInfo.spriteSheetBitmaps;
					//mc.frames = BitmapBuffer.generateFrames(spriteSheetBitmaps, spriteSheetBmpInfo.row, spriteSheetBmpInfo.column);
					mc.frames = BitmapBuffer.generateFrames(spriteSheetBitmaps, spriteSheetBmpInfo.row, spriteSheetBmpInfo.column, SpriteSheetLayout.VERTICAL);
					//mc.stop();
					list_mc.push(mc);
					//mc.x = tmpColumn * DemoConfig.ColumnSpace + (Math.random() * 10 - 5);
					//mc.y = strRow * DemoConfig.RowSpace + (Math.random() * 10 - 5);
					mc.x = tmpColumn * DemoConfig.ColumnSpace;
					mc.y = strRow * DemoConfig.RowSpace;
					container.addChild(mc);
					//mc.play();
					tmpColumn++;
				}
				strRow++;
			}
			
		}
	}
}
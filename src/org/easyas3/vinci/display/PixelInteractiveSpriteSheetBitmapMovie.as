/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	/**
	 * 像素级精灵序列图位图动画
	 * @author Jerry 
	 */	
	public class PixelInteractiveSpriteSheetBitmapMovie extends SpriteSheetBitmapMovie
	{
		/**
		 * 像素级交互代理
		 * @private
		 */
		private var _proxy:PixelInteractiveBitmapMovieProxy;
		
		/**
		 * 构造函数
		 * @param	spriteSheetBitmaps:Array — 精灵序列图位图二维数组
		 */
		public function PixelInteractiveSpriteSheetBitmapMovie(spriteSheetBitmaps:Array)
		{
			super(spriteSheetBitmaps);
		}
	}
}
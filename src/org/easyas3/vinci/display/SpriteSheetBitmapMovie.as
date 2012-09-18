/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import org.easyas3.pool.IPoolObject;
	
	/**
	 * 精灵序列图位图动画
	 * @author Jerry 
	 */	
	public class SpriteSheetBitmapMovie extends BitmapMovieBase implements IPoolObject
	{
		public function SpriteSheetBitmapMovie()
		{
			super();
		}
		
		override public function clone():IPoolObject
		{
			return null;
		}
		
		override public function reset():void
		{
		}
		
		override public function dispose():void
		{
		}
	}
}
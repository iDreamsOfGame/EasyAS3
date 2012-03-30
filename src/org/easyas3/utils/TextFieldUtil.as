package org.easyas3.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	
	/**
	 * ... 文本域工具类 ...
	 * @author Jerry
	 * @version 1.0.0
	 */
	public final class TextFieldUtil 
	{
		/**
		 * 获取旋转文本域镜像（解决Flash中文本域旋转之后无法显示文字的问题）
		 * @param	textfield
		 * @param	rotation
		 * @return
		 */
		public static function getRotatedTextFieldImage(textfield:TextField, rotation:Number):Bitmap 
		{
			var bmpData:BitmapData = new BitmapData(textfield.width, textfield.height, true, 0x00FFFFFF);
			var bmp:Bitmap = new Bitmap(bmpData);
			bmpData.draw(textfield);
			bmp.smoothing = true;
			return bmp;
		}
	}

}
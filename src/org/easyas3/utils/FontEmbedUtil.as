package org.easyas3.utils
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ... 字体嵌入工具类 ...
	 * @author Jerry
	 * @version	1.0.0
	 */
	public final class FontEmbedUtil
	{
		/**
		 * 发光滤镜（游戏中常用字体滤镜及参数）
		 */
		public static var glowFilter:GlowFilter = new GlowFilter(0x541A01, 1, 2, 2, 50);
		
		/**
		 * 阴影滤镜（游戏中常用字体滤镜及参数）
		 */
		public static var shadowFilter:DropShadowFilter = new DropShadowFilter(-2, 45, 0, 1, 0, 0, 0.25);
		
		/**
		 * 给TextField嵌入字体并赋值htmlText
		 * @param	tf
		 * @param	htmlText
		 * @param	font
		 */
		public static function embedHtmlText(tf:TextField, htmlText:String, font:String = null) : void
		{
			tf.htmlText = htmlText;
			
			if(font)
			{
				embedTextFieldFont(tf, font);
			}
		}
		
		/**
		 * 给TextField嵌入字体并赋值text
		 * @param	tf
		 * @param	text
		 * @param	font
		 */
		public static function embedText(tf:TextField, text:String, font:String = null) : void
		{
			if(font)
			{
				embedTextFieldFont(tf, font);
			}
			else
			{
				tf.embedFonts = false;
			}
			
			tf.text = text;
		}
		
		/**
		 * 给TextField对象嵌入字体
		 * @private
		 * @param	textField
		 * @param	font
		 * @return
		 */
		private static function embedTextFieldFont(tf:TextField, font:String = null) : TextField
		{
			var format:TextFormat;
			
			if(tf && font && font != "")
			{
				format = tf.getTextFormat();
				format.font = font;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				
				tf.defaultTextFormat = format;
				tf.setTextFormat(format);
				tf.embedFonts = true;
			}
			else if(tf)
			{
				tf.embedFonts = false;
			}
			
			return tf;
		}
	}

}
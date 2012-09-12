/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.utils
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 字体嵌入工具类
	 * @author Jerry
	 */
	public final class FontEmbedUtil
	{
		/**
		 * 给TextField嵌入字体并赋值htmlText
		 * @param	tf:TextField — 待嵌入字体的文本域
		 * @param	htmlText:String — HTML字符串
		 * @param	font:String — 字体名称
		 */
		public static function embedHtmlText(tf:TextField, htmlText:String, font:String = null):void
		{
			tf.htmlText = htmlText;
			
			if(font)
			{
				embedTextFieldFont(tf, font);
			}
		}
		
		/**
		 * 给TextField嵌入字体并赋值text
		 * @param	tf:TextField — 待嵌入字体的文本域
		 * @param	text:String — 待显示字符串
		 * @param	font:String — 字体名称
		 */
		public static function embedText(tf:TextField, text:String, font:String = null):void
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
		 * @param	textField:TextField — 嵌入字体的文本域
		 * @param	font:String — 字体名称
		 */
		private static function embedTextFieldFont(tf:TextField, font:String = null):void
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
		}
	}

}
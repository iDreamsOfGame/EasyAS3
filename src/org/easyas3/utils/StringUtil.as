package org.easyas3.utils
{
	import flash.utils.*;
	import flash.utils.getQualifiedClassName;
	import com.adobe.utils.StringUtil;
	
	/**
	 * ... 字符串工具类 ...
	 * @author Jerry
	 * @version 0.9.5
	 */
	public final class StringUtil extends com.adobe.utils.StringUtil
	{
		/** ASCII 编码格式 */
		public static const ASCII:String = "us-ascii";
		
		/** 中文繁体编码格式 */
		public static const BIG5:String = "big5";
		
		/** 中文简体编码格式 */
		public static const GB2312:String = "gb2312";
		
		/** UTF-16 编码格式 */
		public static const UTF16:String = "unicode";
		
		/** UTF-8 编码格式 */
		public static const UTF8:String = "utf-8";
		
		/**
		 * 按驼峰命名法规则格式化指定的字符串（只针对英文和数字）
		 * @param	source:String —— 一个字符串，被格式化的字符串源
		 * @param	dealWithAllChars:Boolean (default = true) —— 一个布尔值，指示方法是否处理所有字符，默认为true。如为false，则不会转换首字母之外的其他字符的大小写。
		 * @param	delimiter:* (default = null) —— 指定拆分此字符串的位置的模式。此模式可以是任何类型的对象，但通常为字符串或正则表达式。
		 * @return	String —— 得到被格式化后的字符串
		 */
		public static function getCamelCaseString(source:String, dealWithAllChars:Boolean = true,
												  delimiter:* = null) : String
		{
			var sourceArray:Array = source.split(delimiter);
			var copuString:String;
			var len:int = sourceArray.length;
			
			if(len > 0)
			{
				copuString = sourceArray[0];
				sourceArray[0] =
					copuString.substr(0, 1).toLowerCase() + (dealWithAllChars ? copuString.substring(1).toLowerCase() : copuString.substring(1));
				
				if(len > 1)
				{
					for(var i:int = 1; i < len; i++)
					{
						var item:String = sourceArray[i];
						sourceArray[i] =
							item.substr(0, 1).toUpperCase() + (dealWithAllChars ? item.substring(1).toLowerCase() : item.substring(1));
					}
				}
			}
			
			return sourceArray.join("");
		}
		
		/**
		 * 获取指定对象的类名（不完全限定类名）
		 * @param	object:Object —— 对象
		 * @return 指定对象的类名称
		 */
		public static function getClassName(object:Object) : String
		{
			var className:String = getQualifiedClassName(object);
			className = className.split("::")[1];
			return className;
		}
		
		/**
		 * 获取指定长度的随机字符串（只包含英文和数字）
		 * @param	length:int (default = 4) —— 一个整数，指示返回的随机字符串的长度
		 * @return	String —— 得到随机字符串
		 */
		public static function getRandomStr(length:int = 4) : String
		{
			var ran:int = 0;
			var number:int = 0;
			var code:String = "";
			var checkCode:String = "";
			
			for(var i:int = 0; i < length; i++)
			{
				ran = MathUtil.round(Math.random() * 2);
				number = MathUtil.round(Math.random() * 10000);
				
				if(ran == 0)
				{
					code = String.fromCharCode(48 + (number % 10));
				}
				else if(ran == 1)
				{
					code = String.fromCharCode(65 + (number % 26));
				}
				else
				{
					code = String.fromCharCode(97 + (number % 26));
				}
				checkCode += code;
			}
			return checkCode;
		}
		
		/**
		 * 根据编码格式获取字符串的真实长度
		 * @param	source:String —— 一个字符串，字符串源
		 * @param	charSet:String (default = "gb2312") —— 一个字符串，指定字符串的字符编码
		 * @return	uint —— 字符串的长度
		 */
		public static function getStrLength(source:String, charSet:String = GB2312) : uint
		{
			var byteArr:ByteArray = new ByteArray();
			byteArr.writeMultiByte(source, charSet);
			return byteArr.length;
		}
		
		/**
		 * 将时间（以毫秒为单位）以指定文本格式输出
		 * @param	time:Number (default = 0) —— 一个数字，被转换的时间值，单位为毫秒
		 * @param	withHour:Boolean (default = false) —— 一个布尔值，指示输出的文本是否含带小时部分字符串
		 * @param	sep:String (default = ":") —— 一个字符串，指示时间单位的间隔符
		 * @return	String —— 时间文本字符串
		 */
		public static function getTimeStr(time:Number = 0, withHour:Boolean = false,
										  sep:String = ":") : String
		{
			var hour:*;
			var min:*;
			var sec:*;
			var timeStrArr:Array;
			time /= MathUtil.MSEL_STEP;
			hour = MathUtil.floor(time / Math.pow(MathUtil.TIME_STEP, 2));
			min = MathUtil.floor(time / MathUtil.TIME_STEP) % MathUtil.TIME_STEP;
			sec = MathUtil.floor(time % MathUtil.TIME_STEP);
			
			if(hour < 10)
				hour = "0" + String(hour);
			
			if(min < 10)
				min = "0" + String(min);
			
			if(sec < 10)
				sec = "0" + String(sec);
			
			if(withHour)
			{
				timeStrArr = [hour, min, sec];
			}
			else
			{
				timeStrArr = [min, sec];
			}
			return timeStrArr.join(sep);
		}
		
		/**
		 * 按大驼峰命名法规则格式化指定的字符串（只针对英文和数字）
		 * @param	source:String —— 一个字符串，被格式化的字符串源
		 * @param	dealWithAllChars:Boolean (default = true) —— 一个布尔值，指示方法是否处理所有字符，默认为true。如为false，则不会转换首字母之外的其他字符的大小写。
		 * @param	delimiter:* (default  = null) —— 指定拆分此字符串的位置的模式。此模式可以是任何类型的对象，但通常为字符串或正则表达式。
		 * @return	String —— 得到被格式化后的字符串
		 */
		public static function getUpperCamelCase(source:String, dealWithAllChars:Boolean = true,
												 delimiter:* = null) : String
		{
			var sourceArray:Array = source.split(delimiter);
			var copuString:String;
			var len:int = sourceArray.length;
			
			if(len > 0)
			{
				copuString = sourceArray[0];
				sourceArray[0] =
					copuString.substr(0, 1).toUpperCase() + (dealWithAllChars ? copuString.substring(1).toLowerCase() : copuString.substring(1));
				
				if(len > 1)
				{
					for(var i:int = 1; i < len; i++)
					{
						var item:String = sourceArray[i];
						sourceArray[i] =
							item.substr(0, 1).toUpperCase() + (dealWithAllChars ? item.substring(1).toLowerCase() : copuString.substring(1));
					}
				}
			}
			
			return sourceArray.join("");
		}
		
		/**
		 * 截取字符串（支持中文简体、繁体）
		 * @param	source:String —— 一个字符串，被截取的字符串源
		 * @param	length:int (default = 20) —— 一个整数，截取字符串的长度（包括后缀字符串的长度）
		 * @param	withSuffix:Boolean (default = true) —— 一个布尔值，输出的字符串是否带后缀
		 * @param	suffix:String (default = "...") —— 一个字符串，输出字符串后缀的内容
		 * @param	charSet:String (default = "gb2312") —— 一个字符串，指定字符串的字符编码
		 * @return	String —— 截取的字符串
		 */
		public static function substr(source:String, length:int = 20, withSuffix:Boolean = true,
									  suffix:String = "...", charSet:String = GB2312) : String
		{
			var outStr:String = "";
			var totalLen:int;
			var char:String;
			var charLength:int;
			var strArr:Array = source.split("");
			var arrLen:int = strArr.length;
			var trueLen:int = source?getStrLength(source, charSet):0;
			var suffixLen:int = suffix?getStrLength(suffix, charSet):0;
			
			if(trueLen <= length)
			{
				outStr = source;
			}
			else
			{
				totalLen = withSuffix?suffixLen:0;
				
				for(var i : * in strArr)
				{
					char = strArr[i];
					charLength = getStrLength(char, charSet);
					totalLen += charLength;
					
					if(totalLen <= length)
					{
						outStr += char;
					}
					else
					{
						break;
					}
				}
				
				if(withSuffix)
				{
					outStr += suffix;
				}
			}
			
			return outStr;
		}
		
		/**
		 * 将二进制字节转换为字符串
		 * @param	source:ByteArray —— 二进制数据源
		 * @param	charSet:String —— 字符集
		 * @return	转换后的字符串
		 */
		public static function getBytesString(source:ByteArray, charSet:String = "utf-8"):String 
		{
			return source.readMultiByte(source.length, charSet);
		}
	}

}


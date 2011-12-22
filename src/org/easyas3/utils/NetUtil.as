package org.easyas3.utils
{
	import flash.errors.IOError;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * ... 网络信息处理工具类 ...
	 * @author Jerry ...
	 * @version 0.1.5
	 */
	public final class NetUtil
	{
		
		/** 指定一个新窗口。 */
		public static const BLANK_WINDOW:String = "_blank";
		
		/** 指定当前帧的父级。 */
		public static const PARENT_WINDOW:String = "_parent";
		
		/** 当前窗口中的当前帧。 */
		public static const SELF_WINDOW:String = "_self";
		
		/** 指定当前窗口中的顶级帧。 */
		public static const TOP_WINDOW:String = "_top";
		
		/**
		 * 在包含 Flash Player 容器的应用程序（通常是一个浏览器）中，打开或替换一个窗口。
		 * 在 Adobe AIR 中，该函数可在默认的系统 Web 浏览器中打开 URL。在默认的系统 Web 浏览器中打开 URL。
		 * @param	urlOrURLRequest:* —— 所请求的URL地址或者是URLRequest对象。
		 * @param	window:String —— 浏览器窗口或 HTML 帧。
		 */
		public static function getURL(urlOrURLRequest:*, window:String = null) : void
		{
			try
			{
				if(urlOrURLRequest is String)
				{
					navigateToURL(new URLRequest(urlOrURLRequest), window);
				}
				else if(urlOrURLRequest is URLRequest)
				{
					navigateToURL(urlOrURLRequest, window);
				}
			}
			catch(e : IOError)
			{
				throw "[输入输出错误]：" + e.message;
			}
			catch(e : SecurityError)
			{
				throw "[安全错误]：" + e.message;
			}
			catch(e : Error)
			{
				throw "[错误]：" + e.message;
			}
		}
	}

}


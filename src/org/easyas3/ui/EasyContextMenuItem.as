package org.easyas3.ui
{
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenuItem;
	import org.easyas3.events.EventDispatcherBase;
	import org.easyas3.utils.NetUtil;
	import org.easyas3.utils.ObjectUtil;
	
	/**
	 * ... 自定义右键菜单项容器 ...
	 * @author Jerry ...
	 * @version 0.6.0
	 */
	public final class EasyContextMenuItem extends EventDispatcherBase
	{
		
		/** @private 回调方法 */
		private var _callback:Function;
		
		/** @private 右键菜单项对象 */
		private var _item:ContextMenuItem;
		
		/** @private 链接地址 */
		private var _url:String;
		
		/** @private 浏览器窗口或 HTML 帧 */
		private var _window:String;
		
		/**
		 * 构造函数。构建ContextMenuItem对象
		 * @param	caption:String —— 菜单项标签内容
		 * @param	separatorBefore:Boolean (default = false) —— 在标签项前是否添加分栏线
		 * @param	enabled:Boolean (default = true) —— 菜单项是否可用
		 * @param	visible:Boolean (default = true) —— 菜单项是否可见
		 */
		public function EasyContextMenuItem(caption:String, separatorBefore:Boolean = false,
											enabled:Boolean = true, visible:Boolean = true)
		{
			_item = new ContextMenuItem(caption, separatorBefore, enabled, visible);
			_item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectEventHandler, false, 0, true);
		}
		
		/** 设置回调方法 */
		public function set callback(value:Function) : void
		{
			_callback = value;
		}
		
		/** 获取右键菜单项标题 */
		public function get caption() : String
		{
			return _item.caption;
		}
		
		/**
		 * 销毁对象方法
		 */
		public function dispose() : void
		{
			_item.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectEventHandler);
			_item = null;
		}
		
		/** 设置菜单项是否可用 */
		public function set enabled(value:Boolean) : void
		{
			_item.enabled = value;
		}
		
		/** 获取右键菜单项对象 */
		public function get item() : ContextMenuItem
		{
			return _item;
		}
		
		/** 设置在标签项前是否添加分栏线标识 */
		public function set separatorBefore(value:Boolean) : void
		{
			_item.separatorBefore = value;
		}
		
		/**
		 * 设置链接地址
		 */
		public function set url(value:String) : void
		{
			_url = value;
		}
		
		/** 设置菜单项是否可见 */
		public function set visible(value:Boolean) : void
		{
			_item.visible = value;
		}
		
		/** 设置浏览器窗口或 HTML 帧 */
		public function set window(value:String) : void
		{
			_window = value;
		}
		
		/**
		 * 处理用户从上下文菜单中选择某一项时分派的事件。
		 * @param	e:ContextMenuEvent —— ContextMenuEvent事件对象
		 */
		private function menuItemSelectEventHandler(e:ContextMenuEvent) : void
		{
			if(!ObjectUtil.isNull(_callback))
			{
				//调用回调方法
				_callback();
			}
			
			if(!ObjectUtil.isNull(_url))
			{
				//激活链接
				NetUtil.getURL(_url, _window);
			}
		}
	}

}


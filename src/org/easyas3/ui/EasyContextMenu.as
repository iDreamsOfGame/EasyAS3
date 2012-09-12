/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.ui
{
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import org.easyas3.events.IAdvancedEventDispatcher;
	import org.easyas3.utils.ObjectUtil;
	
	/**
	 * 自定义右键菜单类
	 * @author Jerry
	 */
	public final class EasyContextMenu extends EventDispatcher implements IAdvancedEventDispatcher
	{
		
		/**
		 * 右键菜单对象
		 * @private
		 */
		private var contextMenu:ContextMenu;
		
		/**
		 * 菜单项列表
		 * @private
		 */
		private var menuItems:Vector.<EasyContextMenuItem>;
		
		/**
		 * 右键菜单主体对象
		 * @private
		 */
		private var target:InteractiveObject;
		
		/**
		 * 构造函数
		 * @param	target:InteractiveObject — 右键菜单主体对象
		 * @param	removeBuiltInItems:Boolean (default = true) — 是否删除系统默认右键菜单标识
		 */
		public function EasyContextMenu(target:InteractiveObject, removeBuiltInItems:Boolean = true):void
		{
			this.target = target;
			initialize(removeBuiltInItems);
		}
		
		/**
		 * 添加回调方法右键菜单项
		 * @param	caption:String — 菜单项标签内容
		 * @param	callback:Function — 回调方法
		 * @param	separatorBefore:Boolean (default = false) — 在标签项前是否添加分栏线
		 * @param	enabled:Boolean (default = true) — 菜单项是否可用
		 * @param	visible:Boolean (default = true) — 菜单项是否可见
		 */
		public function addCallbackMenuItem(caption:String, callback:Function, separatorBefore:Boolean = false, enabled:Boolean = true, 
											visible:Boolean = true):void
		{
			var menuItem:EasyContextMenuItem = addItem(caption, separatorBefore, enabled, visible);
			menuItem.callback = callback;
		}
		
		/**
		 * 添加链接右键菜单项
		 * @param	caption:String — 菜单项标签内容
		 * @param	url:String — 链接地址
		 * @param	window:String (default = null) — 浏览器窗口或 HTML 帧
		 * @param	separatorBefore:Boolean (default = false) — 在标签项前是否添加分栏线
		 * @param	enabled:Boolean (default = true) — 菜单项是否可用
		 * @param	visible:Boolean (default = true) — 菜单项是否可见
		 */
		public function addLinkMenuItem(caption:String, url:String, window:String = null, separatorBefore:Boolean = false, enabled:Boolean = true,
										visible:Boolean = true):void
		{
			var menuItem:EasyContextMenuItem = addItem(caption, separatorBefore, enabled, visible);
			menuItem.url = url;
		}
		
		/**
		 * 添加普通的右键菜单项
		 * @param	caption:String — 菜单项标签内容
		 * @param	separatorBefore:Boolean (default = false) — 在标签项前是否添加分栏线
		 * @param	enabled:Boolean (default = true) — 菜单项是否可用
		 * @param	visible:Boolean (default = true) — 菜单项是否可见
		 */
		public function addMenuItem(caption:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):void
		{
			addItem(caption, separatorBefore, enabled, visible);
		}
		
		/**
		 * 销毁对象方法。当你准备移除EasyContextMenu对象时使用。在准备将EasyContextMenu对象置为null之前请先调用此方法
		 */
		public function dispose():void
		{
			for each(var item : EasyContextMenuItem in menuItems)
			{
				item.dispose();
				item = null;
			}
			
			contextMenu.customItems = null;
			menuItems = new Vector.<EasyContextMenuItem>();
			target.contextMenu = null;
		}
		
		/**
		 * 移除菜单项
		 * @param	caption:String — 菜单项标题
		 */
		public function removeMenuItem(caption:String):void
		{
			var menuItem:EasyContextMenuItem = findMenuItemByCaption(caption);
			
			if(!ObjectUtil.isNull(menuItem))
			{
				//从contextMenu.customItems中删除菜单项
				for(var i:int = 0, length:int = contextMenu.customItems.length; i < length; i++)
				{
					var item:ContextMenuItem = contextMenu.customItems[i];
					
					if(menuItem.caption == item.caption)
					{
						contextMenu.customItems.splice(i, 1);
						break;
					}
				}
				
				//从menuItems中删除菜单项容器
				for(var j:int = 0, len:int = menuItems.length; j < len; j++)
				{
					var easyMenuItem:EasyContextMenuItem = menuItems[j];
					
					if(menuItem.caption == easyMenuItem.caption)
					{
						menuItems.splice(j, 1);
						break;
					}
				}
				
				//销毁对象
				menuItem.dispose();
				menuItem = null;
			}
		}
		
		/**
		 * 添加菜单项
		 * @private
		 * @param	caption:String — 菜单项标签内容
		 * @param	separatorBefore:Boolean (default = false) — 在标签项前是否添加分栏线
		 * @param	enabled:Boolean (default = true) — 菜单项是否可用
		 * @param	visible:Boolean (default = true) — 菜单项是否可见
		 * @return	EasyContextMenuItem — 返回创建的菜单项对象
		 */
		private function addItem(caption:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):EasyContextMenuItem
		{
			var menuItem:EasyContextMenuItem = findMenuItemByCaption(caption);
			
			if(ObjectUtil.isNull(menuItem))
			{
				menuItem = new EasyContextMenuItem(caption, separatorBefore, enabled, visible);
				contextMenu.customItems.push(menuItem.item);
				menuItems.push(menuItem);
			}
			else
			{
				menuItem.separatorBefore = separatorBefore;
				menuItem.enabled = enabled;
				menuItem.visible = visible;
			}
			
			return menuItem;
		}
		
		/**
		 * 根据给定的caption查找指定的右键菜单项
		 * @private
		 * @param	caption:String — 菜单项标题
		 * @return	EasyContextMenuItem — 右键菜单对象
		 */
		private function findMenuItemByCaption(caption:String):EasyContextMenuItem
		{
			for each(var item : EasyContextMenuItem in menuItems)
			{
				if(item.caption == caption)
				{
					return item;
				}
			}
			return null;
		}
		
		/**
		 * 初始化方法
		 * @private
		 * @param	removeBuiltInItems:Boolean (default = true) — 是否删除系统默认右键菜单标识
		 */
		private function initialize(removeBuiltInItems:Boolean = true):void
		{
			menuItems = new Vector.<EasyContextMenuItem>();
			contextMenu = new ContextMenu();
			target.contextMenu = contextMenu;
			
			if(removeBuiltInItems)
			{
				contextMenu.hideBuiltInItems();
			}
		}
	}

}


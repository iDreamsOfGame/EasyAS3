package org.puremvc.as3.multicore.patterns.mediator
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	/**
	 * ... 高级视图中介器 ...
	 * @author Jerry
	 */
	public class AdvancedMediator extends Mediator
	{
		/**
		 * 构造函数
		 * @param	mediatorName:String (default = null) —— 中介器名称
		 * @param	viewComponent:Object (default = null) —— 视图组件
		 */
		public function AdvancedMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
		}
		
		/**
		 * 获取代理
		 * @param	proxyName:String —— 代理名称
		 * @return	代理对象
		 */
		public function getProxy(proxyName:String):IProxy 
		{
			return facade.retrieveProxy(proxyName);
		}
		
		/**
		 * 处理关注的消息
		 * 在继承的子类中只需使用notificationName + "NotifyHandler"定义方法名即可处理消息
		 * 注意：消息处理方法必须声明为public
		 * @param	note:INotifacation —— 消息数据对象
		 */
		override public function handleNotification(note:INotification):void
		{
			var notificationName:String;
			var handlerName:String;
			var notifications:Array = listNotificationInterests();
			var currentNotificationName:String = note.getName();
			
			for each(notificationName in notifications)
			{
				if (currentNotificationName == notificationName)
				{
					handlerName = notificationName + "NotifyHandler";
					
					if (this[handlerName])
					{
						this[handlerName](note);
						return;
					}
				}
			}
		}
	}

}
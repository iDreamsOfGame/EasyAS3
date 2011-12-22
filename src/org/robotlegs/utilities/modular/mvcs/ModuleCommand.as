package org.robotlegs.utilities.modular.mvcs
{
	import flash.events.Event;
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.modular.core.IModuleCommandMap;
	import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;
	
	public class ModuleCommand extends Command
	{
		
		[Inject]
		public var moduleCommandMap:IModuleCommandMap;
		
		[Inject]
		public var moduleEventDispatcher:IModuleEventDispatcher;
		
		protected function dispatchToModules(event:Event) : Boolean
		{
			if(moduleEventDispatcher.hasEventListener(event.type))
				return moduleEventDispatcher.dispatchEvent(event);
			return true;
		}
	}
}
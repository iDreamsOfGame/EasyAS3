/*
* Copyright (c) 2009 the original author or authors
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package org.swiftsuspenders
{
	import org.swiftsuspenders.injectionresults.InjectionResult;
	
	public class InjectionConfig
	{
		public var injectionName : String;
		
		/*******************************************************************************************
		 *								public properties										   *
		 *******************************************************************************************/
		public var request : Class;
		
		
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_injector : Injector;
		
		private var m_result : InjectionResult;
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectionConfig(request : Class, injectionName : String)
		{
			this.request = request;
			this.injectionName = injectionName;
		}
		
		public function getResponse(injector : Injector) : Object
		{
			if(m_result)
			{
				return m_result.getResponse(m_injector || injector);
			}
			var parentConfig : InjectionConfig =
				(m_injector || injector).getAncestorMapping(request, injectionName);
			if(parentConfig)
			{
				return parentConfig.getResponse(injector);
			}
			return null;
		}
		
		public function hasOwnResponse() : Boolean
		{
			return m_result != null;
		}
		
		public function hasResponse(injector : Injector) : Boolean
		{
			if(m_result)
			{
				return true;
			}
			var parentConfig : InjectionConfig =
				(m_injector || injector).getAncestorMapping(request, injectionName);
			return parentConfig != null;
		}
		
		public function setInjector(injector : Injector) : void
		{
			m_injector = injector;
		}
		
		public function setResult(result : InjectionResult) : void
		{
			m_result = result;
		}
	}
}
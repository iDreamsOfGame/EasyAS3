/*	
	====================================================================================
	2009 | John Dalziel  | The Computus Engine  |  http://www.computus.org

	All source code licenced under The MIT Licence
	====================================================================================  
*/

package org.computus.utils.timekeeper
{
	import flash.events.Event;
	
	/**
	 * An event broadcast by the Timekeeper when it's value changes.
	 * 
	 * @see org.computus.utils.timekeeper.Timekeeper
  	 */
      
	public class TimekeeperEvent extends Event 
	{
   
	// ------------------------------------------
	// PROPERTIES

		/**
		 * A constant for the event type.
		 */
		public static const CHANGE:String = "change";
		
		/**
		 * The current time value of the Timekeeper.
		 */
		public var time:Number
      
	// ------------------------------------------
	// CONSTRUCTOR
	
		/**
		 * Creates a new instance of a TimekeeperEvent.
		 * 
		 * @param type The event type. 
		 * @param time A value of time. 
  		 */  
		public function TimekeeperEvent(type:String, time:Number):void
		{
			super(type, true);
			this.time = time
		}
      
	// ------------------------------------------
	// PUBLIC
      
		/**
		 * Creates a copy of the TimekeeperEvent.
  		 */  
		public override function clone():Event 
		{
			return new TimekeeperEvent(type, time);
		}
	}
}
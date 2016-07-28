package com.physic.event 
{
	import flash.events.Event;
	
	/**
	 * Eventos para Gravity
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class GravityEvent extends Event 
	{
		/**
		 * Quando o corpo parar
		 */
		public static const ON_SOME_BODY_STOP:String = "gravityEvent_onSomeBodyStop";
		
		public function GravityEvent(type:String) 
		{ 
			super(type);
			
		} 
		
	}
	
}
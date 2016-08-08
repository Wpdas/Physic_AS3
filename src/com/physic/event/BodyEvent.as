package com.physic.event 
{
	import flash.events.Event;
	
	/**
	 * Eventos de corpo Body
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class BodyEvent extends Event 
	{
		
		/**
		 * Quando clicar sobre um elemento Body
		 */
		public static const ON_TAP_CLICK:String = "bodyEvent_onTapClick";
		
		/**
		 * Quando adicionar força horizontal
		 */
		public static const ON_ADD_HORIZONTAL_FORCE:String = "bodyEvent_onAddHorizontalForce";
		
		/**
		 * Quando adicionar força vertical (sobre a gravidade)
		 */
		public static const ON_ADD_VERTICAL_FORCE:String = "bodyEvent_onAddVerticalForce";
		
		/**
		 * Quando o corpo parar
		 */
		public static const ON_BODY_STOP:String = "bodyEvent_onBodyStop";
		
		/**
		 * Quando o corpo subir
		 * @param	type
		 */
		public static const ON_MOVE_UP:String = "bodyEvent_onMoveUp"
		
		/**
		 * Quando o corpo descer
		 * @param	type
		 */
		public static const ON_MOVE_DOWN:String = "bodyEvent_onMoveDown"
		
		/**
		 * Quando ocorrer colisão com outro objeto
		 * @param	type
		 */
		public static const ON_COLLISION:String = "bodyEvent_onCollision";
		
		public function BodyEvent(type:String) 
		{ 
			super(type);
			
		} 
		
	}
	
}
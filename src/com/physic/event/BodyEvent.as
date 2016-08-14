package com.physic.event 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
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
		
		/**
		 * Quando o objeto entrar dentro do outro
		 */
		public static const ON_INTERSECTS:String = "bodyEvent_onIntersects";
		
		private var _otherElement:Object;
		private var _boundsOtherElement:Rectangle;
		
		/**
		 * 
		 * @param	type				Tipo de evento
		 * @param	otherElement		Elemento a qual teve interação com o corpo disparador (StaticBody, StaticBodyElement)
		 * @param	boundsOtherElement	Bordas do elemento a qual teve interação com o corpo disparador
		 */
		public function BodyEvent(type:String, otherElement:Object = null, boundsOtherElement:Rectangle = null) 
		{ 
			this._otherElement = otherElement;
			this._boundsOtherElement = boundsOtherElement;
			
			super(type);
		} 
		
		/**
		 * Elemento que sofreu interação com este corpo
		 */
		public function get otherElement():Object 
		{
			return _otherElement;
		}
		
		/**
		 * Bordas do elemento que sofreu interação com este corpo
		 */
		public function get boundsOtherElement():Rectangle 
		{
			return _boundsOtherElement;
		}
		
	}
	
}
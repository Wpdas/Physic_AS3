package com.physic.body.obj 
{
	import flash.events.EventDispatcher;
	
	/**
	 * Objeto pai de física
	 * 
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class PhysicObject extends EventDispatcher
	{
		
		/**
		 * Elemento criado com base neste objeto (PhysicObject)
		 */
		internal var _poSource:Object;
		
		/**
		 * Inicia o objeto de física
		 * @param source	Elemento criado com base neste objeto (PhysicObject)
		 */
		public function PhysicObject(source:Object = null){
			this._poSource = source;
		}
	}

}
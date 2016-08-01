package com.physic.starling.body 
{
	import com.physic.starling.display.SpritePhysicStarling;
	
	/**
	 * Corpo estatico Starling
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class StaticBodyStarling extends BodyStarling
	{
		
		/**
		 * Cria corpo estático Starling.
		 * @param	source	Objeto que vai ser inserido no corpo
		 */
		public function StaticBodyStarling(source:SpritePhysicStarling) 
		{
			super(source);
			this._type = StaticBodyStarling;
		}
		
	}

}
package com.physic.body 
{
	import com.physic.display.SpritePhysic;
	import flash.display.Sprite;
	
	/**
	 * Corpo estatico
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class StaticBody extends Body
	{
		
		/**
		 * Cria corpo estático.
		 * @param	source	Objeto que vai ser inserido na física
		 */
		public function StaticBody(source:SpritePhysic) 
		{
			super(source);
			this._type = StaticBody;
		}
		
	}

}
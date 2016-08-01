package com.physic.starling.body 
{
	import com.physic.starling.display.SpritePhysicStarling;
	
	/**
	 * Corpo Rígido Starling
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class RigidBodyStarling extends BodyStarling
	{
		
		/**
		 * Cria novo tipo de corpo
		 * @param	source				Objeto que vai ser inserido no corpo.
		 * @param	density				Densidade do objeto
		 * @param	enableSyncRotate	Habilitar movimento de textura sincronizada com o movimento do objeto?
		 */
		public function RigidBodyStarling(source:SpritePhysicStarling, density:Number = 0, enableSyncRotate:Boolean = false) 
		{
			super(source, density);
			this._type = RigidBodyStarling;
			this._enableSyncRotate = enableSyncRotate;
		}
		
	}

}
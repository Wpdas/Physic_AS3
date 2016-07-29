package com.physic.body 
{
	import com.physic.display.SpritePhysic;
	import flash.display.Sprite;
	import com.physic.body.Body;
	
	/**
	 * Corpo Rigido
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class RigidBody extends Body
	{
		
		/**
		 * Cria novo tipo de corpo
		 * @param	source				Objeto que vai ser inserido no corpo.
		 * @param	density				Densidade do objeto
		 * @param	enableSyncRotate	Habilitar movimento de textura sincronizada com o movimento do objeto?
		 */
		public function RigidBody(source:SpritePhysic, density:Number = 0, enableSyncRotate:Boolean = false) 
		{
			super(source, density);
			this._type = RigidBody;
			this._enableSyncRotate = enableSyncRotate;
		}
		
	}

}
package com.physic.collision 
{
	/**
	 * Tipos de colisão a ser executado pelo Gravity principal
	 * @author Wenderson Pires da Silva
	 */
	public class CollisionType 
	{
		/**
		 * Tipo de colisão por bitmap
		 */
		public static const BITMAP_COLLISION:String = "collisionType_bitimapCollision";
		
		/**
		 * Tipo de colisão por ponto de registro
		 */
		public static const POINT_COLLISION:String = "collisionType_pointCollision";
		
		/**
		 * Tipo de colisão por calculo de posição
		 */
		public static const CALCULATION_COLLISION:String = "collisionType_calculationCollision";
		
	}

}
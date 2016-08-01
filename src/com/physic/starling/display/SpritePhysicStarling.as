package com.physic.starling.display 
{
	import com.physic.pivot.Pivot;
	import com.physic.pivot.PivotRegister;
	import com.physic.starling.pivot.PivotRegisterStarling;
	import starling.display.Sprite;
	
	/**
	 * Tipo de objeto Sprite Starling modelado para suportar na framework SpritePhysic
	 * Pivot implementado. Usado para translação, escala e etc
	 * 
	 * @author Wenderson Pires da Silva
	 */
	public class SpritePhysicStarling extends Sprite
	{
		
		private var _pivot:PivotRegisterStarling;
		
		/**
		 * Instancia novo SpritePhysic
		 * @param	pivot	Passa as coordenadas do pivot (ponto de registro do objeto). Use Pivot.EIXO. Alinha ao Topo Esquerdo por default
		 */
		public function SpritePhysicStarling(pivot:String = Pivot.TOP_LEFT)
		{
			super();
			
			//Inicia atribuição de pivot
			_pivot = new PivotRegisterStarling(this, Pivot.TOP_LEFT);
		}
		
		/**
		 * Pivot
		 */
		public function get pivot():PivotRegisterStarling 
		{
			return _pivot;
		}
		
		/**
		 * Use Pivot.EIXO
		 * @param pivot	Coordenada de Pivot. User Pivot.EIXO
		 */
		public function updatePivot(pivot:String):void 
		{
			_pivot.newRegister(pivot);
		}
		
	}

}
package com.physic.display 
{
	import com.physic.pivot.Pivot;
	import com.physic.pivot.PivotRegister;
	import flash.display.Sprite;
	
	/**
	 * Tipo de objeto Sprite modelado para suportar na framework SpritePhysic
	 * Pivot implementado. Usado para translação, escala e etc
	 * 
	 * @author Wenderson Pires da Silva
	 */
	public class SpritePhysic extends Sprite
	{
		
		private var _pivot:PivotRegister;
		
		/**
		 * Instancia novo SpritePhysic
		 * @param	pivot	Passa as coordenadas do pivot (ponto de registro do objeto). Use Pivot.EIXO. Alinha ao Topo Esquerdo por default
		 */
		public function SpritePhysic(pivot:String = Pivot.TOP_LEFT)
		{
			super();
			
			//Inicia atribuição de pivot
			_pivot = new PivotRegister(this, Pivot.TOP_LEFT);
		}
		
		/**
		 * Pivot
		 */
		public function get pivot():PivotRegister 
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
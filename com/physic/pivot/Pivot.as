package com.physic.pivot
{
	/**
	 * ATENÇÃO: Esta classe é parte da lib Wenz. Para mais informações acesse: http://migre.me/5NXoo
	 * 
	 * Classe contendo os registros padrões e manual do PointRegister
	 * Todos os direitos estão reservados ao desenvolvedor.
	 * 
	 * @author Wenderson Pires da Silva - wpdas@yahoo.com.br
	 * @version 1.0
	 */
	public class Pivot 
	{
		//Alinhado à esquerda no topo.
		public static const TOP_LEFT:String = "topLeft";
		
		//Alinhado ao topo central.
		public static const TOP:String = "top";
		
		//Alinhado à direita no topo.
		public static const TOP_RIGHT:String = "topRight";
		
		//Alinhado centralmente no topo.
		public static const TOP_CENTER:String = "topCenter";
		
		//Alinhado à esquerda.
		public static const LEFT:String = "left";
		
		//Alinhado ao centro
		public static const CENTER:String = "center";
		
		//Alinhado à direita
		public static const RIGHT:String = "right";
		
		//Alinhado à esquerda na base
		public static const BOTTOM_LEFT:String = "bottonLeft";
		
		//Alinhado à base central
		public static const BOTTOM:String = "botton";
		
		//Alinhado à direita na base
		public static const BOTTOM_RIGHT:String = "bottonRight";
		
		//Alinhado centralmente na base
		public static const BOTTOM_CENTER:String = "bottonCenter";
		
		/**
		 * Novo ponto informado manualmente.
		 * @param	x	Eixo x.
		 * @param	y	Eixo y.
		 * @return	Array contendo os eixos.
		 */
		public static function MANUAL_POINT(x:Number, y:Number):String
		{
			var axis:String = "manualPoint," + x + "," + y;
			
			return axis;
		}
	}
}
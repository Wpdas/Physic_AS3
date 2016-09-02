package com.physic.plugin 
{
	import com.physic.body.Body;
	
	/**
	 * Insere propriedades e funções fora do contexto principal
	 * 
	 * Disponivel a partir da versão 1.2.0
	 * 
	 * @author Wenderson Pires da Silva
	 */
	public class Plugin 
	{
		protected var body:Body;
		
		//Vetor de plugins
		private static var _plugins:Vector.<Plugin> = new Vector.<Plugin>();
		
		public function Plugin(body:Body)
		{
			//Seta o objeto
			this.body = body;
		}
		
		/**
		 * Inicia plugin
		 */
		public function init():void {}
		
		/**
		 * Lista de plugins inseridos
		 */
		public static function get plugins():Vector.<Plugin> 
		{
			return _plugins;
		}
		
		/**
		 * Lista de plugins inseridos
		 */
		public static function set plugins(vector:Vector.<Plugin>):void {
			_plugins = vector;
		}
		
	}

}
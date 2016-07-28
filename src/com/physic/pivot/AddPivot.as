package com.physic.pivot 
{
	import flash.display.MovieClip;
	/**
	 * ATENÇÃO: Esta classe é parte da lib Wenz. Para mais informações acesse: http://migre.me/5NXoo
	 * 
	 * Classe responsável por inserir a propriedade pointRegister dentro do objeto passado.
	 * 
	 * @author Wenderson Pires da Silva - wpdas@yahoo.com.br
	 * @version 1.0
	 */
	public class AddPivot
	{
		/**
		 * Objeto a ser inserido a propriedade
		 * @param	source	DisplayObject a ser inserido a propriedade "pointRegister".
		 * @param	register	Registro inicial. (Use Registers).
		 */
		public static function addPivot(source:MovieClip, register:String)
		{
			//Novo ponto de registro com registro default
			var pr:PivotRegister = new PivotRegister(source, register);
			
			(source as Object).pivot = pr;
		}
	}
}
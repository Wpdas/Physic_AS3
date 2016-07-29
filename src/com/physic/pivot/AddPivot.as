package com.physic.pivot 
{
	import flash.display.MovieClip;
	/** 
	 * Responsável por inserir a propriedade pointRegister dentro do objeto passado.
	 * 
	 * @author Wenderson Pires da Silva - wpdas@yahoo.com.br
	 * @version 1.0
	 */
	public class AddPivot
	{
		/**
		 * Objeto a ser inserido a propriedade
		 * 
		 * @example Exemplo de uso:
		 * <listing version="3.0">
		 * AddPivot.addPivot(elemento, Pivot.TOP_LEFT);
		 * </listing>
		 * 
		 * @param	source	DisplayObject a ser inserido a propriedade "pointRegister".
		 * @param	register	Registro inicial. (Use Registers).
		 */
		public static function addPivot(source:MovieClip, register:String):void
		{
			//Novo ponto de registro com registro default
			var pr:PivotRegister = new PivotRegister(source, register);
			
			(source as Object).pivot = pr;
		}
	}
}
package com.physic.pivot
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * Responsável por modificar o ponto de registro de um DisplayObject.
	 * 
	 * @example Exemplo de uso:
	 * <listing version="3.0">
	 * var objetoPoint:PointRegister = new PointRegister(objeto, Registers.CENTER);
	 * </listing>
	 * 
	 * Existe a possibilidade de alterar o ponto de registro:
	 * <listing version="3.0">
	 * objetoPoint.newRegister(Registers.MANUAL_POINT(10, 10));
	 * </listing>
	 * 
	 * @author Wenderson Pires da Silva - wpdas@yahoo.com.br
	 * @version 1.0
	 */
	public class PivotRegister 
	{
		//Constantes
		private const MANUAL_POINT:String = "manualPoint";
		
		//Objeto a ser manipulado
		private var source:DisplayObject;
		
		//Propriedades
		private var pointX:Number;
		private var pointY:Number;
		private var point:Point;
		
		/**
		 * Novo ponto de registro.
		 * @param	source	Objeto a ser manipulado.
		 * @param	register	Ponto de registro. (Use Register).
		 */
		public function PivotRegister(source:DisplayObject, register:String)
		{
			this.source = source;
			
			//Informa o novo registro
			newRegister(register);
		}
		
		/**
		 * Novo registro.
		 * @param	register	Ponto de registro. (Use Register).
		 */
		public function newRegister(register:String):void
		{	
			if (register == Pivot.TOP_LEFT) pointX = 0, pointY = 0;
			if (register == Pivot.TOP) pointX = source.width / 2, pointY = 0;
			if (register == Pivot.TOP_RIGHT) pointX = source.width, pointY = 0;
			if (register == Pivot.TOP_CENTER) pointX = source.width / 2, pointY = 0;
			if (register == Pivot.LEFT) pointX = 0, pointY = source.height / 2;
			if (register == Pivot.CENTER) pointX = source.width / 2, pointY = source.height / 2;
			if (register == Pivot.BOTTOM_LEFT) pointX = 0, pointY = source.height;
			if (register == Pivot.BOTTOM) pointX = source.width / 2, pointY = source.height;
			if (register == Pivot.BOTTOM_RIGHT) pointX = source.width, pointY = source.height;
			if (register == Pivot.BOTTOM_CENTER) pointX = source.width / 2, pointY = source.height;
			if (register.slice(0, 11) == MANUAL_POINT) pointX = Number(register.split(",", 3)[1]), pointY = Number(register.split(",", 3)[2]);
			
			point = new Point(pointX, pointY);
		}
		
		/**
		 * Propriedade na qual necessita de correção dos eixos do objeto.
		 * @param	property	Nome da propriedade.
		 * @param	value	Valor numérico.
		 */
		private function setProperty(property:String, value:Number):void
		{
			//Define o ponto atual
			var currentPoint:Point = source.parent.globalToLocal(source.localToGlobal(point));
			
			//Acessa a propriedade e insere o valor
			source[property] = value;
			
			//Define o ponto atual depois da inserção do novo valor da propriedade no objeto
			var currentPoint2:Point = source.parent.globalToLocal(source.localToGlobal(point));
			
			//Faz a correção dos eixos
			source.x -= currentPoint2.x - currentPoint.x;
			source.y -= currentPoint2.y - currentPoint.y;
		}
		
		/**
		 * Coordenada x.
		 */
		public function get x():Number
		{
			//Define o ponto atual
			var currentPoint:Point = source.parent.globalToLocal(source.localToGlobal(point));
			
			//Retorna a propriedade atual.
			return currentPoint.x;
		}
		
		/**
		 * Coordenada x.
		 */
		public function set x(value:Number):void
		{
			//Define o ponto atual
			var currentPoint:Point = source.parent.globalToLocal(source.localToGlobal(point));
			
			//Atualiza a posição do objeto
			source.x += value - currentPoint.x;
		}
		
		/**
		 * Coordenada y.
		 */
		public function get y():Number
		{
			//Define o ponto atual
			var currentPoint:Point = source.parent.globalToLocal(source.localToGlobal(point));
			
			//Retorna a propriedade atual.
			return currentPoint.y;
		}
		
		/**
		 * Coordenada y.
		 */
		public function set y(value:Number):void
		{
			//Define o ponto atual
			var currentPoint:Point = source.parent.globalToLocal(source.localToGlobal(point));
			
			//Atualiza a posição do objeto
			source.y += value - currentPoint.y;
		}
		
		/**
		 * Escala no eixo x.
		 */
		public function get scaleX():Number
		{
			return source.scaleX;
		}
		
		/**
		 * Escala no eixo x.
		 */
		public function set scaleX(value:Number):void
		{
			//Faz as alterações na propriedade do objeto
			setProperty("scaleX", value);
		}
		
		/**
		 * Escala no eixo y.
		 */
		public function get scaleY():Number
		{
			return source.scaleY;
		}
		
		/**
		 * Escala no eixo y.
		 */
		public function set scaleY(value:Number):void
		{
			//Faz as alterações na propriedade do objeto
			setProperty("scaleY", value);
		}
		
		/**
		 * Largura
		 */
		public function get width():Number
		{
			return source.width;
		}
		
		/**
		 * Largura
		 */
		public function set width(value:Number):void
		{
			setProperty("width", value);
		}
		
		/**
		 * Altura
		 */
		public function get height():Number
		{
			return source.height;
		}
		
		/**
		 * Altura
		 */
		public function set height(value:Number):void
		{
			setProperty("height", value);
		}
		
		/**
		 * Parent
		 */
		public function get parent():DisplayObjectContainer
		{
			return source.parent;
		}
		
		/**
		 * Rotação.
		 */
		public function get rotation():Number
		{
			return source.rotation;
		}
		
		/**
		 * Rotação.
		 */
		public function set rotation(value:Number):void
		{
			//Faz as alterações na propriedade do objeto
			setProperty("rotation", value);
		}
		
		/**
		 * Ponto do mouseX no objeto.
		 */
		public function get mouseX():Number
		{
			//mouseX atualizado
			return Math.round(this.mouseX - point.x);
		}
		
		/**
		 * Ponto do mouseY no objeto.
		 */
		public function get mouseY():Number
		{
			//mouseY atualizado
			return Math.round(this.mouseY - point.y);
		}
	}
}
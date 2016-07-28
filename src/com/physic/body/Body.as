package com.physic.body 
{
	import com.physic.body.obj.PhysicObject;
	import com.physic.display.SpritePhysic;
	import com.physic.event.BodyEvent;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Corpo
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class Body extends PhysicObject
	{
		//Definições internas
		private var _body:SpritePhysic;
		internal var _type:Class;
		private var _gForce:Number = 0; //Força atual a qual sofrera alteração da gravidade
		
		//Controlador de direcao
		private var _isDown:Boolean = true;
		
		//Deve ter rotação sincronizada
		internal var _enableSyncRotate:Boolean; //Usado em RigidBody
		
		//Controle de força horizontal
		private var _horizontalForce:Number = 0;
		private var _horizontalForceIsContinuous:Boolean = false;
		private var _enableHorizontalForce:Boolean = false; //Status, o movimento sobre a força horizontal está ativada?
		
		//Tratador de eventos
		private var dispatcherUp:Boolean = false;
		private var dispatcherDown:Boolean = false;
		
		//Transformed BitmapData
		private var _bitmap:BitmapData;
		
		//Densidade
		private var _density:Number = 0;
		
		/**
		 * Cria novo tipo de corpo. O objeto source deve ter originalmente o ponto de registro alocado ao Topo Esquerdo.
		 * O Pivot deve ser auterado (quando necessario) depois de instanciar o objeto através do metodo "updatePivot(Pivot.EIXO)"
		 * 
		 * Para alterar os atributos de posição, rotação, escala e etc... do objeto. Use "objetoInstanciado.pivot.x" etc
		 * 
		 * @param	source		Objeto que vai ser inserido na física. Pode ser usado SpritePhysic
		 * @param	density		Densidade do objeto
		 */
		public function Body(source:SpritePhysic, density:Number = 0)
		{
			this._body = source;
			this._density = getDensityFactor(density); //Seta fator de densidade
			
			//Inicia bitmap usado para tratar colisões
			_bitmap = new BitmapData(source.pivot.width, source.pivot.height, true, 0x00000000);
			_bitmap.draw(source);
			
			//Inicia tratamento de eventos
			this._body.addEventListener(MouseEvent.MOUSE_DOWN, onTapBody);
		}
		
		/**
		 * Quando toca no corpo
		 * @param	e
		 */
		private function onTapBody(e:MouseEvent):void 
		{
			//Dispara evento de toque/clique
			dispatchEvent(new BodyEvent(BodyEvent.ON_TAP_CLICK));
		}
		
		private function getDensityFactor(density:Number):Number {
			return density / 10;
		}
		
		/**
		 * Corpo
		 */
		public function get body():SpritePhysic 
		{
			return _body;
		}
		
		public function get type():Class 
		{
			return _type;
		}
		
		/**
		 * Força a qual sofre alteraçao da gravidade
		 */
		public function get gForce():Number 
		{
			return _gForce;
		}
		
		/**
		 * Atualiza Bitmap de colisão
		 */
		public function updateBitmap():void {
			
			_bitmap.dispose();
			_bitmap = new BitmapData(_body.pivot.width, _body.pivot.height, true, 0x00000000);
			_bitmap.draw(_body);
		}
		
		/**
		 * Força a qual sofre alteraçao da gravidade
		 */
		public function set gForce(value:Number):void 
		{
			var firstValue:Number = _gForce;
			var secondValue:Number = value;
			
			_gForce = value;
			
			//Verifica fator que recebe gravidade para tratar eventos
			if (_gForce < 0){
				
				if (!dispatcherUp) {
					
					dispatcherUp = true;
					dispatcherDown = false;
					
					//Dispara evento informando que este corpo esta subindo
					dispatchEvent(new BodyEvent(BodyEvent.ON_MOVE_UP));
					
					if (!_isDown) {
						
						//Dispara evento informando que este corpo foi parado
						dispatchEvent(new BodyEvent(BodyEvent.ON_BODY_STOP));
					}
				}
			};
			
			if (_gForce > 0){
				
				if (!dispatcherDown) {
					
					dispatcherUp = false;
					dispatcherDown = true;
					
					//Dispara evento informando que este corpo esta descendo
					dispatchEvent(new BodyEvent(BodyEvent.ON_MOVE_DOWN));
					
					if (!_isDown) {
						
						//Dispara evento informando que este corpo foi parado
						dispatchEvent(new BodyEvent(BodyEvent.ON_BODY_STOP));
					}
				}
			};
		}
		
		/**
		 * Posição relativa do corpo não do objeto de textura (base na parte de baixo)
		 */
		public function get positionY():Number {
			
			return _body.y + _body.height / 2;
		}
		
		/**
		 * Posição relativa do corpo não do objeto de textura (base na parte de baixo)
		 */
		public function set positionY(value:Number):void {
			
			_body.y = value + (_body.height / 2);
		}
		
		/**
		 * Verifica se a sincronia de rotação está ativada com o movimento do objeto
		 */
		public function get syncRotateEnabled():Boolean 
		{
			return _enableSyncRotate;
		}
		
		/**
		 * Força horizontal do corpo
		 */
		public function get horizontalForce():Number 
		{
			return _horizontalForce;
		}
		
		/**
		 * Força horizontal do corpo
		 */
		public function set horizontalForce(value:Number):void
		{
			_horizontalForce = value;
		}
		
		/**
		 * Retorna se a força horizontal aplicada é estática ou se é manipulada pela gravidade
		 */
		public function get horizontalForceIsContinuous():Boolean 
		{
			return _horizontalForceIsContinuous;
		}
		
		/**
		 * O movimento horizontal na gravidade foi ativada?
		 */
		public function get enableHorizontalForce():Boolean 
		{
			return _enableHorizontalForce;
		}
		
		/**
		 * Valor da densidade
		 */
		public function get density():Number 
		{
			return _density;
		}
		
		/**
		 * Valor da densidade
		 */
		public function set density(value:Number):void 
		{
			_density = getDensityFactor(value);
		}
		
		/**
		 * Esta caindo?
		 */
		public function get isDown():Boolean 
		{
			return _isDown;
		}
		
		/**
		 * Esta caindo?
		 */
		public function set isDown(value:Boolean):void 
		{
			_isDown = value;
			
			//Se parar movimento
			/*if (!_isDown) {
				
				//Dispara evento informando que este corpo foi parado
				dispatchEvent(new BodyEvent(BodyEvent.ON_BODY_STOP));
			}*/
		}
		
		/**
		 * BitmapData para colisão
		 */
		public function get bitmap():BitmapData 
		{
			return _bitmap;
		}
		
		/**
		 * BitmapData para colisão
		 */
		public function set bitmap(value:BitmapData):void 
		{
			_bitmap = value;
		}
		
		/**
		 * Adiciona uma força horizontal ao objeto
		 * @param	force 			Propriedades de força do objeto
		 * @param	isContinuous	Movimento é contínuo ou sofre ação da gravidade?
		 */
		public function addHorizontalForce(force:Number, isContinuous:Boolean = false):void {
			
			//Habilita movimento por força horizontal
			_enableHorizontalForce = true;
			
			//Seta os valores
			_horizontalForce = force;
			_horizontalForceIsContinuous = isContinuous;
			
			//Dispara evento informando que foi adcionado força horizontal
			dispatchEvent(new BodyEvent(BodyEvent.ON_ADD_HORIZONTAL_FORCE));
		}
		
		/**
		 * Adiciona uma força vertical ao objeto (Aplica direto sobre a gravidade)
		 * @param	force 			Propriedades de força do objeto
		 */
		public function addVerticalForce(force:Number):void {
			
			//Implementa força vertical na gravidade
			_gForce = force;
			isDown = true;
			
			//Dispara evento informando que foi adcionado força horizontal
			dispatchEvent(new BodyEvent(BodyEvent.ON_ADD_VERTICAL_FORCE));
		}
		
		/**
		 * Remove todos os processos para matar o objeto e liberar memoria e processamento
		 */
		public function dispose():void {
			
			//Remove eventos
			this._body.removeEventListener(MouseEvent.MOUSE_DOWN, onTapBody);
		}
		
	}

}
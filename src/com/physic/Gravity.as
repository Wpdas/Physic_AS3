package com.physic 
{
	import com.physic.body.Body;
	import com.physic.body.RigidBody;
	import com.physic.body.StaticBody;
	import com.physic.body.obj.PhysicObject;
	import com.physic.collision.CollisionType;
	import com.physic.event.GravityEvent;
	import flash.geom.Point;
	
	/**
	 * 
	 * <img src="https://github.com/Wpdas/Physic_AS3/raw/master/docs/billard-gl.png"/> <br>
	 * 
	 * <p>Biblioteca para simulação de gravidade (Gravidade, Resistência, Força, Força Resultante, Colisão e Impulsão).</p>
	 * 
	 * <p>O exemplo de uso pode ser visto neste link: <strong><a target="_blank" href="https://github.com/Wpdas/Physic_AS3/blob/master/example/">Example Files</a></strong></p>
	 * 
	 * @author Wenderson Pires da Silva - @wpdas
	 * @version 1.0.0
	 */
	public class Gravity extends PhysicObject
	{
		//Vetor de corpos
		protected var staticBodyList:Vector.<Body>;
		protected var rigidBodyList:Vector.<Body>;
		
		//Fatores de gravidade
		protected var _gravity:Number = 9.8;
		protected var gravityForce:Number = 0; //Gravidade vertical
		protected var resistance:Number; //Resistencia da gravidade (Aquela que é interpretada como resistencia do ar)
		protected var minDefictPixelGravityForce:Number = gravityForce;
		
		//Tipos de colisão a ser executada
		protected var collisonType:String = CollisionType.POINT_COLLISION;
		
		/**
		 * Inicia a força da gravidade
		 * @param	resistance		Resistencia da gravidade (interpretada como resistencia do Ar)
		 * @param	gravity			Força de gravidade
		 * @param	collisionType	Tipo de colisão que deverá ser usado na gravidade (use CollisionType.TYPE). CollisionType.BITMAP_COLLISION por default.
		 */
		public function Gravity(resistance:Number = 1, gravity:Number = 9.8, collisionType:String = CollisionType.POINT_COLLISION){
			
			//Aviso
			trace("PHYSIC: Todos os elementos com base PhysicObject devem ter alinhamento padrão no Topo Esquerdo. O Pivot deve ser alterado usando 'pivot.x' e etc.");
			
			//Seta
			this.resistance = resistance / 100;//Resistencia do ar
			
			//Aplica gravidade
			_gravity = gravity;
			this.gravityForce = _gravity / 15; //15 é para criar um fator legivel que trabalhe a gravidade com pixel
			
			//Inicia o vetor
			staticBodyList = new Vector.<Body>();
			rigidBodyList = new Vector.<Body>();
			
			//Seta o tipo de colisão a ser tratada
			this.collisonType = collisonType;
		}
		
		/**
		 * Inserir corpo à força gravitacional
		 * @param	child	Body a ser inserido no campo gravitacional
		 */
		public function insertBody(child:Body):void {
			
			//insere cada tipo em sua lista
			if (child.type == RigidBody) rigidBodyList.push(child);
			if (child.type == StaticBody) staticBodyList.push(child);
		}
		
		/**
		 * Remover corpo da força gravitacional
		 * @param	child	Body a ser retirado no campo gravitacional
		 */
		public function removeBody(child:Body):void {
			
			if (child.type == RigidBody) {
				
				if(rigidBodyList.indexOf(child) >= 0) rigidBodyList.splice(rigidBodyList.indexOf(child), 1);
				
			};
			
			if (child.type == StaticBody) {
				
				if(staticBodyList.indexOf(child) >= 0) staticBodyList.splice(staticBodyList.indexOf(child), 1);
				
			};
		}
		
		/**
		 * Renderiza processo de gravidade
		 */
		public function render():void {
			
			//Corpo a ser processado
			var currentBody:Body;
			var currentSolidBody:Body;
			
			//Processa
			for (var i:uint = 0; i < rigidBodyList.length; i++){
				
				//Gravidade
				currentBody = rigidBodyList[i];
				if (currentBody.isDown) currentBody.gForce += gravityForce;
				else currentBody.gForce = 0;
				
				//Trata finalizador de gravidade caso o elemento esteja inteiramente no chao
				//if (currentBody.isDown){
				
					//Implementação de AnotherElement
					currentBody.body.pivot.y += currentBody.gForce;
					
					//Verifica se colidiu com algum corpo solido
					for (var s:uint = 0; s < staticBodyList.length; s++){
						
						//Seta corpo solido
						currentSolidBody = staticBodyList[s];
							
						//Processa colisão
						
						//Atualiza local de colisão
						//currentBody.updateBitmap();
						//currentSolidBody.updateBitmap(); (!) Deve ser chamada pelo desenvolvedor
						
						if (currentBody.isDown){
						
							//Se o tipo de colisão for Bitmap
							if (collisonType == CollisionType.BITMAP_COLLISION){
								
								var point1:Point = new Point(currentSolidBody.body.x, currentSolidBody.body.y); //Pontos de pixel a partir do Topo esquerdo das bases solidas
								var point2:Point = new Point(currentBody.body.x, currentBody.body.y);// Pontos de pixel a partir do Topo esquerdo dos corpos rigidos
								
								//Verifica se o pixel está colidindo
								if(currentSolidBody.bitmap.hitTest(point1, 255, currentBody.bitmap, point2, 255)) {
									currentBody.gForce = (currentBody.gForce / (0.978 + currentBody.density)) * -1; //0.978 Fator de gravidade aplicada / 10
									
									//Verifica se continua se movimentando horizontalmente
									currentBody.isDown = (Math.abs(currentBody.gForce) - gravityForce) >= minDefictPixelGravityForce;
									
									//Se o objeto for setado como false, dispara evento informando que algum elemento de Body foi parado (o efeito da gravidade)
									if (!currentBody.isDown) dispatchEvent(new GravityEvent(GravityEvent.ON_SOME_BODY_STOP));
								}
							}
							
							//Se o tipo de colisão for por ponto
							if (collisonType == CollisionType.POINT_COLLISION){
								
								if(currentSolidBody.body.hitTestPoint(currentBody.body.pivot.x, currentBody.body.pivot.y, true) && currentBody.gForce > 0) {
									currentBody.gForce = (currentBody.gForce / (0.978 + currentBody.density)) * -1; //0.978 Fator de gravidade aplicada / 10
									
									//Verifica se continua se movimentando horizontalmente
									currentBody.isDown = (Math.abs(currentBody.gForce) - gravityForce) >= minDefictPixelGravityForce;
									
									//Se o objeto for setado como false, dispara evento informando que algum elemento de Body foi parado (o efeito da gravidade)
									if (!currentBody.isDown) dispatchEvent(new GravityEvent(GravityEvent.ON_SOME_BODY_STOP));
								}
							}
							
							//Se o tipo de colisão for por calculo
							if (collisonType == CollisionType.CALCULATION_COLLISION) {
								
								if (currentBody.positionY >= currentSolidBody.body.pivot.y && currentBody.gForce > 0){
									currentBody.gForce = (currentBody.gForce / (0.978 + currentBody.density)) * -1; //0.978 Fator de gravidade aplicada / 10
									
									//Verifica se continua se movimentando horizontalmente
									currentBody.isDown = (Math.abs(currentBody.gForce) - gravityForce) >= minDefictPixelGravityForce;
									
									//Se o objeto for setado como false, dispara evento informando que algum elemento de Body foi parado (o efeito da gravidade)
									if (!currentBody.isDown) dispatchEvent(new GravityEvent(GravityEvent.ON_SOME_BODY_STOP));
								}
								
							}
						
						}
					}
					
				//}
				
				
				
				
				//Verifica se esta ocorrendo contato para ativar novamente a caida
				if(!currentBody.body.hitTestObject(currentSolidBody.body) && !currentBody.isDown) {
					currentBody.isDown = true;
				}
				
				//Processa força horizontal
				if (currentBody.enableHorizontalForce && Math.abs(currentBody.horizontalForce) > resistance){
					
					//Aplica força no objeto
					currentBody.body.pivot.x += currentBody.horizontalForce;
					
					if (!currentBody.horizontalForceIsContinuous && Math.abs(currentBody.horizontalForce) > 0 && _gravity > 0){
						
						//Retira força através da resistencia
						currentBody.horizontalForce -= resistance;
					}
					
				} else {
					
					//Aplica valor 0 para parar o objeto
					currentBody.horizontalForce = 0;
					
				}
				
				//Processa a sincronização de rotação do objeto com a direção do movimento
				if (currentBody.syncRotateEnabled){
					
					currentBody.body.pivot.rotation += currentBody.horizontalForce;
				}
				
			}
			
		}
		
		/**
		 * Remove todos os processos para matar o objeto e liberar memoria e processamento
		 */
		public function dispose():void {
			
			staticBodyList = null;
			rigidBodyList = null;
		}
		
		/**
		 * Gravidade
		 */
		public function get gravity():Number 
		{
			return _gravity;
		}
		
		/**
		 * Gravidade
		 */
		public function set gravity(value:Number):void 
		{
			_gravity = value;
			this.gravityForce = _gravity / 15;
		}
		
	}

}
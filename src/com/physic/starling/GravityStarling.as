package com.physic.starling 
{
	import com.physic.body.obj.PhysicObject;
	import com.physic.collision.CollisionType;
	import com.physic.event.GravityEvent;
	import com.physic.starling.body.BodyStarling;
	import com.physic.starling.body.RigidBodyStarling;
	import com.physic.starling.body.StaticBodyStarling;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Gravidade para Starling
	 * @author Wenderson Pires da Silva - @wpdas
	 */
	public class GravityStarling extends PhysicObject
	{
		//Vetor de corpos
		protected var staticBodyList:Vector.<BodyStarling>;
		protected var rigidBodyList:Vector.<BodyStarling>;
		
		//Fatores de gravidade
		protected var _gravity:Number = 9.8;
		protected var gravityForce:Number = 0; //Gravidade vertical
		protected var resistance:Number; //Resistencia da gravidade (Aquela que é interpretada como resistencia do ar)
		protected var minDefictPixelGravityForce:Number = gravityForce;
		
		//Tipos de colisão a ser executada
		protected var collisonType:String = CollisionType.POINT_COLLISION;
		
		/**
		 * Inicia a força da gravidade - Starling
		 * @param	resistance		Resistencia da gravidade (interpretada como resistencia do Ar)
		 * @param	gravity			Força de gravidade
		 */
		public function GravityStarling(resistance:Number = 1, gravity:Number = 9.8)
		{
			//Aviso
			trace("PHYSIC STARLING: Todos os elementos com base PhysicObject devem ter alinhamento padrão no Topo Esquerdo. O Pivot deve ser alterado usando 'pivot.x' e etc.");
			
			//Seta
			this.resistance = resistance / 100;//Resistencia do ar
			
			//Aplica gravidade
			_gravity = gravity;
			this.gravityForce = _gravity / 15; //15 é para criar um fator legivel que trabalhe a gravidade com pixel
			
			//Inicia o vetor
			staticBodyList = new Vector.<BodyStarling>();
			rigidBodyList = new Vector.<BodyStarling>();
			
			//Seta o tipo de colisão a ser tratada
			this.collisonType = CollisionType.STARLING_COLLISION;
		}
		
		/**
		 * Inserir corpo à força gravitacional
		 * @param	child	BodyStarling a ser inserido no campo gravitacional
		 */
		public function insertBody(child:BodyStarling):void {
			
			//insere cada tipo em sua lista
			if (child.type == RigidBodyStarling) rigidBodyList.push(child);
			if (child.type == StaticBodyStarling) staticBodyList.push(child);
		}
		
		/**
		 * Remover corpo da força gravitacional
		 * @param	child	BodyStarling a ser retirado no campo gravitacional
		 */
		public function removeBody(child:BodyStarling):void {
			
			if (child.type == RigidBodyStarling) {
				
				if(rigidBodyList.indexOf(child) >= 0) rigidBodyList.splice(rigidBodyList.indexOf(child), 1);
				
			};
			
			if (child.type == StaticBodyStarling) {
				
				if(staticBodyList.indexOf(child) >= 0) staticBodyList.splice(staticBodyList.indexOf(child), 1);
				
			};
		}
		
		
		/**
		 * Renderiza processo de gravidade
		 */
		public function render():void {
			
			//Corpo a ser processado
			var currentBody:BodyStarling;
			var currentSolidBody:BodyStarling;
			var boundsBody:Rectangle;
			var boundsSolidBody:Rectangle;
			
			//Processa
			for (var i:uint = 0; i < rigidBodyList.length; i++){
				
				//Gravidade
				currentBody = rigidBodyList[i];
				boundsBody = currentBody.body.bounds; //Seta bordas
				
				if (currentBody.isDown) currentBody.gForce += gravityForce;
				else currentBody.gForce = 0;
				
				//Trata finalizador de gravidade caso o elemento esteja inteiramente no chao
				if(currentBody.isDown) currentBody.body.pivot.y += currentBody.gForce;
				
				//Verifica se colidiu com algum corpo solido
				for (var s:uint = 0; s < staticBodyList.length; s++){
					
					//Seta corpo solido
					currentSolidBody = staticBodyList[s];
					boundsSolidBody = currentSolidBody.body.bounds;
						
					//Processa colisão
					if (currentBody.isDown){
						
						//Se o tipo de colisão for para Starling
						if (collisonType == CollisionType.STARLING_COLLISION){
							
							
							/*if (currentSolidBody.body.hitTest(new Point(currentBody.body.pivot.x, currentBody.body.pivot.y)) && currentBody.gForce > 0){
								
								trace("vouuu");
								
								currentBody.gForce = (currentBody.gForce / (0.978 + currentBody.density)) * -1; //0.978 Fator de gravidade aplicada / 10
								
								//Verifica se continua se movimentando horizontalmente
								currentBody.isDown = (Math.abs(currentBody.gForce) - gravityForce) >= minDefictPixelGravityForce;
								
								//Se o objeto for setado como false, dispara evento informando que algum elemento de Body foi parado (o efeito da gravidade)
								if (!currentBody.isDown) dispatchEvent(new GravityEvent(GravityEvent.ON_SOME_BODY_STOP));
							}*/
							
							if (boundsBody.intersects(boundsSolidBody) && currentBody.gForce > 0){
								
								//Trata colisão vertical
								if (boundsBody.bottom >= boundsSolidBody.top){
									
									currentBody.gForce = (currentBody.gForce / (0.978 + currentBody.density)) * -1;
									currentBody.isDown = (Math.abs(currentBody.gForce) - gravityForce) >= minDefictPixelGravityForce;
									
									if (!currentBody.isDown) dispatchEvent(new GravityEvent(GravityEvent.ON_SOME_BODY_STOP));
									
								}
							}
						}
						
					} else {
						
						//Parte super importante para tratar colisao
						//====================================================================
						if (currentSolidBody.body.bounds.intersects(currentBody.body.bounds)){
							
							if (currentBody.objectToCollision == null){
								
								//trace("Teste");
								currentBody.objectToCollision = currentSolidBody;
								currentBody.isDown = false;
							} else {
								
								//trace("Teste2");
								
								//Verifica se ainda esta colidindo com este objeto
								if (!currentBody.objectToCollision.body.bounds.intersects(currentBody.body.bounds)) {
									currentBody.objectToCollision = null;
									currentBody.isDown = true;
									//trace("Não colide mais");
								} else {
									//trace("Ainda colide");
									currentBody.isDown = false;
								}
							}
						}
						
						//Verifica se ainda esta colidindo com este objeto
						if (currentBody.objectToCollision != null && !currentBody.objectToCollision.body.bounds.intersects(currentBody.body.bounds)) {
							currentBody.objectToCollision = null;
							currentBody.isDown = true;
							//trace("Não colide mais");
						} else {
							//trace("Ainda colide");
							currentBody.isDown = false;
						}
						
						//====================================================================
						
					}
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
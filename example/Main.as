package  {
	
	import com.physic.Gravity;
	import com.physic.body.RigidBody;
	import com.physic.body.StaticBody;
	import com.physic.display.SpritePhysic;
	import com.physic.event.BodyEvent;
	import com.physic.pivot.Pivot;
	import com.physic.plugin.native.gestouch.GestouchRecognize;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	* Exemplo de uso da biblioteca
	* @version 1.2.0
	*/
	public class Main extends Sprite {
		
		//Elemento estático comum
		private var background:Sprite;
		
		//Física
		private var gravity:Gravity;
		private var rocketBody:RigidBody;
		private var meteorBody:RigidBody;
		private var planetOneBody:RigidBody;
		private var planetTwoBody:RigidBody;
		private var groundStaticBody:StaticBody;
		
		//Elementos (Devem ser setados na base da biblioteca caso sejam instanciadas lá)
		private var rocket:SpritePhysic;
		private var meteor:SpritePhysic;
		private var planet1:SpritePhysic;
		private var planet2:SpritePhysic;
		private var ground:SpritePhysic;
		
		//Multitouch usando plugin GestouchRecognize
		private var mtRocket1:SpritePhysic;
		private var mtRocket2:SpritePhysic;
		private var mtRocket1Body:RigidBody;
		private var mtRocket2Body:RigidBody;
		
		public function Main() {
			
			//Cria elementos
			background = new Background();
			background.x = -16;
			background.y = 0;
			addChild(background);
			
			ground = new Ground();
			ground.updatePivot(Pivot.TOP_CENTER);
			ground.x = 265;
			ground.y = 729;
			addChild(ground);
			
			rocket = new Rocket();
			rocket.updatePivot(Pivot.CENTER); //Atualiza Pivot (Ponto de registro do objeto)
			rocket.x = 636;
			rocket.y = 623;
			addChild(rocket);
			
			//Elementos para multitoque
			mtRocket1 = new RocketMT();
			mtRocket1.updatePivot(Pivot.BOTTOM_CENTER);
			mtRocket1.x = 400;
			mtRocket1.y = 623;
			addChild(mtRocket1);
			
			mtRocket2 = new RocketMT();
			mtRocket2.updatePivot(Pivot.BOTTOM_CENTER);
			mtRocket2.x = 837;
			mtRocket2.y = 623;
			addChild(mtRocket2);
			
			planet1 = new PlanetOne;
			planet1.updatePivot(Pivot.CENTER);
			planet1.x = 117;
			planet1.y = 148;
			addChild(planet1);
			
			meteor = new Meteor();
			meteor.updatePivot(Pivot.MANUAL_POINT(meteor.width/2, 120));
			meteor.x = 905.50;
			meteor.y = 184.60;
			addChild(meteor);
			
			planet2 = new PlanetTwo();
			planet2.x = 1040;
			planet2.y = 122;
			addChild(planet2);
			
			//Aplica fisica
			//Força da Física Gravitacional
			gravity = new Gravity(5);
			//gravity.gravity = 15; //(!) pode ser alterada a força de atração gravitacional
			
			//Elementos a qual a Física gravitacional interage
			groundStaticBody = new StaticBody(ground);
			gravity.insertBody(groundStaticBody);
			
			rocketBody = new RigidBody(rocket, 1);
			rocketBody.isDown = false;
			rocketBody.addEventListener(BodyEvent.ON_TAP_CLICK, ignition); //Aciona ignicao no foguete
			rocketBody.addEventListener(BodyEvent.ON_MOVE_UP, onRocketMoveUp);
			rocketBody.addEventListener(BodyEvent.ON_BODY_STOP, onRocketMoveUp);
			rocketBody.addEventListener(BodyEvent.ON_MOVE_DOWN, onRocketMoveDown);
			gravity.insertBody(rocketBody);
			
			
			
			
			//Elementos de multitouch usando plugin Gestouch
			mtRocket1Body = new RigidBody(mtRocket1, 1);
			mtRocket1Body.isDown = false;
			mtRocket1Body.addPlugin(GestouchRecognize);
			mtRocket1Body.addEventListener(BodyEvent.ON_TAP_CLICK, onTapMultitouchGestouchRecognize);
			gravity.insertBody(mtRocket1Body);
			
			mtRocket2Body = new RigidBody(mtRocket2, 1);
			mtRocket2Body.isDown = false;
			mtRocket2Body.addPlugin(GestouchRecognize);
			mtRocket2Body.addEventListener(BodyEvent.ON_TAP_CLICK, onTapMultitouchGestouchRecognize);
			gravity.insertBody(mtRocket2Body);
			
			
			
			
			planetOneBody = new RigidBody(planet1, 3, true);
			gravity.insertBody(planetOneBody);
			planetOneBody.addHorizontalForce(10);
			
			planetTwoBody = new RigidBody(planet2, 1);
			gravity.insertBody(planetTwoBody);
			
			meteorBody = new RigidBody(meteor, 2);
			gravity.insertBody(meteorBody);
			
			
			//Ativa renderizador
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		/**
		 * Quando tocar num elemento que usa o Plugin GestouchRecognize para multtoque (somente para display sensiveis a toque)
		 * @param	e
		 */
		private function onTapMultitouchGestouchRecognize(e:BodyEvent):void 
		{
			//Insere força vertical
			(e.target as RigidBody).addVerticalForce( -15);
		}

		//Altera escala do Foguete
		private function onRocketMoveUp(e:BodyEvent):void {
			
			rocketBody.body.pivot.scaleY = 1;
		}
		
		//Altera escala do Foguete
		private function onRocketMoveDown(e:BodyEvent):void {
			
			rocketBody.body.pivot.scaleY = -1;
		}
		
		//Aciona ignição no foguete
		private function ignition(e:BodyEvent):void {
			
			//e.target.addVerticalForce(-15); (!) Também funciona
			rocketBody.addVerticalForce(-15);
			
			//Remove corpo da força gravitacional
			gravity.removeBody(planetOneBody);
		}
		
		private function render(e:Event):void {
			
			gravity.render();
		}
	}
	
}

package com.physic.plugin.native.gestouch 
{
	import com.physic.body.Body;
	import com.physic.event.BodyEvent;
	import com.physic.plugin.Plugin;
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TapGesture;
	
	/**
	 * Adapta o uso de Gestouch (Multitoque)
	 * 
	 * Deve ser usado para telas sensiveis a toque
	 * 
	 * Requer biblioteca Gestouch (https://github.com/fljot/Gestouch)
	 * 
	 * Leia mais sobre Gestouch: https://github.com/fljot/Gestouch
	 * 
	 * Disponivel a partir da versao 1.2.0
	 * 
	 * @author Wenderson Pires da Silva
	 */
	public class GestouchRecognize extends Plugin
	{
		//Reconhecedor de multitoque
		private var tapGesture:TapGesture;
		
		//Alerta
		private static var alertSend:Boolean = false;
		private static function showAlert():void{if (!alertSend) {trace("GestouchRecognize: Somente para telas sensíveis a toque."); alertSend = true; }};
		
		public function GestouchRecognize(body:Body)
		{
			showAlert();
			
			super(body);
			
			tapGesture = new TapGesture(this.body.body);
			tapGesture.numTapsRequired = 1;
			tapGesture.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTapBegan);
			
			//Remove evento nativo
			this.body.dispose();
		}
		
		/**
		 * Quando tocar no corpo
		 * @param	e
		 */
		private function onTapBegan(e:GestureEvent):void 
		{
			this.body.dispatchEvent(new BodyEvent(BodyEvent.ON_TAP_CLICK));
		}
		
	}

}
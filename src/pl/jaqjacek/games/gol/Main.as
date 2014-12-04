package pl.jaqjacek.games.gol
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import pl.jaqjacek.games.gol.map.indicators.MapIniciator;
	import pl.jaqjacek.games.gol.map.indicators.RandomMapIniciator;
	import pl.jaqjacek.games.gol.map.indicators.StaticMapIniciator;
	import pl.jaqjacek.games.gol.map.Map;
	import pl.jaqjacek.games.gol.map.MiniMapButton;
	
	/**
	 * ...
	 * @author jaq
	 * old main clas
	 * used before purvemvc 
	 */
	public class Main extends Sprite 
	{
		protected var _map:Map;
		protected var _buttons:Vector.<MiniMapButton>;
		
		public function Main():void 
		{
			_buttons = new Vector.<MiniMapButton>();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.graphics.beginFill(Config.BACKGROUND_COLLOR);
			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight)
			
			
			var tmpButton:MiniMapButton
			var tmpVector:Array = [	new RandomMapIniciator(), 
									new StaticMapIniciator('011011|011011|00101|1010101|1010101|1100011'), 
									new StaticMapIniciator('11|001|0001|0001|0001|001|11')];
			var startY:Number = 0;
			for each (var item:MapIniciator in tmpVector) 
			{
				tmpButton = new MiniMapButton();
				tmpButton.mapIniciator = item;
				item.inicializeMap(tmpButton);
				_buttons.push(tmpButton);
				addChild(tmpButton.container);
				tmpButton.container.y = startY;
				startY += tmpButton.container.height + 20;
				tmpButton.container.addEventListener(MouseEvent.CLICK, miniMapButtonContainerClickHandler);
			}
			createMap();
			showButtons();
		}
		
		public function createMap():void 
		{
			_map 				= new Map(Config.MAP_WIDTH,Config.MAP_HEIGHT);			
			_map.container.x 	= (stage.stageWidth 	- _map.container.width)  / 2;
			_map.container.y 	= (stage.stageHeight 	- _map.container.height) / 2;
			addChild(_map.container);
		}
		
		protected function miniMapButtonContainerClickHandler(e:MouseEvent):void 
		{			
			for each (var item:MiniMapButton in _buttons) 
			{
				if (item.container == e.currentTarget) {
					initMapFromMinimap(item);
					break;
				}
			}
			startMapUpdate();
		}
		
		protected function startMapUpdate():void 
		{
			showMap();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardKeyDownHandler);
		}
		
		protected function keyboardKeyDownHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ENTER) {
				stopMapUpdate()
				removeEventListener(Event.ENTER_FRAME, update);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardKeyDownHandler);
			}			
		}
		
		protected function stopMapUpdate():void 
		{
			showButtons();
		}
		
		protected function initMapFromMinimap(item:MiniMapButton):void 
		{
			_map.reset();
			item.mapIniciator.inicializeMap(_map);
		}
		
		protected function showButtons():void 
		{
			for each (var item:MiniMapButton in _buttons) 
			{
				item.container.visible = true;
			}
			_map.container.visible = false;
		}
		
		protected function showMap():void 
		{
			for each (var item:MiniMapButton in _buttons) 
			{
				item.container.visible = false;
			}
			_map.container.visible = true;
		}
		
		protected function update(e:Event):void 
		{
			_map.update();
		}		
	}
	
}
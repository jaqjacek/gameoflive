package pl.jaqjacek.games.gol
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class Main extends Sprite 
	{
		protected var _map:Map;
		protected var _buttons:Vector.<MiniMapButton>;
		private var _buttonContainer:Sprite;
		
		public function Main():void 
		{
			stage.scaleMode = "noScale";
			stage.align = StageAlign.TOP;
			_buttons = new Vector.<MiniMapButton>();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var startY:Number = 0;
			var startX:Number = 0;
			var marginX:Number = 20;
			var marginY:Number = 20;
			var creditsHeight:int = 20; //because standard Credist is 20 pixel height
			removeEventListener(Event.ADDED_TO_STAGE, init);
			new Credits(stage,"Game Of Live by jaq");			
			_map = new Map(Config.MAP_WIDTH,Config.MAP_HEIGHT);
			addChild(_map.container);
			_buttonContainer = new Sprite();
			addChild(_buttonContainer);
			var tmpButton:MiniMapButton
			var tmpVector:Array = [	new RandomMapIniciator(), 
									new StaticMapIniciator('011011|011011|00101|1010101|1010101|1100011'), 
									new StaticMapIniciator('11|001|0001|0001|0001|001|11'),									
									new StaticMapIniciator('0000001|00001011|0000101|00001|001|101'),
									new StaticMapIniciator('00000010|11|01000111'),
									new StaticMapIniciator('01|0001|1100111'),
									new StaticMapIniciator('111|1|01'),
									new StaticMapIniciator('01001|1|10001|1111'),
									new StaticMapIniciator('1001|00001|10001|01111'),
									new StaticMapIniciator('001|100010|000001|100001|011111'),
									new StaticMapIniciator('0011|100001|000001|1000001|0111111'),
									new StaticMapIniciator('01011|01101','snake'),
									new StaticMapIniciator('11|101|011','ship'),
									new StaticMapIniciator('11|1001|0011','aircraft carrier'),
									new StaticMapIniciator('11|1001|011','beehive'),
									new StaticMapIniciator('1|101|0101|001','barge'),
									new StaticMapIniciator('00011|10101|11','Python'),
									new StaticMapIniciator('01|101|0101|0011','long boat'),
									new StaticMapIniciator('11|101|001|0011','fisherhook'),
									new StaticMapIniciator('11101|1|00011|01101|10101')];
		
			for each (var item:MapIniciator in tmpVector) 
			{
				tmpButton = new MiniMapButton();
				tmpButton.mapIniciator = item;
				item.inicializeMap(tmpButton);
				_buttons.push(tmpButton);
				_buttonContainer.addChild(tmpButton.container);
				tmpButton.container.y = startY;
				tmpButton.container.x = startX;
				tmpButton.initMinimapName();
				startY += tmpButton.container.height + marginY;
				tmpButton.container.addEventListener(MouseEvent.CLICK, miniMapButtonContainerClickHandler);
				if (startY > stage.stageHeight -tmpButton.container.height-creditsHeight) {
					startX += marginX + tmpButton.container.width;
					startY = 0;
				}
			}		
			
			_buttonContainer.x = (_buttonContainer.stage.stageWidth - _buttonContainer.width) * 0.5;
			_buttonContainer.y = (_buttonContainer.stage.stageHeight - _buttonContainer.height) * 0.5;
			hideMap();
			showButtons();
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
			hideButtons();
			showMap();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardKeyDownHandler);
		}
		
		protected function keyboardKeyDownHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ENTER) {
				stopMapUpdate()
			}			
		}
		
		protected function stopMapUpdate():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			hideMap();
			showButtons();
		}
		
		protected function initMapFromMinimap(item:MiniMapButton):void 
		{
			new ResetIniciator().inicializeMap(_map);
			item.mapIniciator.inicializeMap(_map);			
		}
		
		protected function showButtons():void 
		{
			_buttonContainer.visible = true;		
		}
		
		private function hideButtons():void 
		{
			_buttonContainer.visible = false;
		}
		
		private function hideMap():void 
		{
			_map.container.visible = false;
		}
		
		protected function showMap():void 
		{			
			_map.container.x = (_map.container.stage.stageWidth - _map.container.width) * 0.5;
			_map.container.y = (_map.container.stage.stageHeight - _map.container.height) * 0.5;
			_map.container.visible = true;
			
		}
		
		protected function update(e:Event):void 
		{
			_map.update();
		}
		
		
	}
	
}
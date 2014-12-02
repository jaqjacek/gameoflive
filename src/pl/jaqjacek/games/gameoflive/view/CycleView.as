package pl.jaqjacek.games.gameoflive.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.osflash.signals.Signal;
	import pl.jaqjacek.games.gameoflive.Consts;
	import pl.jaqjacek.games.gol.map.indicators.RandomMapIniciator;
	import pl.jaqjacek.games.gol.map.indicators.ResetIniciator;
	import pl.jaqjacek.games.gol.map.indicators.StaticMapIniciator;
	import pl.jaqjacek.games.gol.map.Map;
	/**
	 * ...
	 * @author jaq
	 */
	public class CycleView extends Sprite
	{
		public static const NAME:String = "cycleView";
		static public const SHOW:String = NAME + "show";
		static public const HIDE:String = NAME + "hide";
		static public const UPDATE:String = NAME + "update";
		
		public var onExit:Signal;
		
		private var _map:Map;
		
		public function CycleView() 
		{
			init();
		}
		
		private function init():void 
		{
			if(!onExit) {
				onExit = new Signal();
			}
		}
		
		public function initMap(mapData:String,mapName:String):void 
		{
			if (_map) {
				if(_map.container.parent) {
					removeChild(_map.container);
				}
			}
			_map = new Map(40,40);
			addChild(_map.container);
			_map.container.visible = true;
			_map.reset();
			_map.mapIniciator = new StaticMapIniciator(mapData, mapName);
			_map.mapIniciator.inicializeMap(_map);
			centerMap();
		}
		
		private function centerMap():void 
		{
			_map.container.width = Consts.STAGE_WIDTH
			_map.container.scaleY = _map.container.scaleX;
			_map.container.y =  _map.container.height / 4;
		}
		
		public function run():void 
		{
			stop();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function stop():void 
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function pause():void 
		{
			stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			this.update();
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case Keyboard.ENTER:
					onExit.dispatch();
				break;
			}
		}
		
		public function show():void 
		{
			this.visible = true;
		}
		
		public function reset():void 
		{
			new ResetIniciator().inicializeMap(_map);
			new RandomMapIniciator().inicializeMap(_map);
		}
		
		public function hide():void 
		{
			this.visible = false;
		}
		
		public function update():void 
		{
			_map.update();
		}
	}
}
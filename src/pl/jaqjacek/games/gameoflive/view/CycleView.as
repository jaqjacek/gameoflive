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
	import pl.jaqjacek.games.gol.map.indicators.RandomMapIniciator;
	import pl.jaqjacek.games.gol.map.indicators.ResetIniciator;
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
		
		private function initOld():void 
		{
			var tmpBitmap:BitmapData = new BitmapData(400, 300, true, 0xFFFF11);
			var tmpShape:Shape = new Shape();
			tmpShape.graphics.lineStyle(1, 0x000000);
			var mapWidth:int = 10;
			for (var i:int = 0; i < 400; i+=mapWidth) 
			{
				tmpShape.graphics.moveTo(0, i)
				tmpShape.graphics.lineTo(400, i);
				tmpShape.graphics.moveTo(i, 0)
				tmpShape.graphics.lineTo(i,400);
			}
			tmpBitmap.draw(tmpShape);
			addChild(new Bitmap(tmpBitmap));
			
			onExit = new Signal();
		}
		
		private function init():void 
		{
			if(!onExit)
				onExit = new Signal();
			
			_map = new Map(20,20);
			addChild(_map.container);
			_map.container.visible = true;
			_map.reset();
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
			reset();
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
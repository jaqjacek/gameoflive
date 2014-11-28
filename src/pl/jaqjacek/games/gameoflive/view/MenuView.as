package pl.jaqjacek.games.gameoflive.view 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField
	import pl.jaqjacek.games.gol.map.indicators.RandomMapIniciator;
	import pl.jaqjacek.games.gol.map.MiniMapButton;
	/**
	 * ...
	 * @author jaq
	 */
	public class MenuView extends Sprite
	{
		static public const NAME:String = "MenuView";
		static public const SHOW:String = NAME + "show";
		static public const HIDE:String = NAME + "hide";
		static public const UPDATE:String = NAME + "update";
		static public const BUTTON_CLICKED:String = NAME + "buttonClicked";
		
		private var _text:TextField;
		private var _button:MiniMapButton;
		public function MenuView() 
		{
			init();
		}
		
		private function init():void 
		{
			_text = new TextField();
			_text.text = "menuView";			
			addChild(_text);
			hide();
			_button = new MiniMapButton();
			_button.mapIniciator = new RandomMapIniciator();
			_button.mapIniciator.inicializeMap(_button);
			addChild(_button.container)
			_button.container.x = 100;
			_button.container.y = 100;
			_button.initMinimapName();
		}		
		
		public function show():void 
		{
			_text.visible = true;
			_button.container.mouseChildren = false;
			_button.container.addEventListener(MouseEvent.MOUSE_UP, menuButtonMouseClickHandler);
		}
		
		private function menuButtonMouseClickHandler(e:MouseEvent):void 
		{
			this.dispatchEvent(new Event(BUTTON_CLICKED));
		}
		
		public function hide():void 
		{
			_text.visible = false;
		}
		
		public function update():void 
		{
			_text.appendText(".");
		}
		
	}

}
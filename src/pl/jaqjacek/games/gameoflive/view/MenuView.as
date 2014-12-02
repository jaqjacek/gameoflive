package pl.jaqjacek.games.gameoflive.view 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import pl.jaqjacek.games.gol.map.MiniMapButton;
	/**
	 * ...
	 * @author jaq
	 */
	public class MenuView extends Sprite
	{
		static public const NAME:String = "MenuView_";
		static public const SHOW:String = NAME + "show";
		static public const HIDE:String = NAME + "hide";
		static public const UPDATE:String = NAME + "update";
		static public const BUTTON_CLICKED:String = NAME + "buttonClicked";
		
		private var _buttons:Vector.<MiniMapButton>;
		public var lastButtonClicked:MiniMapButton;
		
		public function MenuView() 
		{
			
		}
		
		public function init(buttonsList:Vector.<MiniMapButton>):void 
		{
			hide();
			_buttons = buttonsList;
			addButtonsToShowGrid();	
		}	
		
		private function addButtonsToShowGrid():void 
		{
			var startX:Number = 50;
			var tmpX:Number = startX;
			var tmpY:Number = 0;
			var maxWidth:Number = 350;
			for each (var item:MiniMapButton in _buttons) 
			{
				item.container.x = tmpX;
				item.container.y = tmpY;
				tmpX += item.container.width + 10;
				if (tmpX > maxWidth) {
					tmpY += item.container.height + 10;
					tmpX = startX;
				}
				addChild(item.container);
			}
		}
		
		private function initButtonsEvents():void 
		{
			for each (var item:MiniMapButton in _buttons) 
			{
				item.container.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			}
		}
		
		private function removeButtonsEvents():void 
		{
			for each (var item:MiniMapButton in _buttons) 
			{
				item.container.removeEventListener(MouseEvent.CLICK, buttonClickHandler);
				item.container.mouseChildren = false;
				item.container.mouseEnabled = true;
			}
		}
		
		private function buttonClickHandler(e:MouseEvent):void 
		{
			for each (var item:MiniMapButton in _buttons) 
			{
				if (item.container == e.currentTarget) {
					lastButtonClicked = item;
					break;
				}
			}
			this.dispatchEvent(new Event(BUTTON_CLICKED));
		}
		
		public function show():void 
		{
			initButtonsEvents();
		}
		
		public function hide():void 
		{
			removeButtonsEvents();
		}
		
		public function update():void 
		{			
		}
	}
}
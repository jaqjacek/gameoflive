package pl.jaqjacek.games.gameoflive.view 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import pl.jaqjacek.games.gameoflive.Consts;
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
			var tmpX:Number = 0;
			var tmpY:Number = 0;
			var separatorY:int = 10;
			var separatorX:int = 10;
			var maxWidth:Number = Consts.STAGE_WIDTH;
			for each (var item:MiniMapButton in _buttons) 
			{
				item.container.x = tmpX;
				item.container.y = tmpY;
				item.container.width = 130;
				item.container.scaleY = item.container.scaleX
				tmpX += item.container.width + separatorX;
				if (tmpX + item.container.width > maxWidth) {
					tmpY += item.container.height + separatorY;
					tmpX = 0
				}
				addChild(item.container);
			}
			this.x = (maxWidth - this.width) / 2;
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
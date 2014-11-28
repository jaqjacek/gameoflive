package pl.jaqjacek.games.gol.map 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import pl.jaqjacek.games.gol.Config;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class MiniMapButton extends Map 
	{
		private var _patternText:TextField;
		public function MiniMapButton() 
		{		
			super(Config.MINIMAP_WIDTH, Config.MINIMAP_HEIGHT);
			_container.mouseChildren = false;					
		}
		
		override protected function findCellNeighboursAt(x:int, y:int):void 
		{
			//don't fill cell neighbours
		}
		
		public function initMinimapName():void 
		{
			var tmpSprite:Sprite = _container.getChildByName("name_container") as Sprite
			if (tmpSprite) {
				_container.removeChild(tmpSprite);
			}
			tmpSprite = new Sprite();
			tmpSprite.graphics.beginFill(Config.MINI_MAP_BUTTON_TEXT_BACKGRAUND_COLOR);
			tmpSprite.graphics.drawRect(1, 0, _container.width+1, Config.MINI_MAP_BUTTON_TEXT_HEIGHT);
			tmpSprite.graphics.endFill();	
			tmpSprite.y = _container.height;
			_container.addChild(tmpSprite);
			_patternText = new TextField();
			_patternText.mouseEnabled = false;
			_patternText.selectable = false;
			if (_patternText.parent) {
				_patternText.parent.removeChild(_patternText);
			}
			_patternText.width = _container.width;
			_patternText.height = Config.MINI_MAP_BUTTON_TEXT_HEIGHT;	
			_patternText.text = _mapIniciator.getPatternName();
			var tmpTF:TextFormat = _patternText.getTextFormat()
			tmpTF.align = TextFormatAlign.CENTER;
			tmpTF.color = Config.MINI_MAP_BUTTON_TEXT_FONT_COLOR;
			_patternText.setTextFormat(tmpTF)	
			tmpSprite.addChild(_patternText);		
			addFullButtonMask();
		}
		
		private function addFullButtonMask():void 
		{
			var tmpSprite:Sprite = new Sprite();
			tmpSprite.alpha = 0;
			tmpSprite.graphics.beginFill(0xffffff);
			tmpSprite.graphics.drawRect(0, 0, _container.width, _container.height);
			tmpSprite.graphics.endFill();
			_container.addChildAt(tmpSprite, 0);
		}
		
	}

}
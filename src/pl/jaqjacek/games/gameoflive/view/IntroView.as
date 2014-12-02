package pl.jaqjacek.games.gameoflive.view
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import pl.jaqjacek.games.gameoflive.Consts;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class IntroView extends Sprite
	{
		private var _text:TextField;
		static public const NAME:String = "IntroView_";
		static public const END:String = NAME + "end";
		static public const SHOW:String = NAME + "show";
		static public const HIDE:String = NAME + "hide";
		
		public function IntroView()
		{
		}
		
		public function init():void
		{
			_text = new TextField();
			var tmpTextFormat:TextFormat = _text.getTextFormat();
			tmpTextFormat.size = 72;
			_text.antiAliasType = AntiAliasType.ADVANCED;
			_text.text = ">&";		
			_text.setTextFormat(tmpTextFormat);
			addChild(_text);
			_text.x = _text.stage.stageWidth / 2 - _text.textWidth / 2;
			_text.y = _text.stage.stageHeight / 2 - _text.textHeight / 2;
		}
		
		public function show():void
		{
			_text.visible = true;
		}
		
		public function hide():void 
		{
			_text.visible = false;
		}
	}
}
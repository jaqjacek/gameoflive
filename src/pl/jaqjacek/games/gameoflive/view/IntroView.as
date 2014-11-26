package pl.jaqjacek.games.gameoflive.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class IntroView extends Sprite
	{
		private var _text:TextField;
		static public const NAME:String = "introView";
		static public const END:String = NAME + "end";
		static public const SHOW:String = NAME + "show";
		static public const HIDE:String = NAME + "hide";
		
		public function IntroView()
		{
			init();
		}
		
		public function init():void
		{
			_text = new TextField();
			_text.text = ">&";
			addChild(_text);
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
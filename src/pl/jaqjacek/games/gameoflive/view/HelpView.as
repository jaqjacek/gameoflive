package pl.jaqjacek.games.gameoflive.view 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import pl.jaqjacek.games.gol.MapIniciator;
	import pl.jaqjacek.games.gol.MiniMapButton;
	import pl.jaqjacek.games.gol.RandomMapIniciator;
	/**
	 * ...
	 * @author jaq
	 */
	public class HelpView extends Sprite
	{
		static public const NAME:String = "helpView";
		static public const SHOW:String = NAME + "show";
		static public const HIDE:String = NAME + "hide";
		static public const UPDATE:String = NAME + "update";
		
		private var _helpTitle:TextField;
		private var _helpBody:TextField;
		
		public function HelpView() 
		{
			init();
		}
		
		private function init():void 
		{
			_helpTitle = new TextField();
			_helpBody  = new TextField();
			_helpTitle.text = "GameOfLive";			
			_helpBody.text = "by jaq";			
			addChild(_helpTitle);
			addChild(_helpBody);
			hide();			
		}		
		
		public function show():void 
		{
			_helpTitle.visible = true;
			_helpBody.visible = true;
			_helpTitle.x = _helpTitle.stage.stageWidth / 2 - _helpTitle.textWidth / 2;
			_helpTitle.y = _helpTitle.stage.stageHeight / 10; //10% of stage height
			
			_helpBody.y = _helpTitle.y * 2 + _helpTitle.height;
			_helpBody.width = _helpBody.stage.stageWidth * 0.8;
			_helpBody.x = _helpBody.stage.stageWidth / 10
		}
		
		public function hide():void 
		{
			_helpTitle.visible = false;
			_helpBody.visible = false;
		}
		
		public function update():void 
		{
			
		}
		
	}

}
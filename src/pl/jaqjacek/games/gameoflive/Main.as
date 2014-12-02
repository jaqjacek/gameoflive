package pl.jaqjacek.games.gameoflive 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author jaq
	 */
	public class Main extends Sprite
	{
		
		public function Main() 
		{
			 
			 init();
		}
		
		private function init():void 
		{
			GOLFacade.getInstance().startup( this );
		}
		
	}

}
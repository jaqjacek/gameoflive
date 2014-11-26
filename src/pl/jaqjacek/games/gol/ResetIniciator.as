package pl.jaqjacek.games.gol 
{
	/**
	 * ...
	 * @author jaq
	 */
	public class ResetIniciator extends RandomMapIniciator
	{
		
		public function ResetIniciator() 
		{
			
		}
		
		override public function getRandomState():Boolean 
		{
			return false;
		}
		
	}

}
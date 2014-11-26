package pl.jaqjacek.games.gol 
{
	/**
	 * ...
	 * @author jaq
	 */
	public class RandomMapIniciator implements MapIniciator 
	{
		
		public function RandomMapIniciator() 
		{
			
		}
		
		/* INTERFACE pl.jaqjacek.games.gol.MapIniciator */
		
		public function inicializeMap(map:Map):void 
		{
			for (var i:int = 0; i < map.getWidth(); i++) 
			{
				for (var j:int = 0; j < map.getHeight(); j++) 
				{
					map.getCell(i, j).state = getRandomState()
					map.getCell(i, j).draw();
				}
			}
		}
		
		public function getRandomState():Boolean 
		{
			return Math.random() * 10 > 5 ? true:false;
		}
		
		/* INTERFACE pl.jaqjacek.games.gol.MapIniciator */
		
		public function getPatternName():String 
		{
			return 'random';
		}
		
	}

}
package pl.jaqjacek.games.gol.map.indicators 
{
	import pl.jaqjacek.games.gol.map.Cell;
	import pl.jaqjacek.games.gol.map.Map;
	/**
	 * ...
	 * @author jaq
	 * set all cells in map to random state
	 */
	public class RandomMapIniciator implements MapIniciator 
	{
		
		public function RandomMapIniciator() 
		{
			
		}
		
		public function inicializeMap(map:Map):void 
		{
			var tmpCell:Cell;
			for (var i:int = 0; i < map.getWidth(); i++) 
			{
				for (var j:int = 0; j < map.getHeight(); j++) 
				{
					tmpCell = map.getCell(i, j)
					getRandomState() ? tmpCell.setAlive() : tmpCell.setDead();
					tmpCell.draw();
				}
			}
		}
		
		public function getRandomState():Boolean 
		{
			return Math.random() * 10 > 5 ? true:false;
		}
		
		public function getPatternName():String 
		{
			return 'random';
		}
		
	}

}
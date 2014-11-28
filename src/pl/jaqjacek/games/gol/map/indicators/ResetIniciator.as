package pl.jaqjacek.games.gol.map.indicators
{
	import pl.jaqjacek.games.gol.map.Map;
	/**
	 * ...
	 * @author jaq
	 */
	public class ResetIniciator implements MapIniciator
	{
		
		public function ResetIniciator() 
		{
			
		}
				
		public function inicializeMap(map:Map):void 
		{
			var tmpWidth:int 	= map.getWidth();
			var tmpHeight:int 	= map.getHeight();
			for (var i:int = 0; i < tmpWidth; i++) 
			{
				for (var j:int = 0; j < tmpHeight; j++) 
				{
					map.getCell(i, j).setDead();
					map.getCell(i, j).reset();
					map.getCell(i, j).draw();
				}
			}
		}
		
		public function getPatternName():String
		{
			return '';
		}
	}

}
package pl.jaqjacek.games.gol.map.indicators 
{
	import pl.jaqjacek.games.gol.map.Map;
	
	/**
	 * ...
	 * @author jaq
	 */
	public interface MapIniciator 
	{
		// init cells in map
		function inicializeMap(map:Map):void;
		
		// get pattern name
		function getPatternName():String
	}
	
}
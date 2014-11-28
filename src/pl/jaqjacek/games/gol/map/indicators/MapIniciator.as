package pl.jaqjacek.games.gol.map.indicators 
{
	import pl.jaqjacek.games.gol.map.Map;
	
	/**
	 * ...
	 * @author jaq
	 */
	public interface MapIniciator 
	{
		function inicializeMap(map:Map):void;
		
		function getPatternName():String
	}
	
}
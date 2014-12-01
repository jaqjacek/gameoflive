package pl.jaqjacek.games.gameoflive.model 
{
	/**
	 * ...
	 * @author 
	 */
	public class MapInfoVO 
	{
		public var mapName:String;
		public var mapData:String;
		
		public function MapInfoVO(p_mapName:String='',p_mapData:String='') 
		{
			mapName = p_mapName;
			mapData = p_mapData;
		}
		
	}

}
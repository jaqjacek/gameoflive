package pl.jaqjacek.games.gameoflive.model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class MapProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "MapProxy_";
		private var _mapInfos:Vector.<MapInfoVO>;
		private var _currentMapInfo:MapInfoVO;
		
		static public const SET_CURRENT_MAPINFO:String = NAME+"setCurrentMapinfo";
		
		public function MapProxy() 
		{
			_mapInfos = new Vector.<MapInfoVO>();
			super(NAME);
		}
		
		public function getCurrentMapInfo():MapInfoVO
		{
			return _currentMapInfo
		}
		
		public function setCurrentMapInfoByName(patternName:String):void 
		{
			for each (var item:MapInfoVO in _mapInfos) 
			{
				if (item.mapName == patternName) {
					_currentMapInfo = item;
					return;
				}
			}
		}
		
		public function addMapInfo(p_mapInfo:MapInfoVO):void 
		{
			_mapInfos.push(p_mapInfo);
		}
		
		public function getAllMapInfo():Vector.<MapInfoVO>
		{
			return _mapInfos;
		}
	}
}
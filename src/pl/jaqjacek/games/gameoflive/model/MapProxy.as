package pl.jaqjacek.games.gameoflive.model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import pl.jaqjacek.games.gol.map.indicators.RandomMapIniciator;
	import pl.jaqjacek.games.gol.map.Map;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class MapProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "MapProxy_";
		private var _mapInfos:Vector.<MapInfoVO>;
		private var _currentMapInfoIndex:int
		
		static public const SET_CURRENT_MAPINFO:String = NAME+"setCurrentMapinfo";
		
		public function MapProxy() 
		{
			_mapInfos = new Vector.<MapInfoVO>();
			super(NAME);
		}
		
		public function getCurrentMapInfo():MapInfoVO
		{
			if (!_currentMapInfoIndex < _mapInfos.length) {
				_currentMapInfoIndex = 0;
			}
			return _mapInfos[_currentMapInfoIndex];
		}
		
		public function setCurrentMapInfoByName(patternName:String):void 
		{
			if (patternName == 'random') {
				initRandomPattern();
			}
			for each (var item:MapInfoVO in _mapInfos) 
			{
				if (item.mapName == patternName) {
					_currentMapInfoIndex = _mapInfos.indexOf(item);
					return;
				}
			}
			
			_currentMapInfoIndex = 0;
		}
		
		public function initRandomPattern():void 
		{
			var tmpMap:Map = new Map(5, 5);
			tmpMap.mapIniciator = new RandomMapIniciator();
			tmpMap.mapIniciator.inicializeMap(tmpMap);
			_mapInfos[0].mapData = tmpMap.getMapString();
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
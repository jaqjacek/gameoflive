package pl.jaqjacek.games.gol.map.indicators 
{
	/**
	 * ...
	 * @author jaq
	 */
	public class StaticMapIniciator implements MapIniciator 
	{
		protected var _initString:String;
		private var _patterString:String;
		public function StaticMapIniciator(initString:String = '', patternName:String = '' ) 
		{
			_initString = initString;
			_patterString = patternName;
		}
		
		/* INTERFACE pl.jaqjacek.games.gol.MapIniciator */
		
		public function inicializeMap(map:Map):void 
		{
			var tmpVector:Array = _initString.split("|");
			var tmpHeight:int = tmpVector.length;
			var tmpWidth:int = 0;
			for each (var itemz:String in tmpVector) 
			{
				if (tmpWidth < itemz.length )
					tmpWidth = itemz.length
			}
			var startX:int = Math.floor(map.getWidth()/2 - tmpWidth/2)
			var startY:int = Math.floor(map.getHeight() / 2 - tmpHeight / 2)
			var tmpCell:Cell
			for each (var item:String in tmpVector) 
			{				
				for (var i:int = 0; i < item.length; i++) 
				{
					tmpCell = map.getCell(startX + i, startY);
					item.charAt(i) == '1' ? tmpCell.setAlive() : tmpCell.setDead();
					tmpCell.draw()
				}
				startY++;
			}
			
		}
		
		/* INTERFACE pl.jaqjacek.games.gol.MapIniciator */
		
		public function getPatternName():String 
		{
			return _patterString
		}
		
	}

}
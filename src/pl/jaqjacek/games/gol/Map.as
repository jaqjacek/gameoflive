package pl.jaqjacek.games.gol 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author jaq
	 */
	public class Map 
	{
		protected var _map:Vector.<Vector.<Cell>>;
		protected var _container:Sprite;
		protected var _mapIniciator:MapIniciator;
		
		public function Map(mapWidth:int,mapHeight:int) 
		{		
			init();
			createMap(mapWidth,mapHeight);
			inicializeCells();
		}
		
		protected function init():void 
		{
			_container = new Sprite()
			_map = new Vector.<Vector.<Cell>>();	
		}
		
		protected function createMap(mapWidth:int=0,mapHeight:int=0):void 
		{
			mapWidth = !mapWidth ? Config.MAP_WIDTH:mapWidth;
			mapHeight = !mapHeight ? Config.MAP_HEIGHT:mapHeight;
			
			var tmpVector:Vector.<Cell>
			var tmpCell:Cell;
			for (var i:int = 0; i < mapWidth; i++) 
			{
				tmpVector = new Vector.<Cell>();
				for (var j:int = 0; j < mapHeight; j++) 
				{
					tmpCell = new Cell();
					tmpVector.push(tmpCell);
				}
				_map.push(tmpVector);
			}
			
		}
		
		public function getWidth():int
		{
			return _map[0].length;
		}
		
		public function getHeight():int
		{
			return _map.length
		}
		
		protected function inicializeCells():void 
		{
			var tmpCell:Cell;
			for (var k:int = 0; k < getWidth(); k++) 
			{
				for (var l:int = 0; l < getHeight(); l++) 
				{
					tmpCell = getCell(k, l);
					tmpCell.x = k * Config.CELL_WIDTH;
					tmpCell.y = l * Config.CELL_HEIGHT;
					
					_container.addChildAt(tmpCell,0);
					findCellNeighboursAt(k, l);
					tmpCell.draw();
				}
			}		
		}
		
		protected function findCellNeighboursAt(x:int,y:int):void 
		{
			var tmpCell:Cell = getCell(x, y);
			
			for (var i:int = x-1; i < x+2; i++) 
			{
				if (i < 0 || i >= getWidth())
					continue
				for (var j:int = y-1; j < y+2; j++) 
				{
					if (j < 0 || j >= getHeight())
						continue
					if ( x == i && j == y)
						continue
					tmpCell.addNeighbour(getCell(i,j))
				}
			}
		}
		
		public function update():void 
		{
			var tmpCell:Cell
			for (var k:int = 0; k < getWidth(); k++) 
			{
				for (var l:int = 0; l < getHeight(); l++) 
				{
					tmpCell = getCell(k, l);
					tmpCell.checkCell();					
				}
			}
			for (var kk:int = 0; kk < getWidth(); kk++) 
			{
				for (var ll:int = 0; ll < getHeight(); ll++) 
				{
					tmpCell = getCell(kk, ll);
					tmpCell.nextGeneration();					
				}
			}
		}
		
		public function getCell(x:int,y:int):Cell 
		{
			return _map[y][x];
		}
		
		public function get container():Sprite 
		{
			return _container;
		}
		
		public function get mapIniciator():MapIniciator 
		{
			return _mapIniciator;
		}
		
		public function set mapIniciator(value:MapIniciator):void 
		{
			_mapIniciator = value;
		}
		
	}

}
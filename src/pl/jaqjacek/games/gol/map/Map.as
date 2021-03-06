package pl.jaqjacek.games.gol.map 
{
	import flash.display.Sprite;
	import pl.jaqjacek.games.gol.Config;
	import pl.jaqjacek.games.gol.map.indicators.MapIniciator;
	import pl.jaqjacek.games.gol.map.indicators.ResetIniciator;
	/**
	 * ...
	 * @author jaq
	 * main clas for map container
	 */
	public class Map 
	{
		protected 	var _map:Vector.<Vector.<Cell>>;
		protected 	var _container:Sprite;
		protected 	var _mapIniciator:MapIniciator;
		private		var _cellsToCheck:Vector.<Cell>;
		private 	var _mapWidth:int;
		private 	var _mapHeight:int;
		
		public function Map(mapWidth:int,mapHeight:int) 
		{		
			init();
			createMap(mapWidth,mapHeight);
			inicializeCells();
		}
		
		protected function init():void 
		{
			_container 	= new Sprite()
			_map 		= new Vector.<Vector.<Cell>>();	
		}
		
		/**
		 * create map according to gived dementions if width and height is 0 its create default one
		 * @param	mapWidth
		 * @param	mapHeight
		 */
		protected function createMap(mapWidth:int=0,mapHeight:int=0):void 
		{
			_mapWidth 	= !mapWidth ? Config.MAP_WIDTH:mapWidth;
			_mapHeight	= !mapHeight ? Config.MAP_HEIGHT:mapHeight;
			
			var tmpVector:Vector.<Cell>
			for (var i:int = 0; i < _mapWidth; i++) 
			{
				tmpVector = new Vector.<Cell>();
				for (var j:int = 0; j < _mapHeight; j++) 
				{
					tmpVector.push(new Cell());
				}
				_map.push(tmpVector);
			}		
		}
		
		public function getWidth():int
		{
			return _mapWidth;
		}
		
		public function getHeight():int
		{
			return _mapHeight;
		}
		
		/**
		 * inicialize map cels
		 */
		protected function inicializeCells():void 
		{
			var tmpCell:Cell;
			
			for (var k:int = 0; k < _mapWidth; k++) 
			{
				for (var l:int = 0; l < _mapHeight; l++) 
				{
					tmpCell = getCell(k, l);
					tmpCell.x = k * Config.CELL_WIDTH;
					tmpCell.y = l * Config.CELL_HEIGHT;
					
					_container.addChild(tmpCell);
					tmpCell.draw();
					findCellNeighboursAt(k, l);
				}
			}		
		}
		
		/**
		 * fill add cell neighbours
		 * @param	x
		 * @param	y
		 */
		protected function findCellNeighboursAt(x:int,y:int):void 
		{
			var tmpCell:Cell 	= getCell(x, y);
			var startX:int 		= x - 1;
			var endX:int 		= x + 2;
			var startY:int 		= y - 1;
			var endY:int 		= y + 2;
			for (var i:int = startX; i < endX; i++) 
			{
				if (i < 0 || i >= _mapWidth)
					continue
				for (var j:int = startY; j < endY; j++) 
				{
					if (j < 0 || j >= _mapHeight)
						continue
					if ( x == i && j == y)
						continue
					tmpCell.addNeighbour(getCell(i,j))
				}
			}
		}
		
		public function reset():void 
		{
			_cellsToCheck = new Vector.<Cell>();
			new ResetIniciator().inicializeMap(this);
		}
		
		/**
		 * find first alive cell in map and fill _cellToCheck vector
		 */
		private function fillFirstCheckCell():void 
		{
			var tmpCell:Cell
			
			for (var k:int = 0; k < _mapWidth; k++) 
			{
				for (var l:int = 0; l < _mapHeight; l++) 
				{
					tmpCell = getCell(k, l);
					if (tmpCell.isAlive) {
						_cellsToCheck.push(tmpCell)
						_cellsToCheck = _cellsToCheck.concat(tmpCell.neighbours)
					}
				}
			}			
		}
		
		/**
		 * main loop function
		 */
		public function update():void 
		{
			//init new cells to check vector and if not exist find _currentCellsToCheck
			var tmpNewCellsToCheck:Vector.<Cell> = new Vector.<Cell>();
			if (!_cellsToCheck.length) {
				fillFirstCheckCell()
			}
				
			for each (var item:Cell in _cellsToCheck) 
			{
				if (item.isBlocked) // if item was allready check skip it
					continue
					
				item.checkCell(); // check if cell should by live again, stay in the same state or die
				if (!item.isToggled) // if item was allready check and state was change skip it
					continue
					
				tmpNewCellsToCheck.push(item)
				tmpNewCellsToCheck = tmpNewCellsToCheck.concat(item.neighbours);
				
			}
			
			_cellsToCheck = tmpNewCellsToCheck;
			for each (var itemz:Cell in _cellsToCheck) 
			{
				itemz.nextGeneration() // prepere cell for next generation
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
		
		/**
		 * returns string that represent current map state
		 * @return
		 */
		public function getMapString():String 
		{
			var resultString:String = '';
			for (var j:int = 0; j < _mapHeight; j++) 
			{
				for (var i:int = 0; i < _mapWidth; i++) 
				{
					resultString += _map[i][j].isAlive ? '1' : '0';
				}
				resultString += "|";
			}			
			//remove last |
			resultString = resultString.substr(0, resultString.length - 2);
			return resultString;
		}
	}

}
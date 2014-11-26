package pl.jaqjacek.games.gol 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class Cell extends Sprite 
	{
		protected var _neighbours:Vector.<Cell>
		protected var _state:Boolean
		protected var _toggleState:Boolean;
		protected var _blocked:Boolean;
		
		public function Cell() 
		{
			_neighbours = new Vector.<Cell>
		}
		
		public function addNeighbour(neighbour:Cell):void 
		{
			_neighbours.push(neighbour)
		}
		
		public function get neighbours():Vector.<Cell> 
		{
			return _neighbours;
		}
		
		public function get state():Boolean 
		{
			return _state;
		}
		
		protected function getLiveNeighboursCount():int 
		{
			var tmpCounter:int = 0
			for each (var item:Cell in _neighbours) 
			{
				if (item.state)
					tmpCounter++
			}
			return tmpCounter;
		}
		
		public function set state(value:Boolean):void 
		{
			_state = value;
		}
		
		public function checkGoDead():void 
		{
			var tmpCounter:int = getLiveNeighboursCount()
			if (tmpCounter < 2 || tmpCounter > 3)
				_toggleState = true;
		}
		
		public function checkGoUndead():void 
		{
			var tmpCounter:int = getLiveNeighboursCount();
			if (tmpCounter == 3) {
				_toggleState = true;
			}
		}
		
		public function checkCell():void 
		{
			if (_blocked)
				return;
			if (_state)
				checkGoDead()
			else
				checkGoUndead()
			blockCell();
		}
		
		public function nextGeneration():void 
		{
			if (_toggleState) {
				_state = !_state;			
			}
			reset();
			draw();
		} 
		
		public function draw():void 
		{
			var fillColor:uint = _state ? Config.CELL_ALIVE_COLOR:Config.CELL_DEAD_COLOR;
			this.graphics.clear()
			this.graphics.lineStyle(null,0x000000)
			this.graphics.beginFill(fillColor);
			this.graphics.drawRect( 1, 1, Config.CELL_WIDTH-2,Config.CELL_HEIGHT-2);
		}
		
		
		public function blockCell():void 
		{
			_blocked = true
		}
		
		public function unblockCell():void 
		{
			_blocked = false
		}
		
		public function reset():void 
		{
			unblockCell();
			_toggleState = false
		}
	}

}
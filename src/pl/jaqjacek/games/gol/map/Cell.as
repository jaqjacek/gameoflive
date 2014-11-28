package pl.jaqjacek.games.gol.map 
{
	import flash.display.Sprite;
	import pl.jaqjacek.games.gol.Config;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class Cell extends Sprite 
	{
		protected var _neighbours:Vector.<Cell>;
		protected var _alive:Boolean;
		protected var _toggleState:Boolean;
		protected var _blocked:Boolean;
		
		public function Cell() 
		{
			_neighbours = new Vector.<Cell>;
		}
		
		public function addNeighbour(neighbour:Cell):void 
		{
			_neighbours.push(neighbour);
		}
		
		public function get neighbours():Vector.<Cell> 
		{
			return _neighbours;
		}
		
		public function setAlive():void 
		{
			_alive = true;
		}
		
		public function setDead():void 
		{
			_alive = false
		}
		
		public function get isAlive():Boolean
		{
			return _alive
		}
		
		protected function getLiveNeighboursCount():int 
		{
			var tmpCounter:int = 0
			for each (var item:Cell in _neighbours) 
			{
				if (item.isAlive)
					tmpCounter++
			}
			return tmpCounter;
		}
		
		public function get isBlocked():Boolean 
		{
			return _blocked;
		}
		
		public function checkGoDead():void 
		{
			var tmpCounter:int = getLiveNeighboursCount()
			if (tmpCounter < Config.MIN_NIGHBOURS_TO_STILL_ALLIVE || tmpCounter > Config.MAX_NAIGHBOURS_TO_STILL_ALIVE )
				_toggleState = true;
		}
		
		public function checkGoUndead():void 
		{
			var tmpCounter:int = getLiveNeighboursCount()
			if (tmpCounter == Config.ALIVE_NAIGHBOURS_TO_GO_UNDED) {
				_toggleState = true;				
			}
		}
			
		public function get isToggled():Boolean 
		{
			return _toggleState
		}
		
		public function checkCell():void 
		{
			if (isBlocked)
				return;
				
			isAlive ? checkGoDead(): checkGoUndead();			
			blockCell();
		}
		
		public function nextGeneration():void 
		{
			if (isToggled) 
				_alive = !_alive;			
			
			
			reset();
			draw();
		} 
		
		public function draw():void 
		{
			var fillColor:uint = isAlive ? Config.CELL_ALIVE_COLOR : Config.CELL_DEAD_COLOR;
			this.graphics.clear()
			if(Config.CELL_BORDER_WIDTH)
				this.graphics.lineStyle(Config.CELL_BORDER_WIDTH,Config.CELL_BORDER_COLLOR)
			this.graphics.beginFill(fillColor);
			this.graphics.drawRect( 0, 0, Config.CELL_WIDTH, Config.CELL_HEIGHT);
			this.graphics.endFill();
		}
		
		
		protected function blockCell():void 
		{
			_blocked = true
		}
		
		protected function unblockCell():void 
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
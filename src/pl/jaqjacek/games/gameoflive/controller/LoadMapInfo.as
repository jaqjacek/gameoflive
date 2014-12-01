package pl.jaqjacek.games.gameoflive.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoadMapInfo extends SimpleCommand implements ICommand
	{
		
		public function LoadMapInfo() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
		}
		
	}

}
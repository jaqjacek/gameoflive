package pl.jaqjacek.games.gameoflive.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import pl.jaqjacek.games.gameoflive.model.MapProxy;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SetCurrentMapInfoCommand extends SimpleCommand implements ICommand
	{
		public static const NAME:String = "SetCurrentMapInfoCommand_";
		
		public function SetCurrentMapInfoCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:String = notification.getBody() as String;
			var mapProxy:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			mapProxy.setCurrentMapInfoByName(body);
		}
		
	}

}
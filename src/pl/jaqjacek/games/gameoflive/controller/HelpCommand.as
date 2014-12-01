package pl.jaqjacek.games.gameoflive.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import pl.jaqjacek.games.gameoflive.Consts;
	import pl.jaqjacek.games.gameoflive.view.HelpMediator;
	import pl.jaqjacek.games.gameoflive.view.HelpView;
	/**
	 * ...
	 * @author jaq
	 */
	public class HelpCommand  extends SimpleCommand implements ICommand
	{
		
		public function HelpCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
				var name:String = notification.getName();
				var body:Object = notification.getBody();
				var helpMediator:HelpMediator = facade.retrieveMediator(HelpMediator.NAME) as HelpMediator;
				switch(name) {
					case HelpView.SHOW:
						facade.sendNotification(Consts.PAUSE);
						helpMediator.show();
					break;
					case HelpView.HIDE:
						facade.sendNotification(Consts.RESUME);
						helpMediator.hide();
					break;
				}
		}
		
	}

}
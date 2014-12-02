package pl.jaqjacek.games.gameoflive.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import pl.jaqjacek.games.gameoflive.view.CycleView;
	import pl.jaqjacek.games.gameoflive.view.IntroView;
	import pl.jaqjacek.games.gameoflive.view.MenuView;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class SwitchCommand extends SimpleCommand implements ICommand
	{
		
		public function SwitchCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch(name) {
				case CycleView.HIDE:
					facade.retrieveMediator(MenuView.NAME)
					facade.sendNotification(MenuView.SHOW);
				break;
				case CycleView.SHOW:
					facade.sendNotification(MenuView.HIDE);
				//break;
				case IntroView.HIDE:
					facade.sendNotification(MenuView.SHOW);
				break;
			}
		}
	}
}
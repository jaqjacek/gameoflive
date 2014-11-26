package pl.jaqjacek.games.gameoflive.controller {
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import pl.jaqjacek.games.gameoflive.AppMediator;
	import pl.jaqjacek.games.gameoflive.Main;
	import pl.jaqjacek.games.gameoflive.view.CycleView;
	import pl.jaqjacek.games.gameoflive.view.IntroView;
	import pl.jaqjacek.games.gameoflive.view.MenuView;
	/**
	 * ...
	 * @author jaq
	 */
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		public function StartupCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			facade.registerMediator(new AppMediator(notification.getBody() as Main));
			//facade.sendNotification(MenuView.SHOW);
			facade.sendNotification(IntroView.SHOW);
		}
		
	}

}
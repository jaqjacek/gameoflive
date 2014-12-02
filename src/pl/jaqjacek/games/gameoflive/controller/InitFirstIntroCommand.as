package pl.jaqjacek.games.gameoflive.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import pl.jaqjacek.games.gameoflive.AppMediator;
	import pl.jaqjacek.games.gameoflive.Main;
	import pl.jaqjacek.games.gameoflive.view.IntroView;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class InitFirstIntroCommand extends SimpleCommand implements ICommand
	{
		
		public function InitFirstIntroCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			facade.registerMediator(new AppMediator(notification.getBody() as Main));			
			facade.sendNotification(IntroView.SHOW);
		}
	}

}
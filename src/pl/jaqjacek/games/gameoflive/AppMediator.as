package pl.jaqjacek.games.gameoflive 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import pl.jaqjacek.games.gameoflive.view.CycleMediator;
	import pl.jaqjacek.games.gameoflive.view.HelpMediator;
	import pl.jaqjacek.games.gameoflive.view.IntroMediator;
	import pl.jaqjacek.games.gameoflive.view.IntroView;
	import pl.jaqjacek.games.gameoflive.view.MenuMediator;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class AppMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = "AppMediator";
		
		public function AppMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			facade.registerMediator( new MenuMediator( viewComponent ) );
			facade.registerMediator( new CycleMediator( viewComponent ) );
			facade.registerMediator( new IntroMediator( viewComponent ) );
			facade.registerMediator( new HelpMediator( viewComponent ) );
		}
		
		
	}

}
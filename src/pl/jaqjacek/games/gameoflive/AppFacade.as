package pl.jaqjacek.games.gameoflive 
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	import pl.jaqjacek.games.gameoflive.controller.HelpCommand;
	import pl.jaqjacek.games.gameoflive.controller.SetCurrentMapInfoCommand;
	import pl.jaqjacek.games.gameoflive.controller.StartupCommand;
	import pl.jaqjacek.games.gameoflive.controller.SwitchCommand;
	import pl.jaqjacek.games.gameoflive.model.MapProxy;
	import pl.jaqjacek.games.gameoflive.view.CycleView;
	import pl.jaqjacek.games.gameoflive.view.IntroView;
	import pl.jaqjacek.games.gameoflive.view.MenuView;
	/**
	 * ...
	 * @author jaq
	 */
	public class AppFacade extends Facade implements IFacade
	{
		
		public static const NAME:String                         = 'AppFacade';
 
        public static const STARTUP:String                      = NAME + 'StartUp';
 
        public static function getInstance():AppFacade
        {
            return (instance ? instance : new AppFacade()) as AppFacade;
        }
 
        override protected function initializeController():void
        {
            super.initializeController();
 
            registerCommand( STARTUP, StartupCommand );
            registerCommand( MapProxy.SET_CURRENT_MAPINFO, SetCurrentMapInfoCommand );
            registerCommand( Consts.PAUSE, HelpCommand );
            registerCommand( Consts.RESUME, HelpCommand );
            registerCommand( CycleView.HIDE, SwitchCommand );
            registerCommand( MenuView.HIDE, SwitchCommand );
            registerCommand( IntroView.HIDE, SwitchCommand );
        }
 
        public function startup(stage:Object):void
        {
            sendNotification( STARTUP,  stage );
        }
 
        override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
        {
            trace( 'Sent ' + notificationName );
 
            notifyObservers( new Notification( notificationName, body, type ) );
        }
		
	}

}
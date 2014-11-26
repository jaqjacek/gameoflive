package pl.jaqjacek.games.gameoflive.view 
{
	import flash.events.Event;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class MenuMediator extends Mediator implements IMediator
	{
		private static const NAME:String = "menuMediator";
		private var menuView:MenuView;
		
		public function MenuMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void 
		{
			menuView = new MenuView();
			
		}
		
		override public function listNotificationInterests():Array 
		{
			return [
				HelpView.SHOW,
				HelpView.HIDE,				,
				MenuView.HIDE, 
				MenuView.UPDATE, 
				MenuView.SHOW
				];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch (name) 
			{
				case MenuView.UPDATE:
					menuView.update();
				break;
				case MenuView.SHOW:
					viewComponent.addChild(menuView);
					menuView.show();
					menuView.addEventListener(MenuView.BUTTON_CLICKED, menuButtonPressedHandler);
				break;
				case MenuView.HIDE:
					menuView.hide();
					if (menuView.parent) {
						menuView.parent.removeChild(menuView);
					}
					menuView.removeEventListener(MenuView.BUTTON_CLICKED, menuButtonPressedHandler);
				break;
				case HelpView.SHOW:
					menuView.visible = false;
				break;
				case HelpView.HIDE:
					menuView.visible = true;;
				break;
				default:
			}
		}
		
		private function menuButtonPressedHandler(e:Event):void 
		{
			facade.sendNotification(CycleView.SHOW);
			facade.sendNotification(MenuView.HIDE);
		}
		
	}

}
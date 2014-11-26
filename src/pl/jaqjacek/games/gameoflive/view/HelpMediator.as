package pl.jaqjacek.games.gameoflive.view 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	/**
	 * ...
	 * @author ...
	 */
	public class HelpMediator extends Mediator
	{
		
		private static const NAME:String = "helpMediator";
		private var helpView:HelpView;
		
		public function HelpMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void 
		{
			helpView = new HelpView();
			Stage(viewComponent.stage).addEventListener(KeyboardEvent.KEY_UP, keyPressedHandler);
		}
		
		private function keyPressedHandler(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case Keyboard.H:
					var notificationToSend:String = helpView.parent ? HelpView.HIDE : HelpView.SHOW;
					facade.sendNotification(notificationToSend);
				break;
			}
		}
		
		override public function listNotificationInterests():Array 
		{
			return [
				HelpView.HIDE, 
				HelpView.UPDATE, 
				HelpView.SHOW
				];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch (name) 
			{
				case HelpView.UPDATE:
					helpView.update();
				break;
				case HelpView.SHOW:
					viewComponent.addChild(helpView);
					helpView.show();
				break;
				case HelpView.HIDE:
					helpView.hide();
					if (helpView.parent) {
						helpView.parent.removeChild(helpView);
					}
				break;
				default:
			}
		}
		
	}

}
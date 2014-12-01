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
		
		public static const NAME:String = "helpMediator";
		private var helpView:HelpView;
		
		public function HelpMediator(viewComponent:Object = null)
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
			switch (e.keyCode)
			{
				case Keyboard.H: 
					var notificationToSend:String = helpView.parent ? HelpView.HIDE : HelpView.SHOW;
					facade.sendNotification(notificationToSend);
					break;
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [HelpView.HIDE, HelpView.UPDATE, HelpView.SHOW];
		}
		
		public function show():void 
		{
				viewComponent.addChild(helpView);
				helpView.show();
		}
		
		public function hide():void 
		{
				helpView.hide();
				if (helpView.parent)
				{
					helpView.parent.removeChild(helpView);
				}
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
				
					break;
				case HelpView.HIDE: 
				
					break;
				default: 
			}
		}
	
	}

}
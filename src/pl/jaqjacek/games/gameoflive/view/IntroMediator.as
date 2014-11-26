package pl.jaqjacek.games.gameoflive.view 
{
	import flash.events.Event;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class IntroMediator extends Mediator 
	{
		static public const NAME:String = "introMediator";
		private var _introView:IntroView;
		private var _startTime:Number;
		
		public function IntroMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);			
		}
		
		override public function onRegister():void 
		{
			_introView = new IntroView();
			viewComponent.addChild(_introView);
		}
		
		override public function listNotificationInterests():Array 
		{
			return [
				IntroView.HIDE,
				IntroView.SHOW,
				IntroView.END
			];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch(name) { 
				case IntroView.SHOW:
					viewComponent.addChild(_introView);
					_introView.show();
					startIntroTimeout();
				break;
				case  IntroView.HIDE:					
					viewComponent.removeChild(_introView);
					_introView.hide()
					
				break;
				
				case IntroView.END:
					endIntroTimeout();
				break;
			}
		}
		
		private function startIntroTimeout():void 
		{
			_introView.stage.addEventListener(Event.ENTER_FRAME, checkIntroTimeoutHandler);
			_startTime = new Date().time;
		}
		
		private function checkIntroTimeoutHandler(e:Event):void 
		{
			var tmpTime:Number = new Date().time -_startTime ;
			if (tmpTime > 2000) {				
				facade.sendNotification(IntroView.END);				
			}
		}
		
		private function endIntroTimeout():void 
		{
			_introView.stage.removeEventListener(Event.ENTER_FRAME, checkIntroTimeoutHandler);
			facade.sendNotification(IntroView.HIDE);
		}
		
	}

}
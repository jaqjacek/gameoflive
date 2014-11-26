package pl.jaqjacek.games.gameoflive.view 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class CycleMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = "cycleMediator";
		private var cycleView:CycleView;
		
		public function CycleMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);
		}
		
		/* INTERFACE org.puremvc.as3.interfaces.IMediator */
	
		
		override public function listNotificationInterests():Array 
		{
			return [
				CycleView.HIDE,
				CycleView.SHOW,
				CycleView.UPDATE
			];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch(name) { 
				case CycleView.SHOW:
					viewComponent.addChild(cycleView);
					cycleView.show();
					cycleView.run();
				break;
			case CycleView.HIDE:
					trace("handle Nottificaton CycleMediator");		
					cycleView.stop();
					cycleView.hide()
					
					viewComponent.removeChild(cycleView);
				break;
				
				case CycleView.UPDATE:
					cycleView.update();
				break;
			}
		}
		
		override public function onRegister():void 
		{
			cycleView = new CycleView();
			cycleView.onExit.add(exitFromView);
			
		}
		
		private function exitFromView(...rest):void 
		{			
			trace("cycle mediator exit from view");
			facade.sendNotification(CycleView.HIDE);
		}
	}

}
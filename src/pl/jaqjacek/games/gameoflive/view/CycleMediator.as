package pl.jaqjacek.games.gameoflive.view 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import pl.jaqjacek.games.gameoflive.Consts;
	import pl.jaqjacek.games.gameoflive.model.MapProxy;
	import pl.jaqjacek.games.gol.map.indicators.ResetIniciator;
	
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
				CycleView.UPDATE,
				Consts.PAUSE,
				Consts.RESUME
			];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			
			switch(name) { 
				case CycleView.SHOW:
					viewComponent.addChild(cycleView);
					setMapToCurrentMapInfo();
					cycleView.show();
					cycleView.run();
				break;
			case CycleView.HIDE:
					cycleView.stop();
					cycleView.hide()
					
					viewComponent.removeChild(cycleView);
				break;
				
				case CycleView.UPDATE:
					//cycleView.update();
				break;
				case Consts.PAUSE:
					cycleView.pause();
				break;
				case Consts.RESUME:
					cycleView.run();
				break;
			}
		}
		
		private function setMapToCurrentMapInfo():void 
		{
			var mapProxy:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			if(mapProxy.getCurrentMapInfo())
				cycleView.initMap(mapProxy.getCurrentMapInfo().mapData, mapProxy.getCurrentMapInfo().mapName);
		}
		
		override public function onRegister():void 
		{
			cycleView = new CycleView();
			cycleView.onExit.add(exitFromView);
			
		}
		
		private function exitFromView(...rest):void 
		{			
			facade.sendNotification(CycleView.HIDE);
		}
	}

}
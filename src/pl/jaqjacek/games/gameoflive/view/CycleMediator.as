package pl.jaqjacek.games.gameoflive.view 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import pl.jaqjacek.games.gameoflive.Consts;
	import pl.jaqjacek.games.gameoflive.model.MapProxy;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class CycleMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = "CycleMediator_";
		private var _cycleView:CycleView;
		
		public function CycleMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);
		}
		
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
					viewComponent.addChild(_cycleView);
					setMapToCurrentMapInfo();
					_cycleView.show();
					_cycleView.run();
				break;
				case CycleView.HIDE:
					_cycleView.stop();
					_cycleView.hide();
					viewComponent.removeChild(_cycleView);
				break;
				case CycleView.UPDATE:
				break;
				case Consts.PAUSE:
					_cycleView.pause();
				break;
				case Consts.RESUME:
					_cycleView.run();
				break;
			}
		}
		
		private function setMapToCurrentMapInfo():void 
		{
			var mapProxy:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			if(mapProxy.getCurrentMapInfo()) {
				_cycleView.initMap(mapProxy.getCurrentMapInfo().mapData, mapProxy.getCurrentMapInfo().mapName);
			}
		}
		
		override public function onRegister():void 
		{
			_cycleView = new CycleView();
			_cycleView.onExit.add(exitFromView);
		}
		
		private function exitFromView(...rest):void 
		{			
			facade.sendNotification(CycleView.HIDE);
		}
	}
}
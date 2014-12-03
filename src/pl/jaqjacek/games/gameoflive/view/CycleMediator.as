package pl.jaqjacek.games.gameoflive.view 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import pl.jaqjacek.games.gameoflive.Consts;
	import pl.jaqjacek.games.gameoflive.model.MapInfoVO;
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
					run();
				break;
				case CycleView.HIDE:
					stop();
					_cycleView.hide();
					viewComponent.removeChild(_cycleView);
				break;
				case CycleView.UPDATE:
				break;
				case Consts.PAUSE:
					pause();
				break;
				case Consts.RESUME:
					run();
				break;
			}
		}
		
		public function run():void 
		{
			stop();
			_cycleView.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			_cycleView.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function stop():void 
		{
			_cycleView.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			_cycleView.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function pause():void 
		{
			_cycleView.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case Keyboard.ENTER:
					_cycleView.onExit.dispatch();
				break;
			}
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			_cycleView.update();
		}
		
		private function setMapToCurrentMapInfo():void 
		{
			var mapProxy:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			var tmpMapVO:MapInfoVO = mapProxy.getCurrentMapInfo();
			if(tmpMapVO) {
				_cycleView.initMap(tmpMapVO.mapData, tmpMapVO.mapName);
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
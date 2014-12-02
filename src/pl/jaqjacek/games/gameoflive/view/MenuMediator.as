package pl.jaqjacek.games.gameoflive.view 
{
	import flash.events.Event;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import pl.jaqjacek.games.gameoflive.model.MapInfoVO;
	import pl.jaqjacek.games.gameoflive.model.MapProxy;
	import pl.jaqjacek.games.gol.map.indicators.RandomMapIniciator;
	import pl.jaqjacek.games.gol.map.indicators.StaticMapIniciator;
	import pl.jaqjacek.games.gol.map.MiniMapButton;
	
	/**
	 * ...
	 * @author jaq
	 */
	public class MenuMediator extends Mediator implements IMediator
	{
		private static const NAME:String = "MenuMediator_";
		private var _menuView:MenuView;
		
		public function MenuMediator(viewComponent:Object=null) 
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void 
		{
			var mapProxy:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			_menuView = new MenuView();
			_menuView.init(getMiniButtonsList());
		}
		
		private function getMiniButtonsList():Vector.<MiniMapButton>
		{
			var mapProxy:MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			var tmpVector:Vector.<MiniMapButton> = new Vector.<MiniMapButton>
			var tmpButton:MiniMapButton;
						
			for each (var item:MapInfoVO in mapProxy.getAllMapInfo())
			{
				tmpButton = new MiniMapButton();
				tmpButton.mapIniciator = new StaticMapIniciator(item.mapData, item.mapName);				
				tmpButton.mapIniciator.inicializeMap(tmpButton);
				tmpButton.initMinimapName();
				tmpVector.push(tmpButton);
			}
			return tmpVector;
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
					_menuView.update();
				break;
				case MenuView.SHOW:
					viewComponent.addChild(_menuView);
					_menuView.show();
					_menuView.addEventListener(MenuView.BUTTON_CLICKED, menuButtonPressedHandler);
				break;
				case MenuView.HIDE:
					_menuView.hide();
					if (_menuView.parent) {
						_menuView.parent.removeChild(_menuView);
					}
					_menuView.removeEventListener(MenuView.BUTTON_CLICKED, menuButtonPressedHandler);
				break;
				case HelpView.SHOW:
					_menuView.visible = false;
				break;
				case HelpView.HIDE:
					_menuView.visible = true;;
				break;
				default:
			}
		}
		
		private function menuButtonPressedHandler(e:Event):void 
		{
			facade.sendNotification(MapProxy.SET_CURRENT_MAPINFO, _menuView.lastButtonClicked.mapIniciator.getPatternName());
			facade.sendNotification(CycleView.SHOW);
			facade.sendNotification(MenuView.HIDE);
		}
	}
}
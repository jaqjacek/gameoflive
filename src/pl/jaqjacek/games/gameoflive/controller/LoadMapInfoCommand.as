package pl.jaqjacek.games.gameoflive.controller 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import pl.jaqjacek.games.gameoflive.model.MapInfoVO;
	import pl.jaqjacek.games.gameoflive.model.MapProxy;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoadMapInfoCommand extends SimpleCommand implements ICommand
	{
		
		public function LoadMapInfoCommand() 
		{
			
		}
		
		override public function execute(notification:INotification):void 
		{
			var mapProxy:MapProxy = new MapProxy();
			facade.registerProxy(mapProxy);
			mapProxy.addMapInfo(new MapInfoVO('01011|01101','snake'));
			mapProxy.addMapInfo(new MapInfoVO('11|101|011','ship'));
			mapProxy.addMapInfo(new MapInfoVO('11|1001|0011','aircraft carrier'));
			mapProxy.addMapInfo(new MapInfoVO('11|1001|011','beehive'));
			mapProxy.addMapInfo(new MapInfoVO('1|101|0101|001','barge'));
			mapProxy.addMapInfo(new MapInfoVO('1|101|0101|001','barge'));
			mapProxy.addMapInfo(new MapInfoVO('00011|10101|11','Python'));
			mapProxy.addMapInfo(new MapInfoVO('01|101|0101|0011','long boat'));
			mapProxy.addMapInfo(new MapInfoVO('01|101|0101|0011','long boat'));
			mapProxy.addMapInfo(new MapInfoVO('11|101|001|0011','fisherhook'));
			mapProxy.addMapInfo(new MapInfoVO('01011|01101','snake'));
			mapProxy.addMapInfo(new MapInfoVO('11101|1|00011|01101|10101'));
		}
		
	}

}
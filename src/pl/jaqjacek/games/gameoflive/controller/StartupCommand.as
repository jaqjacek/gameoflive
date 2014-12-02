package pl.jaqjacek.games.gameoflive.controller {
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.MacroCommand;
	/**
	 * ...
	 * @author jaq
	 */
	public class StartupCommand extends MacroCommand implements ICommand
	{
		
		public function StartupCommand() 
		{
			
		}
		
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(LoadMapInfoCommand);
			addSubCommand(InitFirstIntroCommand);
		}
	}
}
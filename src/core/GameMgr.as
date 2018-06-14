package core {
	import laya.utils.Handler;
	
	import module.block.BlockModule;
	import module.enter.EnterModule;
	import module.event.EventCenter;
	import module.event.EventType;
	import module.levelselect.LevelSelectModule;
	import module.texttip.TipModule;
	import module.win.WinModule;
	
	public class GameMgr {
		private static var _ins:GameMgr;
		
		public static function get ins():GameMgr {
			return _ins ||= new GameMgr;
		}
		
		public function GameMgr() {
			if (_ins) throw("use function get ins()!!!");
		}
		
		public static function start():void {
			initModule();
			
			var complete:Handler = Handler.create(null, function ():void {
				EventCenter.send(EventType.OPEN_ENTER_ANI_VIEW);
			});
			// todo 建议模块中加载
			loadRes(complete);
		}
		
		private static function initModule():void {
			// todo 建议一开始就进去的画面不使用module
			EnterModule.ins.addListener();
			LevelSelectModule.ins.addListener();
			BlockModule.ins.addListener();
			WinModule.ins.addListener();
			TipModule.ins.addListener();
		}
		
		private static function loadRes(complete:Handler):void {
			var path:String = 'res/atlas/resources.atlas';
			Laya.loader.load(path, complete);
		}
	}
}

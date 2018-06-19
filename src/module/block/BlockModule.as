package module.block {
	import core.GameLayer;
	
	import global.MapConfig;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	public class BlockModule {
		
		private static var _ins:BlockModule;
		
		public static function get ins():BlockModule {
			return _ins ||= new BlockModule;
		}
		
		public function BlockModule() {
			if (_ins) throw("use function get ins()!!!");
		}
		
		private var blockView:BlockView;
		
		public function addListener():void {
			EventCenter.add(EventType.OPEN_BLOCK_VIEW, this, onOpenBLockView);
			EventCenter.add(EventType.CLOSE_BLOCK_VIEW, this, onCloseBLockView);
			EventCenter.add(EventType.UPDATE_BLOCK_VIEW, this, onUpdateBlockView);
		}
		
		private function onUpdateBlockView(isWin:Boolean = false, callBack:Function = null):void {
			blockView.changeLightBulb(isWin, callBack);
		}
		
		private function onCloseBLockView():void {
			if (blockView) {
				GameLayer.ins.mainLayer.removeChild(blockView);
				blockView = null;
			}
		}
		
		private function onOpenBLockView(index:int = undefined):void {
			// todo 由于没有配置，这里每次打开界面的时候生成一次地图
			
			// todo 在levelSelect中做还是这里做
			BlockModel.ins.curLevel = index == undefined ? -1 : index;
			
			// 配置的地图
			var arr:Array = MapConfig.getArrById(1000 + index + '');
			if (arr) {
				BlockModel.ins.mapArr = arr;
			} else {
				BlockModel.ins.generateMap();
				console.warn("不存在地图id: " + (1000 + index) + ', 使用默认随机地图');
			}
			
			blockView = new BlockView;
			GameLayer.ins.mainLayer.addChild(blockView);
		}
	}
	
}

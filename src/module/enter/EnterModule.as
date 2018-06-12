package module.enter {
	import core.GameLayer;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	public class EnterModule {
		private static var _ins:EnterModule;
		
		public static function get ins():EnterModule {
			return _ins ||= new EnterModule;
		}
		
		public function EnterModule() {
			if (_ins) throw ("use function get ins()!!!");
		}
		
		private var enterView:EnterView;
		
		public function addListener():void {
			EventCenter.add(EventType.OPEN_ENTER_VIEW, this, onOpenEnterView);
			EventCenter.add(EventType.CLOSE_ENTER_VIEW, this, onCloseEnterView);
			EventCenter.add(EventType.OPEN_ENTER_ANI_VIEW, this, onOpenEnterAniView);
			EventCenter.add(EventType.CLOSE_ENTER_ANI_VIEW, this, onCloseEnterAniView);
		}
		
		private function onCloseEnterAniView():void {
			if(enterAniView){
				GameLayer.ins.popLayer.removeChild(enterAniView);
				enterAniView = null;
			}
		}
		
		private var enterAniView: EnterAniView;
		private function onOpenEnterAniView():void {
			enterAniView = new EnterAniView;
			GameLayer.ins.popLayer.addChild(enterAniView);
		}
		
		private function onCloseEnterView():void {
			if (enterView) {
				GameLayer.ins.topLayer.removeChild(enterView);
				enterView = null;
			}
		}
		
		private function onOpenEnterView():void {
			enterView = new EnterView;
			GameLayer.ins.topLayer.addChild(enterView);
		}
	}
}

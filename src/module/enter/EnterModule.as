package module.enter {
    import core.GameLayer;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    public class EnterModule {
        private static var _ins:EnterModule;
        public function EnterModule() {
            if(_ins) throw ("use function get ins()!!!");
        }
    
        public static function get ins():EnterModule {
            return _ins ||= new EnterModule;
        }
        
        public function addListener():void {
            EventCenter.add(EventType.OPEN_ENTER_VIEW, this, onOpenEnterView);
            EventCenter.add(EventType.CLOSE_ENTER_VIEW, this, onCloseEnterView);
        }
    
        private function onCloseEnterView():void {
            if(enterView) {
                GameLayer.ins.topLayer.removeChild(enterView);
                enterView = null;
            }
        }
        private var enterView:EnterView;
        private function onOpenEnterView():void {
            enterView = new EnterView;
            GameLayer.ins.topLayer.addChild(enterView);
        }
    }
}

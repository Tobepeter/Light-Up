package module.levelselect {
    import core.GameLayer;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    public class LevelSelectModule {
        private static var _ins:LevelSelectModule;
        
        public function LevelSelectModule() {
            if (_ins) throw ("use function get ins()!!!");
        }
        
        public static function get ins():LevelSelectModule {
            return _ins ||= new LevelSelectModule;
        }
        
        public function addListener():void {
            EventCenter.add(EventType.OPEN_LEVEL_SELECT_VIEW, this, onOpenLevelSelectView);
            EventCenter.add(EventType.CLOSE_LEVEL_SELECT_VIEW, this, onCloseLevelSelectView);
        }
        
        private function onCloseLevelSelectView():void {
            if (levelSelectView) {
                GameLayer.ins.windowLayer.removeChild(levelSelectView);
                levelSelectView = null;
            }
        }
        
        private var levelSelectView:LevelSelectView;
        
        private function onOpenLevelSelectView():void {
            levelSelectView = new LevelSelectView;
            GameLayer.ins.windowLayer.addChild(levelSelectView);
        }
    }
}

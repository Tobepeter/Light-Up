package module.win {
    import laya.events.Event;
    
    import module.block.BlockModel;
    
    import module.event.EventCenter;
    import module.event.EventType;
    import module.levelselect.LevelSelectModel;
    
    import ui.WinViewUI;
    
    public class WinView extends WinViewUI {
        public function WinView() {
        }
        
        override protected function initialize():void {
            nextBtn.on(Event.CLICK, this, onclick);
        }
        
        private function onclick():void {
            // 只有当前关卡是最新关卡才会解锁
            if (BlockModel.ins.curLevel == LevelSelectModel.ins.openLevel) {
                LevelSelectModel.ins.nextLevel();
            }
            
            EventCenter.send(EventType.CLOSE_BLOCK_VIEW);
            EventCenter.send(EventType.CLOSE_WIN_VIEW);
            EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
        }
        
    }
}

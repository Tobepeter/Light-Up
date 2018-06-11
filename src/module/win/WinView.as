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
            // 下一关，重置地图
            LevelSelectModel.ins.nextLevel();
            BlockModel.ins.generateMap();
            
            EventCenter.send(EventType.CLOSE_BLOCK_VIEW);
            EventCenter.send(EventType.CLOSE_WIN_VIEW);
            EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
        }
        
    }
}

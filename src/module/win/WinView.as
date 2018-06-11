package module.win {
    import laya.events.Event;
    
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
            // 下一关
            LevelSelectModel.ins.nextLevel();
            
            EventCenter.send(EventType.CLOSE_BLOCK_VIEW);
            EventCenter.send(EventType.CLOSE_WIN_VIEW);
            EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
        }
        
    }
}

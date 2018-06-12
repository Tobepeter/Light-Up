package module.levelselect {
    import laya.events.Event;
    import laya.utils.Handler;
    
    import module.block.BlockModel;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    import ui.LevelSelectViewUI;
    
    public class LevelSelectView extends LevelSelectViewUI {
        public function LevelSelectView() {
        
        }
        
        override protected function initialize():void {
            super.initialize();
            // list中的box做监听，但是本身需要满足enable链
            mouseEnabled = true;
            levelList.dataSource = LevelSelectModel.ins.leverSource;
            levelList.mouseHandler = Handler.create(this, onMouseHandler, undefined, false);
        }
        
        private function onMouseHandler(e:Event, index:int):void {
            if (e.type != Event.CLICK) return;
            if (index + 1 > LevelSelectModel.ins.openLevel) return;
            EventCenter.send(EventType.CLOSE_LEVEL_SELECT_VIEW);
            EventCenter.send(EventType.OPEN_BLOCK_VIEW, [index + 1]);
        }
    }
}

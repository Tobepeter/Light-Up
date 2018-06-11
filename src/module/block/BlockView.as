package module.block {
    import laya.events.Event;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    import ui.BlockViewUI;
    
    public class BlockView extends BlockViewUI {
        public function BlockView() {
            backBtn.on(Event.CLICK, this, onclick);
            initBlockComp();
        }
        
        private var blockComp:BlockComp;
        
        private function initBlockComp():void {
            blockComp ||= new BlockComp();
            var size:int = blockBox.width;
            blockComp.size(size, size);
            blockComp.update();
            // 绘制一个边框 要超出5px，线条3px，空开2px
            var len:int = 5;
            blockBox.graphics.drawRect(-len, -len, blockBox.width + len * 2, blockBox.height + len * 2, undefined, '#000', len-2);
            blockBox.addChild(blockComp);
        }
        
        private function onclick():void {
            EventCenter.send(EventType.CLOSE_BLOCK_VIEW);
            EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
        }
    }
}

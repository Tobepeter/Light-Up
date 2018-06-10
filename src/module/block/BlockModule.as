package module.block {
    import core.GameLayer;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    public class BlockModule {
        
        private static var _ins:BlockModule;
        
        public function BlockModule() {
            if(_ins) throw("use function get ins()!!!")
        }
    
        public static function get ins():BlockModule {
            return _ins ||= new BlockModule;
        }
    
        public function addListener():void {
            EventCenter.add(EventType.OPEN_BLOCK_VIEW, this, onOpenBLockView);
            EventCenter.add(EventType.CLOSE_BLOCK_VIEW, this, onCloseBLockView);
        }
    
        private function onCloseBLockView():void {
            if(blockView) {
                GameLayer.ins.mainLayer.removeChild(blockView);
                blockView = null;
            }
        }
        
        private var blockView:BlockView;
        private function onOpenBLockView():void {
            blockView = new BlockView;
            GameLayer.ins.mainLayer.addChild(blockView);
        }
    }
    
}

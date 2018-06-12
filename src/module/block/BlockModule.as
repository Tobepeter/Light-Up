package module.block {
    import core.GameLayer;
    
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
        
        private function onUpdateBlockView(data:Boolean = false):void {
            blockView.changeLightBulb(data);
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
            BlockModel.ins.generateMap();
            blockView = new BlockView;
            GameLayer.ins.mainLayer.addChild(blockView);
        }
    }
    
}

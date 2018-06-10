package core {
    import module.block.BlockModel;
    import module.block.BlockView;
    
    public class GameMgr {
        private static var _ins:GameMgr;
        
        public static function get ins():GameMgr {
            return _ins ||= new GameMgr;
        }
        
        public function GameMgr() {
            if (_ins) throw("use function get ins()!!!");
        }
        
        public static function start():void {
            BlockModel.ins.generateMap();
            var blockView:BlockView = new BlockView;
            GameLayer.ins.mainLayer.addChild(blockView);
        }
        
    }
}

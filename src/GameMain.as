﻿package {
    import global.GameConfig;
    
    import core.GameMgr;
    
    import laya.display.Stage;
    
    public class GameMain {
        
        public function GameMain() {
            initStage();
            GameMgr.start();
            
            // todo
            // TestCenter.useDebugPanel();
            // TestCenter.useTest();
            // TestCenter.test();
        }
        
        private static function initStage():void {
            // Laya.init(GameConfig.BLOCK_SIZE * GameConfig.H_BLCOK, GameConfig.BLOCK_SIZE * GameConfig.V_BLOCK);
    
            // var width:int = GameConfig.BLOCK_SIZE * GameConfig.H_BLCOK * 2;
            // var height:int = GameConfig.BLOCK_SIZE * GameConfig.V_BLOCK * 2;
            // Laya.init(width, height);
    
            Laya.init(GameConfig.GAME_WIDHT, GameConfig.GAME_HEIGHT);
            
            Laya.stage.alignH = Stage.ALIGN_CENTER;
            Laya.stage.alignV = Stage.ALIGN_MIDDLE;
            Laya.stage.bgColor = '#ffffff';
            Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
        }
    }
}

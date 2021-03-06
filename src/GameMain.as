﻿package {
	import core.GameMgr;
	
	import global.GameConfig;
	import global.MapConfig;
	
	import laya.display.Stage;
	import laya.utils.Handler;
	
	import utils.TestCenter;
	
	public class GameMain {
		
		public function GameMain() {
			initStage();
			loadAssets(Handler.create(this, onLoaded));
		}
		
		private function loadAssets(handler:Handler):void {
			MapConfig.load(handler);
		}
		
		private function onLoaded():void {
			GameMgr.start();
			
			// todo
			// TestCenter.useDebugPanel();
			TestCenter.test();
			TestCenter.useTest();
			TestCenter.useCheat();
			// TestCenter.useDebugTool();
			// TestCenter.useDebugPanel(false);
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

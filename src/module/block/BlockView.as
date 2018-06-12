package module.block {
	import laya.events.Event;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	import ui.BlockViewUI;
	
	public class BlockView extends BlockViewUI {
		public function BlockView() {
			backBtn.on(Event.CLICK, this, onclick);
			initBlockComp();
			Laya.timer.loop(200, this, onLoop);
			onLoop();
		}
		
		private var blockComp:BlockComp;
		
		private function initBlockComp():void {
			blockComp ||= new BlockComp();
			var width:int = blockBox.width;
			var height:int = blockBox.height;
			blockComp.size(width, height);
			blockComp.update();
			
			// 绘制一个边框 要超出5px，线条3px，空开2px
			// var len:int = 5;
			// blockBox.graphics.drawRect(-len, -len, blockBox.width + len * 2, blockBox.height + len * 2, undefined, '#000', len-2);
			
			blockBox.addChild(blockComp);
		}
		
		public function changeLightBulb(isWin:Boolean, callBack:Function = undefined):void {
			// todo 这里可以使用Animation来做
			// todo 这里感觉逻辑可以继续优化一下
			// todo 弹出win界面应该在这里用callBack试试
			// todo 还有电路板逻辑还没有做
			var darkBulbSkin:String = 'resources/light_1.png';
			var darkPCBSkin:String = 'resources/background_pcb_2_line.png';
			var lightPCBSkin:String = 'resources/background_pcb_1_line.png';
			if (isWin) {
				imgPCB.skin = lightPCBSkin;
				var index:int = 1;
				
				function onLoop():void {
					ligthBulb.skin = 'resources/light_' + index + '.png';
					index++;
					if (index > 5) {
						Laya.timer.clear(null, onLoop);
						if(callBack) callBack();
					}
				}
				
				Laya.timer.loop(200, null, onLoop);
			} else {
				ligthBulb.skin = darkBulbSkin;
				imgPCB.skin = darkPCBSkin;
			}
		}
		
		private var curPow:int = 1; // 1-4
		private function onLoop():void {
			imgPower.skin = 'resources/power' + curPow + '.png';
			curPow++;
			if (curPow > 4) curPow = 1;
		}
		
		private function onclick():void {
			EventCenter.send(EventType.CLOSE_BLOCK_VIEW);
			EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
		}
	}
}

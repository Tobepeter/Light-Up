package module.block {
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	import ui.BlockViewUI;
	
	public class BlockView extends BlockViewUI {
		public function BlockView() {
			backBtn.on(Event.CLICK, this, onclick);
			initBlockComp();
			initPowerBall();
			initPowerSmall();
		}
		
		private function initPowerBall():void {
			var curPow:int = 1; // 1-5
			Laya.timer.loop(300, null, onLoop);
			function onLoop():void {
				// 充电动画
				imgPow.skin = 'resources/powerBall_' + curPow + '.png';
				curPow++;
				if (curPow > 5) curPow = 1;
				if(_isWin) {
					Laya.timer.clear(null, onLoop);
				}
			}
		}
		
		// private var powRawPosArr:Array = [[119, 43], [101, 75], [68, 94]];       //暂时把原始位置记下来
		// public var powTargetPosArr:Array = [[223, 81], [189, 149], [116, 198]];  //参考
		private var powerNum:int = 0;
		private var _isWin:Boolean;
		
		private function movePowerSmall():void {
			var delay:int = 600;
			Tween.to(powersmall1, {x: 223, y: 81}, delay, null, Handler.create(this, addPowerNum));
			Tween.to(powersmall2, {x: 189, y: 149}, delay, null, Handler.create(this, addPowerNum));
			Tween.to(powersmall3, {x: 116, y: 198}, delay, null, Handler.create(this, addPowerNum));
			
			function addPowerNum():void {
				powerNum++;
				if (powerNum >= 3) {
					powerNum = 0;
					initPowerSmall();
				}
			}
		}
		
		private function initPowerSmall():void {
			// 这只是一个动画过程，虽然看起来有些复杂
			Laya.timer.once(50, null, function ():void {
				powersmall1.pos(119, 43);
				powersmall2.pos(101, 75);
				powersmall3.pos(68, 94);
				powersmall1.visible = false;
				powersmall2.visible = false;
				powersmall3.visible = false;
			});
			if (!_isWin) {
				Laya.timer.once(500, null, function ():void {
					powersmall1.visible = true;
					powersmall2.visible = true;
					powersmall3.visible = true;
					movePowerSmall();
				});
			} else {
				powersmall1.visible = true;
				powersmall2.visible = true;
				powersmall3.visible = true;
			}
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
			var lightPCBSkin:String = 'resources/background_pcb_1.png';
			var darkPCBSkin:String = 'resources/background_pcb_2.png';
			if (isWin) {
				_isWin = true;
				imgPCB.skin = lightPCBSkin;
				var index:int = 1;
				
				function onLoop():void {
					ligthBulb.skin = 'resources/light_' + index + '.png';
					index++;
					if (index > 5) {
						Laya.timer.clear(null, onLoop);
						if (callBack) callBack();
					}
				}
				
				Laya.timer.loop(200, null, onLoop);
			} else {
				ligthBulb.skin = darkBulbSkin;
				imgPCB.skin = darkPCBSkin;
			}
		}
		
		private function onclick():void {
			if(_isWin) return;
			EventCenter.send(EventType.CLOSE_BLOCK_VIEW);
			EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
		}
	}
}

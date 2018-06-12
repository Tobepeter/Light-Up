package module.enter {
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	import ui.EnterAniViewUI;
	
	public class EnterAniView extends EnterAniViewUI {
		public function EnterAniView() {
			alpha = 0;
			Laya.timer.once(500, this, initView);
		}
		
		private function initView():void {
			var _this:Object = this;
			Tween.to(_this, {alpha: 1}, 800, null, Handler.create(null, function ():void {
				// 这个回调方式有些复杂，不过可以减少很多函数
				var stepSkin:Array = [1, 2, 1, 2, 1, 3];
				var stepDelay:Array = [100, 300, 300, 300, 300, 300];
				var stepLen:int = stepSkin.length;
				var curStep:int = 0;
				
				// 步进与回调
				function nextStep():void {
					Laya.timer.once(stepDelay[curStep], null, function ():void {
						imgAni.skin = 'resources/enter_anim_' + stepSkin[curStep] + '.png';
						curStep++;
						if (curStep < stepLen) {
							nextStep();
						} else {
							// todo 这里莫名其妙this变成了window了,只好使用_this
							Tween.to(_this, {alpha: 0}, 1000, null, Handler.create(null, function ():void {
								// 派发动画结束
								// Laya.timer.once(500, null, function():void{
								EventCenter.send(EventType.CLOSE_ENTER_ANI_VIEW);
								EventCenter.send(EventType.OPEN_ENTER_VIEW);
								// });
							}));
						}
					});
				}
				
				nextStep();
			}));
		}
		
	}
}

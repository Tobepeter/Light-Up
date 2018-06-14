package module.texttip {
	import core.GameLayer;
	
	import laya.display.Sprite;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Tween;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	public class TipModule {
		private static var _ins:TipModule;
		
		public function TipModule() {
		}
		
		public static function get ins():TipModule {
			return _ins ||= new TipModule;
		}
		
		public function addListener():void {
			EventCenter.add(EventType.OPEN_TEXT_TIP_VIEW, this, onOpenTextTipView);
			EventCenter.add(EventType.CLOSE_TEXT_TIP_VIEW, this, onCloseTextTipView);
		}
		
		private function onCloseTextTipView():void {
		
		}
		
		private var ctn:Sprite = new Sprite;
		private function onOpenTextTipView(...args):void {
			// 准备一个容器，方便批量处理
			ctn.removeChildren();
			ctn.pos(Laya.stage.width / 2, Laya.stage.height / 2);
			GameLayer.ins.topLayer.addChild(ctn);
			
			var tipItem:TipItem;
			var tipItemArr:Array = [];
			for (var i:int = 0, iLen:int = args.length; i < iLen; i++) {
				var str:String = args[i].toString();
				tipItem = Pool.getItemByClass('TipItem', TipItem);
				tipItem.text = str;
				ctn.addChild(tipItem);
				tipItemArr.push(tipItem);
			}
			
			// 全部生成之后做动画 （移动淡入，淡出）
			var height:int = tipItem.height;
			for (var j:int = 0; j < tipItemArr.length; j++) {
				var targetY:int = height * (tipItemArr.length - j);
				targetY *= 1.2; // 微调
				(function ():void {
					var target:TipItem = tipItemArr[j];
					Tween.to(target, {y: -targetY, alpha: 1}, 300, null, Handler.create(null, function ():void {
						Tween.to(target, {alpha: 0}, 800, null, Handler.create(null, function ():void {
							target.recover();
							ctn.removeSelf();
							target.removeSelf();
						}));
					}));
				})();
			}
			
		}
	}
}

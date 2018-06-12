package module.block {
	import global.GameConfig;
	
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Component;
	import laya.ui.Image;
	import laya.utils.Dictionary;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Tween;
	
	import module.event.EventCenter;
	import module.event.EventType;
	
	/**
	 * 砖块地图界面
	 * @desc 这个类有点复杂，主要是自己什么都想写通用的就搞成这样了
	 * @desc 以后有机会再整理吧
	 */
	public class BlockComp extends Component {
		public static var ins:BlockComp;
		
		public function BlockComp() {
			// 这里不仅仅可以作为一个组件，还可以单独添加打舞台中
			// 如果需要规划大小，需要在外部进行设置
			width = GameConfig.BLOCK_SIZE * GameConfig.H_BLCOK;
			height = GameConfig.BLOCK_SIZE * GameConfig.V_BLOCK;
			update();
			on(Event.CLICK, this, onClick);
			
			// todo 待处理这个
			// on(Event.MOUSE_DOWN, this, onMouseDown);
			ins = this;
		}
		
		private function onMouseDown(evt:Event):void {
			var index:int = imgDic.keys.indexOf(evt.target);
			if (index < 0) return;
			var point:Point = imgDic.values[index];
			var arr:Array = BlockModel.ins.mapArr;
			// todo 这个逻辑感觉有些复杂了，应该写一个根据点来找img的方法会好很多
			for (var i:int = -1; i <= 1; i++) {
				for (var j:int = -1; j <= 1; j++) {
					if (i * j != 0) continue;
					var row:int = point.x + i;
					var col:int = point.y + j;
					
					var hasFound:Boolean = false;
					for (var k:int = 0, kLen:int = imgDic.values.length; k < kLen; k++) {
						if (imgDic.values[k].x == row && imgDic.values[k].y == col) {
							hasFound = true;
							break;
						}
					}
					
					if (hasFound) {
						// 加入个滤镜一个皮肤
						var img:Image = imgDic.keys[k];
						var maskImg:Image = Pool.getItemByClass('Image', Image);
						maskImg.alpha = 0.8;
						maskImg.width = img.width * 0.7;
						maskImg.height = img.height * 0.7;
						
						// todo 这里使用centerX可以用
						// maskImg.pivot(maskImg.width, maskImg.height);
						// maskImg.pos(img.width / 2, img.height / 2);
						
						// 这里做特殊处理了，不好调整
						if (arr[row][col] == BlockConst.LIGHT_BLOCK) {
							maskImg.centerX = -2;
							maskImg.centerY = 2;
						} else {
							maskImg.centerX = -1;
							maskImg.centerY = 2;
						}
						maskImg.skin = 'resources/press.png';
						img.addChild(maskImg);
					}
					
				}
				
			}
		}
		
		private var imgDic:Dictionary = new Dictionary; // key:Image, value:Point
		
		override public function set width(value:Number):void {
			// if (width == value) return;
			super.width = value;
			// updatePos();
		}
		
		override public function set height(value:Number):void {
			// if (height == value) return;
			super.height = value;
			// updatePos();
		}
		
		/**更新界面 */
		public function update():void {
			recoverBlock();
			var arr:Array = BlockModel.ins.mapArr;
			var row:int = arr.length;
			var col:int = BlockModel.ins.MaxCol;
			var wSize:int = width / col;
			var hSize:int = height / row;
			for (var i:int = 0, iLen:int = arr.length; i < iLen; i++) {
				for (var j:int = 0; j < arr[i].length; j++) {
					if (arr[i][j] == BlockConst.NONE) continue;
					
					// 初始化一个img
					var img:Image = Pool.getItemByClass("Image", Image);
					img.size(wSize, wSize);
					img.mouseEnabled = true;
					img.pivot(wSize / 2, hSize / 2);
					img.mouseEnabled = true;
					img.pos(j * wSize + wSize / 2, i * hSize + hSize / 2);
					addChild(img);
					
					// 初始化行列
					var point:Point = Pool.getItemByClass("Point", Point);
					point.x = i;
					point.y = j;
					imgDic.set(img, point);
					
					// 分配img
					switch (arr[i][j]) {
						case BlockConst.DARK_BLOCK:
							img.skin = 'resources/block_dark.png';
							break;
						case BlockConst.LIGHT_BLOCK:
							img.skin = 'resources/block_light.png';
							break;
					}
				}
			}
		}
		
		// 在数组没有外界更改的时候调用这个，不用img全部重新摆放
		public function simpleUpdate():void {
			var arr:Array = BlockModel.ins.mapArr;
			for (var i:int = 0, iLen:int = imgDic.values.length; i < iLen; i++) {
				var row:int = imgDic.values[i].x;
				var col:int = imgDic.values[i].y;
				var img:Image = imgDic.keys[i];
				switch (arr[row][col]) {
					case BlockConst.DARK_BLOCK:
						img.skin = 'resources/block_dark.png';
						break;
					case BlockConst.LIGHT_BLOCK:
						img.skin = 'resources/block_light.png';
						break;
					default:
						break;
				}
			}
		}
		
		public function updateImg(img:Image):void {
			var point:Point = imgDic.get(img);
			if (point) {
				var arr:Array = BlockModel.ins.mapArr;
				switch (arr[point.x][point.y]) {
					case BlockConst.DARK_BLOCK:
						img.skin = 'resources/block_dark.png';
						break;
					case BlockConst.LIGHT_BLOCK:
						img.skin = 'resources/block_light.png';
						break;
					default:
						break;
				}
			}
		}
		
		/**点击事件 */
		private var tweenDic:Dictionary = new Dictionary;
		
		private function onClick(evt:Event):void {
			// 判断点击对象以及是否重复点击
			var index:int = imgDic.keys.indexOf(evt.target);
			if (index < 0) return;
			var target:Image = imgDic.keys[index];
			var isTween:Boolean = tweenDic.get(target);
			if (isTween) return;
			var point:Point = imgDic.values[index];
			
			// 动画结束就要关闭点击，数据已经改变了，画面延迟更新
			var row:int = point.x;
			var col:int = point.y;
			if (GameConfig.IS_DEBUG) {
				BlockModel.ins.singleSwitch(row, col);
			} else {
				BlockModel.ins.switchPoint(row, col);
			}
			var isWin:Boolean = BlockModel.ins.isWin();
			if (isWin) off(Event.CLICK, this, onClick);
			
			// @formatter:off
			// todo 这里的target只是一份引用，不用担心太多内存消耗
			tweenDic.set(target, true);
			var delay:int = 150;
			var scale:Number = 0.9;
			var tween:Tween = Tween.to(target, {scaleX: scale,scaleY: scale}, delay, Ease.linearNone, Handler.create(null, function ():void {
				// 这里只是更新特殊反转，不过由于效果不好，暂时不要了
				// updateImg(target);
				Tween.to(target, {scaleX: 1, scaleY: 1}, delay, Ease.linearNone, Handler.create(null, function ():void {
					tweenDic.set(target, false);
					// todo 这里的tween的内存应该是保留的
					tween && Tween.clear(tween);
					tween = null;
					
					// todo 其实只要更新附近就好了
					simpleUpdate();
					// 打开胜利界面
					if (isWin) {
						var callBack:Function = function ():void {
							Laya.timer.once(1000, null, function ():void {
								EventCenter.send(EventType.OPEN_WIN_VIEW);
							});
						};
						EventCenter.send(EventType.UPDATE_BLOCK_VIEW, [true, callBack]);
					}
				}));
			}));
			
			// @formatter:on
		}
		
		/**重置砖块 */
		private function recoverBlock():void {
			// 遍历dic，并且让每个img回收，pos回收
			var dicLen:int = imgDic.keys.length;
			for (var j:int = 0; j < dicLen; j++) {
				var img:Image = imgDic.keys[j];
				img.skin = "";
				Pool.recover("Image", img.removeSelf());
				var point:Point = imgDic.values[j];
				Pool.recover("Point", point);
			}
			imgDic.clear();
		}
		
		private function updatePos():void {
			pivot(width / 2, height / 2);
			pos(super.width / 2, super.height / 2);
			
			// 使用一个边框
			graphics.clear();
			graphics.drawRect(0, 0, width, height, null, '#000000', 2);
		}
	}
}

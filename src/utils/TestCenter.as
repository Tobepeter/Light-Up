package utils {
	import core.GameLayer;
	
	import global.GameConfig;
	import global.MapConfig;
	
	import laya.debug.DebugPanel;
	import laya.debug.DebugTool;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.utils.Log;
	
	import module.block.BlockComp;
	import module.block.BlockConst;
	import module.block.BlockModel;
	import module.event.EventCenter;
	import module.event.EventType;
	
	public class TestCenter {
		
		/** 静态变量，可以随意访问需要的东西 */
		public static var someThing:*;
		
		/** 测试方法，注意删除 */
		public static function test():void {
			// 测试animation
			
			// 测试飘字
			// EventCenter.send(EventType.OPEN_TEXT_TIP_VIEW, ["ttt"]);
			//
			// Laya.stage.on(Event.CLICK, null, function ():void {
			// 	EventCenter.send(EventType.OPEN_TEXT_TIP_VIEW, ["ttt1", "ttt2", "ttt3"]);
			// });
			
			// 测试TipManager
			
			// 测试读取配置
			// Laya.loader.load('config/map1_1.json', Handler.create(null, function (data:*):void {
			// 	console.log(data);
			// }));
			
			// 测试mapConfig
			// console.log('~~');
			// console.log(MapConfig.mapDic);
		}
		
		/** 添加白色挡板 */
		private static function addWhiteBg():Sprite {
			var sp:Sprite = new Sprite;
			sp.graphics.drawRect(0, 0, Laya.stage.desginWidth, Laya.stage.desginHeight, '#FFF');
			Laya.stage.addChild(sp);
			return sp;
		}
		
		/** 随机填充地图 */
		public static function showBlockMap():void {
			var blockView:BlockComp = new BlockComp;
			GameLayer.ins.mainLayer.removeChildren();
			GameLayer.ins.mainLayer.addChild(blockView);
			RandomUtils.fulfillArr(BlockModel.ins.mapArr, [0, 1, 2]);
			blockView.update();
		}
		
		/** 测试地图随机点击 */
		public static function randomClick():void {
			var blockView:BlockComp = new BlockComp;
			GameLayer.ins.mainLayer.removeChildren();
			GameLayer.ins.mainLayer.addChild(blockView);
			BlockModel.ins.randomMap([BlockConst.NONE, BlockConst.LIGHT_BLOCK]);
			Laya.timer.clear(null, onLoop);
			Laya.timer.loop(1000, null, onLoop);
			
			function onLoop():void {
				BlockModel.ins.randomSwitch();
				blockView.update();
			}
		}
		
		/** 自由配置砖块 */
		public static function customBlock():void {
			var blockView:BlockComp = new BlockComp;
			GameLayer.ins.mainLayer.removeChildren();
			GameLayer.ins.mainLayer.addChild(blockView);
			
			// @formatter:off;
            // -------------------
            // 注意配置固定了 10 * 10 (0:无， 1：红， 2，白/绿)
            var arr: Array = [
                [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
                [ 1, 2, 2, 2, 2, 2, 2, 2, 2, 1 ],
                [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
                [ 1, 1, 1, 0, 0, 0, 0, 1, 1, 1 ],
                [ 1, 1, 1, 0, 2, 2, 0, 1, 1, 1 ],
                [ 1, 1, 1, 0, 2, 2, 0, 1, 1, 1 ],
                [ 1, 1, 1, 0, 0, 0, 0, 1, 1, 1 ],
                [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
                [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
                [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ]
            ];
            
            if(arr.length != GameConfig.V_BLOCK) {console.warn('测试竖直方向长度有误'); return;}
            if(arr[0].length != GameConfig.H_BLCOK) {console.warn('测试水平方向长度有误'); return;}
            // -------------------
            // @formatter:on;
			
			// 赋值数据
			// var blockArr:Array = BlockModel.ins.mapArr;
			// for (var i:int = 0; i < arr.length; i++) {
			//     for (var j:int = 0; j < arr[i].length; j++) {
			//         blockArr[i][j] = arr[i][j];
			//     }
			// }
			
			// arr = [
			// 	[1, 2, 1, 0, 1, 2, 1],
			// 	[1, 2, 1, 0, 1, 2, 1],
			// 	[1, 2, 1, 0, 1]
			// 			[1],
			// 	[0, 2]
			// ];
			BlockModel.ins.mapArr = arr;
			blockView.update();
		}
		
		/** 测试模式启动 */
		public static function useTest():void {
			Laya.stage.once(Event.KEY_DOWN, null, onKeyDown);
			
			function onKeyDown(evt:Event):void {
				switch (evt.keyCode) {
					case Keyboard.C:
						// customBlock();
						break;
					case Keyboard.R:
						// randomClick();
						break;
					case Keyboard.S:
						// showBlockMap();
						break;
					case Keyboard.ESCAPE:
						useDebugTool();
						break;
					default:
						break;
				}
				
				Laya.stage.once(Event.KEY_DOWN, null, onKeyDown);
			}
		}
		
		/**作弊模式 */
		public static function useCheat():void {
			// dosomething
			var callBack:Function = function ():void {
				if (GameConfig.IS_DEBUG) {
					GameConfig.IS_DEBUG = false;
					EventCenter.send(EventType.OPEN_TEXT_TIP_VIEW, ["关闭作弊模式"]);
				} else {
					GameConfig.IS_DEBUG = true;
					EventCenter.send(EventType.OPEN_TEXT_TIP_VIEW, ["开启作弊模式"]);
				}
				
			};
			
			var up:int = Keyboard.UP;
			var down:int = Keyboard.DOWN;
			var left:int = Keyboard.LEFT;
			var right:int = Keyboard.RIGHT;
			var a:int = Keyboard.A;
			var b:int = Keyboard.B;
			var cheatArr:Array = [up, up, down, down, left, right, left, right, b, a, b, a];
			var inputArr:Array = [];
			Laya.stage.on(Event.KEY_UP, null, function (e:Event):void {
				var len:int = inputArr.length;
				var targetCode:int = cheatArr[len];
				if (e.keyCode == targetCode) {
					if (len + 1 == cheatArr.length) {
						// dosomething
						callBack();
						
						inputArr.length = 0;
						return;
					}
					inputArr.push(e.keyCode);
				} else {
					inputArr.length = 0;
				}
			});
		}
		
		/** 使用调试工具 */
		public static function useDebugPanel(bool:Boolean = true):void {
			DebugPanel.init(bool);
		}
		
		public static function useDebugTool():void {
			DebugTool.init();
		}
		
		public static function uiTest():void {
			// addWhiteBg();
			
			// 测试centerX
			// var comp:Component = new Component;
			// comp.size(200, 200);
			// comp.graphics.drawRect(0, 0, 200, 200, '#00FF00');
			// comp.centerX = 0;
			// comp.centerY = 0;
			// Laya.stage.addChild(comp);
			
		}
		
		public static function useEditMode():void {
			addWhiteBg();
			// todo 考虑成本挺大的，算了
		}
		
		public static function drawBound(obj:Sprite):void {
			if (!obj instanceof Sprite) return;
			obj.graphics.clear();
			obj.graphics.drawRect(0, 0, obj.width, obj.height, undefined, '#FF0000', 3);
		}
		
		public static function log(str:*):void {
			Log.enable();
			Log.print(str.toString());
		}
		
		public function TestCenter() {
			/**
			 * 地图实现
			 * 由于每个小格子都想添加事件，是否用坐标判断
			 * 但是每个小格子都想做动画的话，应该是每个格子都是一个显示对象了，我们也想取到它
			 * 格子是属于显示方面的，但是格子数量不确定，应该写一个pool
			 * 不过pool是否使用laya内置的呢，key值不好把握
			 * 统一管理的话，可以减少代码量
			 */
			
			/**
			 * 涉及对象的问题，是否需要经常创建
			 * lastArr 和 nowArr进行比较
			 * 对比出需要进行修改的地方，其他地方不需要刷新
			 * 刷新的地方若有东西，采取换皮方式，skin之类的
			 * 不过刷新也只是数值，应该赋值color没有关系吧
			 */
		}
	}
}

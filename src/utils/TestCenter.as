package utils {
    import config.GameConfig;
    
    import core.GameLayer;
    
    import laya.debug.DebugPanel;
    import laya.debug.DebugTool;
    import laya.display.Sprite;
    import laya.events.Event;
    import laya.events.Keyboard;
    
    import module.block.BlockConst;
    import module.block.BlockModel;
    import module.block.BlockView;
    
    public class TestCenter {

        /** 静态变量，可以随意访问需要的东西 */
        public static var someThing:*;

        /** 测试方法，注意删除 */
        public static function test():void {
            // 测试enterView
            // Laya.loader.load('res/atlas/resources.atlas', Handler.create(null, onComplete))
            // function onComplete():void {
            //     var t:EnterView = new EnterView;
            //     Laya.stage.addChild(t);
            // }
        }

        /** 添加白色挡板 */
        private static function addWhiteBg():Sprite {
            var sp:Sprite = new Sprite;
            sp.graphics.drawRect(0, 0, Laya.stage.desginWidth, Laya.stage.desginHeight, '#FFF');
            Laya.stage.addChild(sp);
            return sp;
        };
        
        /** 随机填充地图 */
        public static function showBlockMap():void {
            var blockView:BlockView = new BlockView;
            GameLayer.ins.mainLayer.removeChildren();
            GameLayer.ins.mainLayer.addChild(blockView);
            RandomUtils.fulfillArr(BlockModel.ins.mapArr, [0, 1, 2]);
            blockView.update();
        }
        
        /** 测试地图随机点击 */
        public static function randomClick():void {
            var blockView:BlockView = new BlockView;
            GameLayer.ins.mainLayer.removeChildren();
            GameLayer.ins.mainLayer.addChild(blockView);
            BlockModel.ins.randomMap([BlockConst.NONE, BlockConst.WHITE_BLOCK]);
            Laya.timer.clear(null, onLoop);
            Laya.timer.loop(1000, null, onLoop);
            function onLoop():void{
                BlockModel.ins.randomSwitch();
                blockView.update();
            }
        }
        
        /** 自由配置砖块 */
        public static function customBlock():void {
            var blockView:BlockView = new BlockView;
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


            arr = [
                [1,2,1,0,1,2,1],
                [1,2,1,0,1,2,1],
                [1,2,1,0,1]
                [1],
                [0,2]
            ]
            BlockModel.ins.mapArr = arr;
            blockView.update();
        }
        
        /** 测试模式启动 */
        public static function useTest():void {
            Laya.stage.once(Event.KEY_DOWN, null, onKeyDown);
            
            function onKeyDown(evt:Event):void {
                switch (evt.keyCode) {
                    case Keyboard.C:
                        customBlock();
                        break;
                    case Keyboard.R:
                        randomClick();
                        break;
                    case Keyboard.S:
                        showBlockMap();
                        break;
                    default:
                        break;
                }
    
                Laya.stage.once(Event.KEY_DOWN, null, onKeyDown);
            }
        }
        
        /** 使用调试工具 */
        public static function useDebugPanel():void {
            DebugPanel.init();
        }
        
        public static function useDebugTool():void {
            DebugTool.init();
        }

        public static function uiTest():void{
            // addWhiteBg();

            // 测试centerX
            // var comp:Component = new Component;
            // comp.size(200, 200);
            // comp.graphics.drawRect(0, 0, 200, 200, '#00FF00');
            // comp.centerX = 0;
            // comp.centerY = 0;
            // Laya.stage.addChild(comp);

        };
        
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

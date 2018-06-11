package module.block {
    import config.GameConfig;
    
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
            ins = this;
        }
        
        private var imgDic:Dictionary = new Dictionary; // key:Image, value:Point
        private var curArr:Array;
        
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
            curArr = BlockModel.ins.mapArr;
            
            /*****************旧代码******************/
            // var size:int = GameConfig.BLOCK_SIZE;// 一行w_num个，size * n = width;
            // // 由于数据源可能改变，这里需要刷新宽高
            // height = size * curArr.length;
            // width = size * BlockModel.ins.MaxRow;
            /*****************新代码******************/
            var row:int = curArr.length;
            var col:int = BlockModel.ins.MaxRow;
            var size:int = width / col;
            /*****************end******************/
            for (var i:int = 0, iLen:int = curArr.length; i < iLen; i++) {
                for (var j:int = 0; j < curArr[i].length; j++) {
                    if (curArr[i][j] == BlockConst.NONE) continue;
                    
                    // 初始化一个img
                    var img:Image = Pool.getItemByClass("Image", Image);
                    img.size(size, size);
                    img.mouseEnabled = true;
                    img.pivot(size / 2, size / 2);
                    img.mouseEnabled = true;
                    
                    // 初始化行列
                    var point:Point = Pool.getItemByClass("Point", Point);
                    point.x = i;
                    point.y = j;
                    imgDic.set(img, point);
                    
                    // 分配img
                    switch (curArr[i][j]) {
                        case BlockConst.RED_BLOCK:
                            img.pos(j * size + size / 2, i * size + size / 2);
                            img.skin = 'resources/block1.png';
                            addChild(img);
                            break;
                        case BlockConst.WHITE_BLOCK:
                            img.pos(j * size + size / 2, i * size + size / 2);
                            img.skin = 'resources/block2.png';
                            addChild(img);
                            break;
                    }
                }
            }
        }
        
        // TODO 暂时未使用 有待于逻辑优化，img不一定每次都要回收
        public function update2():void {
            // 遍历地图arr，如果有旧arr
            // 如果空转有，对象池取出
            // 如果有转空，recover
            // 如果无变化，正常赋值皮肤
            // 如果没有旧arr,直接当无转有处理
            
            var arr:Array = BlockModel.ins.mapArr;
            for (var i:int = 0, iLen:int = arr.length; i < iLen; i++) {
                for (var j:int = 0; j < arr[i].length; j++) {
                    if (curArr) {
                    
                    }
                }
            }
        }
        
        /**点击事件 */
        private function onClick(evt:Event):void {
            var index:int = imgDic.keys.indexOf(evt.target);
            if (index < 0) return;
            var target:Image = imgDic.keys[index];
            var point:Point = imgDic.values[index];
            
            Tween.to(target, {scaleX: 0.65, scaleY: 0.65}, 100, Ease.linearNone, Handler.create(null, function ():void {
                Tween.to(target, {scaleX: 1, scaleY: 1}, 100, Ease.linearNone, Handler.create(null, function ():void {
                    var row:int = point.x;
                    var col:int = point.y;
                    BlockModel.ins.switchPoint(row, col);
                    update();
                    if (BlockModel.ins.isWin()) {
                        // todo 胜利
                        EventCenter.send(EventType.OPEN_WIN_VIEW);
                        off(Event.CLICK, this, onClick);
                    }
                }));
            }));
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

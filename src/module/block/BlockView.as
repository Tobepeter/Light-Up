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
    
    /**
     * 砖块地图界面
     */
    public class BlockView extends Component {
        public static var ins:BlockView;
        
        public function BlockView() {
            width = GameConfig.BLOCK_SIZE * GameConfig.H_BLCOK;
            height = GameConfig.BLOCK_SIZE * GameConfig.V_BLOCK;
            update();
            on(Event.CLICK, this, onClick);
            ins = this;
        }
        
        private var imgDic:Dictionary = new Dictionary; // key:Image, value:Point
        private var curArr:Array;
    
        override public function set width(value:Number):void {
            if (width == value) return;
            super.width = value;
            updatePos();
        }
    
        override public function set height(value:Number):void {
            if (height == value) return;
            super.height = value;
            updatePos();
        }
        
        /**更新界面 */
        public function update():void {
            recoverBlock();
            curArr = BlockModel.ins.mapArr;
            var size:int = GameConfig.BLOCK_SIZE;
            height = size * curArr.length;
            width = size * BlockModel.ins.MaxRow;
            for (var i:int = 0, iLen:int = curArr.length; i < iLen; i++) {
                for (var j:int = 0; j < curArr[i].length; j++) {
                    if (curArr[i][j] == BlockConst.NONE) continue;
    
                    var img:Image = Pool.getItemByClass("Image", Image);
                    img.size(size, size);
                    img.mouseEnabled = true;
                    img.pivot(size / 2, size / 2);
                    img.mouseEnabled = true;
    
                    var point:Point = Pool.getItemByClass("Point", Point);
                    point.x = i;
                    point.y = j;
                    imgDic.set(img, point);
    
                    // 分配img
                    switch (curArr[i][j]) {
                        case BlockConst.RED_BLOCK:
                            img.pos(j * size + size / 2, i * size + size / 2);
                            // img.graphics.drawRect(0, 0, size, size, "#FF0000", "#000000", 1);
                            // img.skin = './res/block1.png';
                            img.skin = 'resources/block1.png';
                            addChild(img);
                            break;
                        case BlockConst.WHITE_BLOCK:
                            img.pos(j * size + size / 2, i * size + size / 2);
                            // img.graphics.drawRect(0, 0, size, size, "#00FF00", "#000000", 1);
                            // img.skin = './res/block2.png';
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
                        console.log('you win');
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
        };
    
        private function updatePos():void {
            pivot(width / 2, height / 2);
            pos(stage.width / 2, stage.height / 2);
        
            // 使用一个边框
            graphics.clear();
            graphics.drawRect(0, 0, width, height, null, '#000000', 2);
        }
    }
}

package module.block {
    import config.GameConfig;
    
    import laya.display.Node;
    import laya.display.Sprite;
    import laya.events.Event;
    import laya.maths.Point;
    import laya.ui.Component;
    import laya.ui.Image;
    import laya.utils.Pool;
    import laya.utils.Tween;
    import laya.utils.Dictionary;
    import laya.utils.Handler;
    import laya.utils.Ease;
    
    /**
     * 砖块地图界面
     */
    public class BlockView extends Component {
        
        public function BlockView() {
            // todo
            // debugger;
            width = GameConfig.BLOCK_SIZE * GameConfig.H_BLCOK;
            height = GameConfig.BLOCK_SIZE * GameConfig.V_BLOCK;
            pivot(width / 2, height / 2);
            pos(stage.width / 2, stage.height / 2);
            graphics.drawRect(0, 0, width, height, null, '#000000', 2);
            // centerX = 0;
            // centerY = 0;
        }
        
        override protected function createChildren():void {
            update();
            // on(Event.CLICK, this, onClick);
        }
        
        private var imgDic:Dictionary;
        public function update():void {
            recoverBlock();
            imgDic = new Dictionary;
            var arr:Array = BlockModel.ins.mapArr;
            var size:int = GameConfig.BLOCK_SIZE;
            for (var i:int = 0; i < arr.length; i++) {
                for (var j:int = 0; j < arr[i].length; j++) {
                    if (arr[i][j] == BlockConst.NONE) continue;
                    var img:Image = Pool.getItemByClass("Image", Image);
                    img.size(size, size);
                    img.mouseEnabled = true;
                    img.pivot(size/2, size/2);
                    img.mouseEnabled = true;
                    var point:Point = Pool.getItemByClass("Point", Point);
                    point.x = i;
                    point.y = j;
                    imgDic.set(img, point);
                    img.on(Event.CLICK, this, onClick);
                    switch (arr[i][j]) {
                        case BlockConst.RED_BLOCK:
                            // img.pos(j * size, i * size);
                            img.pos(j * size + size/2, i * size + size/2);
                            //img.graphics.drawRect(0, 0, size, size, "#FF0000", "#000000", 1);
                            img.skin = './res/block1.png';
                            addChild(img);
                            break;
                        case BlockConst.WHITE_BLOCK:
                            // img.pos(j * size, i * size);
                            img.pos(j * size + size/2, i * size + size/2);
                            img.skin = './res/block2.png';
                            //img.graphics.drawRect(0, 0, size, size, "#00FF00", "#000000", 1);
                            addChild(img);
                            break;
                    }
                }
            }
        }
        
        private function onClick(e:Event):void {
            if (!e.target instanceof Image) return;
            // var point:Point = Pool.getItemByClass("Point", Point);
            // point.x = e.stageX;
            // point.y = e.stageY;
            // fromParentPoint(point);
            var point:Point = imgDic.get(e.target);
            if(!point) return;
            
            // todo
            // e.target.x+=10;
            // e.target.scaleX *= 0.95;
            var _this:Object = this;
            var _target:Object = e.target;
            Tween.to(_target, {scaleX:0.5, scaleY:0.5}, 100, Ease.linearNone, Handler.create(null, function():void{
                 Tween.to(_target, {scaleX:1, scaleY:1}, 100, Ease.linearNone, Handler.create(_this, function():void{
                     switchPoint();
                 }));
            }));

            function switchPoint():void {
                // var size:int = GameConfig.BLOCK_SIZE;
                // var line:int = point.y / size >> 0;
                // var row:int = point.x / size >> 0;
                // Pool.recover("Point", point);
                var row:int = point.x;
                var col:int = point.y;
                BlockModel.ins.switchPoint(row, col);
                update();
            }

            // Laya.timer.frameLoop(100, null, onLoop);
            // var flag:Boolean = true;
            // function onLoop():void{
            //     if(flag) {
            //          e.target.scaleX *= 0.95;
            //          e.target.scaleY *= 0.95;
            //          return;
            //     }
            //     if(!flag) flag = false;
            //     if(!flag) {
            //          e.target.scaleX /= 0.95;
            //          e.target.scaleY /= 0.95;
            //     }
            //     if(e.target.scaleX >=1 || e.target.scaleY >=1) {
            //         Laya.timer.clear(null, onLoop);
            //         switchPoint();
            //     }
            // }

            // switchPoint();
        }
        
        private function recoverBlock():void {
            for (var i:int = 0, iLen:int = numChildren; i < iLen; i++) {
                var child:Node = getChildAt(i);
                if (child is Image) {
                    //(child as Image).graphics.clear();
                    //removeChild(child);
                    Pool.recover("Point",imgDic.get(child));
                    Pool.recover("Image", child);
                    // imgDic.clear();
                }
            }

            // todo 可能不止image
            removeChildren();
        }
    }
}

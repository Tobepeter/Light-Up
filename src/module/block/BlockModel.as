package module.block {
    import config.GameConfig;
    
    import utils.RandomUtils;
    
    public class BlockModel {
        private static var _ins:BlockModel;
        
        public static function get ins():BlockModel {
            return _ins ||= new BlockModel;
        }
        
        public function BlockModel() {
            if (_ins) throw('use function get ins()!!!');
            init();
        }
        
        private var _mapArr:Array;
        public function get mapArr():Array {
            return _mapArr;
        }
        public function set mapArr(arr:Array):void{
            _mapArr = arr;
        }

        public function get MaxRow():int{
            var result:int = 0;
            for(var i:int=0,iLen:int = _mapArr.length;i<iLen;i++){
                if(result < _mapArr[i].length) result = _mapArr[i].length;
            }
            return result;
        }
        
        /** 地图周围换色 */
        public function switchPoint(row:int, col:int):void {
            if (_mapArr[row] == undefined || _mapArr[row][col] == undefined) return;
            if (_mapArr[row][col] == BlockConst.NONE) return;
            for (var k:int = -1; k < 2; k++) {
                for (var l:int = -1; l < 2; l++) {
                    if (k && l != 0) continue;
                    if (_mapArr[row + k] && _mapArr[row + k][col + l] != undefined && _mapArr[row + k][col + l] != BlockConst.NONE) {
                        _mapArr[row + k][col + l] = (_mapArr[row + k][col + l] == BlockConst.RED_BLOCK) ? BlockConst.WHITE_BLOCK : BlockConst.RED_BLOCK;
                    }
                }
            }
        }
        
        /** 随机地图 */
        public function randomMap(fillArr:Array):void {
            fillArr == undefined && (fillArr = [BlockConst.NONE, BlockConst.RED_BLOCK, BlockConst.WHITE_BLOCK]);
            RandomUtils.fulfillArr(_mapArr, fillArr);
        }
        
        /** 重置地图 */
        public function resetMap(blockType:int = BlockConst.WHITE_BLOCK):void {
            for (var i:int = 0; i < _mapArr.length; i++) {
                for (var j:int = 0; j < _mapArr.length; j++) {
                    _mapArr[i][j] = blockType;
                }
            }
        }
        
        /**随机点击 */
        public function randomSwitch():void {
            var maxSearch:int = 5;
            var row:int;
            var col:int;
            
            function search():void {
                row = RandomUtils.createInt(_mapArr.length);
                col = RandomUtils.createInt(_mapArr[row].length);
                if (maxSearch--) return;
                if (_mapArr[row][col] == BlockConst.NONE) {
                    search();
                }
            }
            
            search();
            switchPoint(row, col);
        }
        
        /** 生成能赢的地图 */
        public function generateMap():void {
            randomMap([BlockConst.NONE, BlockConst.RED_BLOCK]);
            var times:int = 20;
            while (times--) {
                randomSwitch();
            }
        }
        
        private function init():void {
            _mapArr = [];
            for (var i:int = 0; i < GameConfig.V_BLOCK; i++) {
                var arr:Array = [];
                _mapArr.push(arr);
                for (var j:int = 0; j < GameConfig.H_BLCOK; j++) {
                    _mapArr[i].push(0);
                }
            }
    
            // todo
            debugger;
            generateMap();
        }
    }
}

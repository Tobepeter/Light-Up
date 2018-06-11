package module.levelselect {
    public class LevelSelectModel {
        private static var _ins:LevelSelectModel;
        
        public static function get ins():LevelSelectModel {
            return _ins ||= new LevelSelectModel;
            
        }
        
        public function LevelSelectModel() {
            if (_ins) throw("use function get ins()!!!");
            init();
        }
        
        public var leverSource:Array;
    
        public const maxLevel:int = 12;
        public const openSkin:String = 'resources/levelmode_button_1.png';
        public const closeSkin:String = 'resources/levelmode_button_2.png';
    
        private var _curLevel:int;
    
        public function get curLevel():int {
            return _curLevel;
        }
    
        public function set curLevel(value:int):void {
            _curLevel = value;
            updateSkin();
        }
    
        /**开启下一关 */
        public function nextLevel():void {
            if (_curLevel == maxLevel) return;
            curLevel = curLevel + 1;
        }
        
        private function init():void {
            leverSource = [];
            //  3*4
            for (var i:int = 0; i < 12; i++) {
                var obj:Object = {};
                obj.itemBg = closeSkin;
                obj.itemLb = i + 1 + '';
                leverSource.push(obj);
            }
    
            // 第一关开启
            curLevel = 1;
            leverSource[_curLevel - 1].itemBg = openSkin;
        }
    
        private function updateSkin():void {
            for (var i:int = 0, iLen:int = leverSource.length; i < iLen; i++) {
                if (i + 1 <= curLevel) {
                    leverSource[i].itemBg = openSkin;
                } else {
                    leverSource[i].itemBg = closeSkin;
                }
            }
        }
    }
}

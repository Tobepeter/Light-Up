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
        
        private function init():void {
            leverSource = [];
            //  3*4
            var openSkin:String = 'resources/levelmode_button_1.png';
            var closeSkin:String = 'resources/levelmode_button_2.png';
            for (var i:int = 0; i < 12; i++) {
                var obj:Object = {};
                obj.itemBg = closeSkin;
                obj.itemLb = i + 1 + '';
                leverSource.push(obj);
            }
            // 第一关开启
            leverSource[0].itemBg = openSkin;
        }
        
    }
}

package module.levelselect {
    import ui.LevelSelectViewUI;
    
    public class LevelSelectView extends LevelSelectViewUI {
        public function LevelSelectView() {
        
        }
        
        override protected function createChildren():void {
            super.createChildren();
            
            // 3*4关卡
            var arr:Array = [];
            for (var i:int = 0; i < 12; i++) {
                var obj:Object = {};
                obj.itemBg = 'resources/levelmode_button_1.png';
                obj.itemLb = i + 1 + '';
                arr.push(obj);
            }
            
            levelList.dataSource = arr;
        }
    }
}

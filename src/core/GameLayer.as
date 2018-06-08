package core {
    import laya.display.Sprite;
    
    public class GameLayer {
        private static var _ins:GameLayer;
        public function GameLayer() {
            if(_ins) throw('use function get ins()!!!');
            init();
        }
        
        public var mainLayer: Sprite = new Sprite;
        public var windowLayer: Sprite = new Sprite;
        public var popLayer:Sprite = new Sprite;
        public var topLayer:Sprite = new Sprite;
        
        private function init():void {
            Laya.stage.addChild(mainLayer);
            Laya.stage.addChild(windowLayer);
            Laya.stage.addChild(popLayer);
            Laya.stage.addChild(topLayer);
        }
    
        public static function get ins():GameLayer {
            return _ins ||= new GameLayer;
        }
    }
}

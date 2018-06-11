package module.win {
    import core.GameLayer;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    public class WinModule {
        private static var _ins:WinModule;
        
        public static function get ins():WinModule {
            return _ins ||= new WinModule;
        }
        
        public function WinModule() {
            if (_ins) throw("use function get ins()!!!");
        }
        
        private var winView:WinView;
        
        public function addListener():void {
            EventCenter.add(EventType.OPEN_WIN_VIEW, this, onOpenWinDlg);
            EventCenter.add(EventType.CLOSE_WIN_VIEW, this, onCloseWinDlg);
        }
        
        private function onCloseWinDlg():void {
            if (winView) {
                GameLayer.ins.popLayer.removeChild(winView);
                winView = null;
            }
        }
        
        private function onOpenWinDlg():void {
            winView = new WinView;
            GameLayer.ins.popLayer.addChild(winView);
        }
    }
}

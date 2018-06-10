package module.enter {
    import laya.events.Event;
    
    import module.event.EventCenter;
    import module.event.EventType;
    
    import ui.EnterVIewUI;
    
    public class EnterView extends EnterVIewUI {
        public function EnterView() {
            on(Event.CLICK, this, onclick);
        }
        
        private function onclick(evt:Event):void {
            switch (evt.target) {
                case btnLevelMode:
                    EventCenter.send(EventType.CLOSE_ENTER_VIEW);
                    EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
                    break;
                case btnEndlessMode:
                    EventCenter.send(EventType.CLOSE_ENTER_VIEW);
                    EventCenter.send(EventType.OPEN_LEVEL_SELECT_VIEW);
                    break;
                default:
                    break;
            }
        }
    }
    
}

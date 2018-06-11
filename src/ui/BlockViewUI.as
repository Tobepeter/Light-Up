/**Created by the LayaAirIDE,do not modify.*/
package ui {
    import laya.ui.*;
    
    public class BlockViewUI extends View {
        public static var uiView:Object = /*[STATIC SAFE]*/{
            "type": "View",
            "props": {"width": 678, "height": 1200},
            "child": [{
                "type": "Rect",
                "props": {"y": 0, "x": 0, "width": 678, "lineWidth": 1, "height": 1200, "fillColor": "#fff"}
            }, {
                "type": "Box",
                "props": {"y": 313, "x": 67, "width": 550, "var": "blockBox", "height": 550}
            }, {
                "type": "Button",
                "props": {
                    "y": 1060,
                    "x": 411,
                    "var": "backBtn",
                    "stateNum": 1,
                    "skin": "resources/button.png",
                    "labelSize": 45,
                    "label": "返回"
                }
            }]
        };
        public var blockBox:Box;
        public var backBtn:Button;
        
        override protected function createChildren():void {
            super.createChildren();
            createView(uiView);
            
        }
        
    }
}

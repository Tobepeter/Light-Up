/**Created by the LayaAirIDE,do not modify.*/
package ui {
    import laya.ui.*;
    
    public class EnterVIewUI extends View {
        public static var uiView:Object = /*[STATIC SAFE]*/{
            "type": "View",
            "props": {"width": 678, "height": 1200},
            "child": [{
                "type": "Rect",
                "props": {"y": 0, "x": 0, "width": 678, "lineWidth": 1, "height": 1200, "fillColor": "#fff"}
            }, {
                "type": "Image",
                "props": {"y": 0, "x": 0, "width": 678, "skin": "resources/background.png", "height": 1200}
            }, {"type": "Image", "props": {"y": 107, "x": 86, "skin": "resources/title.png"}}, {
                "type": "Button",
                "props": {
                    "y": 951,
                    "x": 92,
                    "var": "btnLevelMode",
                    "stateNum": 1,
                    "skin": "resources/button.png",
                    "labelSize": 45,
                    "label": "关卡模式"
                }
            }, {
                "type": "Button",
                "props": {
                    "y": 951,
                    "x": 382,
                    "var": "btnEndlessMode",
                    "stateNum": 1,
                    "skin": "resources/button.png",
                    "labelSize": 45,
                    "label": "无尽模式"
                }
            }]
        };
		public var btnLevelMode:Button;
		public var btnEndlessMode:Button;

		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}

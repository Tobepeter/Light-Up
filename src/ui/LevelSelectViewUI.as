/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class LevelSelectViewUI extends View {
		public var levelList:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"mouseEnabled":false,"height":1200},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":678,"lineWidth":1,"height":1200,"fillColor":"#fff"}},{"type":"Image","props":{"y":4,"x":2,"width":678,"skin":"resources/background.png","height":1200,"height ":1200}},{"type":"List","props":{"y":257,"x":33,"width":612,"var":"levelList","spaceY":50,"spaceX":50,"height":815,"dataSource":"[1,2,3]"},"child":[{"type":"Box","props":{"y":4,"renderType":"render"},"child":[{"type":"Image","props":{"x":10,"skin":"resources/levelmode_button_1.png","name":"itemBg"}},{"type":"Label","props":{"y":28,"width":158,"text":"1","name":"itemLb","fontSize":85,"font":"Microsoft YaHei","color":"#000000","align":"center"}}]}]},{"type":"Button","props":{"y":71,"x":222,"stateNum":1,"skin":"resources/button.png","labelSize":45,"label":"关卡选择"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class LevelSelectItemUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":158,"height":158},"child":[{"type":"Box","props":{"y":0,"x":-10},"child":[{"type":"Image","props":{"x":10,"skin":"resources/levelmode_button_1.png"}},{"type":"Label","props":{"y":28,"width":158,"text":"1","fontSize":85,"font":"Microsoft YaHei","color":"#000000","align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
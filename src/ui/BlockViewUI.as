/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BlockViewUI extends View {
		public var blockBox:Box;
		public var backBtn:Button;
		public var ligthBulb:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"height":1200},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":678,"lineWidth":1,"height":1200,"fillColor":"#fff"}},{"type":"Box","props":{"y":313,"x":52,"width":573,"var":"blockBox","height":573}},{"type":"Button","props":{"y":48,"x":520,"width":104,"var":"backBtn","stateNum":1,"skin":"resources/button2_close.png","labelSize":45,"height":104}},{"type":"Image","props":{"y":871,"x":471,"var":"ligthBulb","skin":"resources/targetlight_dark.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
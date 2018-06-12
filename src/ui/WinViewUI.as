/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class WinViewUI extends View {
		public var nextBtn:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"height":1200},"child":[{"type":"Sprite","props":{"alpha":0.9},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":678,"lineWidth":1,"height":1200,"fillColor":"#000","alpha":0.7}}]},{"type":"Image","props":{"y":291,"x":59,"width":578,"skin":"resources/win.png","height":567}},{"type":"Image","props":{"y":707,"x":192,"var":"nextBtn","skin":"resources/win_button.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
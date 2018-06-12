/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class EnterAniViewUI extends View {
		public var imgAni:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"height":1200},"child":[{"type":"Image","props":{"y":519,"x":84,"width":510,"var":"imgAni","skin":"resources/enter_anim_1.png","height":176}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
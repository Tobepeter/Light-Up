/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class EnterViewUI extends View {
		public var btnLevelMode:Button;
		public var btnEndlessMode:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"height":1200},"child":[{"type":"Rect","props":{"width":678,"lineWidth":0,"height":1200,"fillColor":"#fff"}},{"type":"Image","props":{"y":0,"x":0,"width":678,"skin":"resources/background.png","height":1200,"height ":1200}},{"type":"Image","props":{"y":107,"x":98,"skin":"resources/title.png"}},{"type":"Button","props":{"y":961,"x":92,"var":"btnLevelMode","stateNum":1,"skin":"resources/button.png","labelSize":45,"labelColors":"#595959","labelBold":true,"label":"关卡模式"}},{"type":"Button","props":{"y":961,"x":382,"var":"btnEndlessMode","stateNum":1,"skin":"resources/button.png","labelSize":45,"labelColors":"#595959","labelBold":true,"label":"无尽模式"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
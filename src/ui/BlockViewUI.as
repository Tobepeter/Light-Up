/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BlockViewUI extends View {
		public var backBtn:Button;
		public var imgPCB:Image;
		public var ligthBulb:Image;
		public var imgPower:Image;
		public var blockBox:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"height":1200},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":678,"lineWidth":1,"height":1200,"fillColor":"#fff"}},{"type":"Button","props":{"y":48,"x":520,"width":104,"var":"backBtn","stateNum":1,"skin":"resources/button2_close.png","labelSize":45,"height":104}},{"type":"Image","props":{"y":195,"x":75,"width":517,"var":"imgPCB","skin":"resources/background_pcb_2_line.png","height":894}},{"type":"Image","props":{"y":1012,"x":475,"var":"ligthBulb","skin":"resources/light_1.png"}},{"type":"Image","props":{"y":94,"x":18,"var":"imgPower","skin":"resources/power1.png","mouseThrough":true}},{"type":"Box","props":{"y":343,"x":98,"width":482,"var":"blockBox","height":578}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
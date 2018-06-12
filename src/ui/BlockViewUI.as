/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BlockViewUI extends View {
		public var backBtn:Button;
		public var imgPCB:Image;
		public var blockBox:Box;
		public var powersmall1:Image;
		public var powersmall2:Image;
		public var powersmall3:Image;
		public var ligthBulb:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":678,"height":1200},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":678,"lineWidth":1,"height":1200,"fillColor":"#fff"}},{"type":"Button","props":{"y":46,"x":525,"width":104,"var":"backBtn","stateNum":1,"skin":"resources/button2_close.png","labelSize":45,"height":104}},{"type":"Image","props":{"y":261,"x":68,"width":542,"var":"imgPCB","skin":"resources/background_pcb_1.png","height":719}},{"type":"Box","props":{"y":330,"x":125,"width":433,"var":"blockBox","height":582}},{"type":"Box","props":{"y":126,"x":20},"child":[{"type":"Image","props":{"skin":"resources/powerbody.png","mouseThrough":true}},{"type":"Image","props":{"y":86,"x":21,"skin":"resources/electricline_1.png"}},{"type":"Image","props":{"y":43,"x":119,"var":"powersmall1","skin":"resources/powersmall_1.png"}},{"type":"Image","props":{"y":75,"x":101,"var":"powersmall2","skin":"resources/powersmall_2.png"}},{"type":"Image","props":{"y":94,"x":68,"var":"powersmall3","skin":"resources/powersmall_3.png"}}]},{"type":"Box","props":{"y":913,"x":506},"child":[{"type":"Image","props":{"skin":"resources/electricline_2.png"}},{"type":"Image","props":{"y":87,"x":54,"var":"ligthBulb","skin":"resources/light_1.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
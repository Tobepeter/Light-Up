package module.texttip {
	import laya.ui.Component;
	import laya.ui.Label;
	import laya.utils.Pool;
	
	/**
	 * 飘字
	 */
	public class TipItem extends Component {
		private var lb:Label;
		
		public function TipItem(str:String = '') {
			lb = Pool.getItemByClass('Label', Label);
			lb.fontSize = 60;
			addChild(lb);
			
			text = str;
		}
		
		public function get text():String {
			return lb.text;
		}
		
		public function set text(value:String):void {
			lb.text = value;
			width = lb.width;
			height = lb.height;
			graphics.clear();
			graphics.drawRect(0, 0, width, height, '#FFF');
			pivot(width / 2, height / 2);
		}
		
		public function recover():void {
			Pool.recover('Label', lb);
		}
	}
}

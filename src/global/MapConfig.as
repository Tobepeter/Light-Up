package global {
	import laya.debug.tools.ObjectTools;
	import laya.utils.Dictionary;
	import laya.utils.Handler;
	
	public class MapConfig {
		
		private static var _mapDic:Dictionary;
		
		public static function load(handler:Handler = null):void {
			if (_mapDic) return;
			_mapDic = new Dictionary;
			
			// 第一章有12关
			var i:int, iLen:int = 12;
			var urls:Array = [];
			for (i = 1; i <= iLen; i++) {
				urls.push('config/map1_' + i + '.json'); //todo 这个是否需要全局存下来
			}
			Laya.loader.load(urls, Handler.create(null, function ():void {
				for (var j:int = 0, jLen:int = urls.length; j < jLen; j++) {
					var obj:Object = Laya.loader.getRes(urls[j]);
					_mapDic.set(obj.id, obj.arr);
				}
				handler && handler.run();
			}));
		}
		
		 public static function get mapDic():Dictionary {
		 	// 注意这是一个对象，会引起改变的
		 	return _mapDic;
		 }
		
		public static function getArrById(id:String):Array {
			var arr:Array = _mapDic.get(id);        // 这里非常坑，这里的arr不是基本数据类型，是数组对象
			return ObjectTools.copyObjFast(arr) as Array;
		}
	}
}

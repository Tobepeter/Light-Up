package module.event {
    import laya.utils.Dictionary;
    
    public class EventCenter {
        
        private static var eventDic:Dictionary = new Dictionary;
        
        /**
         * 添加事件监听
         * @desc 这里一个对象的监听，同类型事件唯一
         */
        public static function add(type:String, caller:Object, callBack:Function):void {
            var value:Object = {
                caller: caller,
                callBack: callBack
            };
            var arr:* = eventDic.get(type);
            if (arr) {
                for (var i:int = 0; i < arr.length; i++) {
                    if (arr[i].caller == caller) {
                        console.warn('事件：' + type + ' 调用于：' + caller + ' 重复监听');
                        return;
                    }
                }
                arr.push(value);
            } else {
                arr = [value];
                eventDic.set(type, arr);
            }
        }
        
        public static function remove(type:String, caller:Object, callBack:Function):void {
            var arr:* = eventDic.get(type);
            if (arr) {
                for (var i:int = 0; i < arr.length; i++) {
                    if (arr[i].caller == caller) {
                        (arr as Array).splice(i, 1);
                        return;
                    }
                }
                console.warn('事件：' + type + ' 调用于：' + caller + ' 不存在，不需移除');
            } else {
                console.warn('事件：' + type + ' 不存在，不需移除');
            }
        }
        
        public static function send(type:String, args:Array = null):void {
            // todo 这里应该不是一次性派发完全，可能存在性能问题（超过最大数下一帧派发）
            var arr:* = eventDic.get(type);
            if (arr) {
                for (var i:int = 0; i < arr.length; i++) {
                    var caller:Object = arr[i].caller;
                    var callBack:Function = arr[i].callBack;
                    callBack.apply(caller, args);
                }
            } else {
                console.warn('事件：' + type + ' 不存在监听');
            }
        }
        
        /********** 此处为get/set **********/
        public static function getDataByType(type:String):Array {
            return eventDic.get(type);
        }
    }
}

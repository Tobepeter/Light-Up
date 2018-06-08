package utils {
    public class RandomUtils {
        
        /**
         * 创造区间随机数字
         * @desc int2是取不到的
         */
        public static function createInt(int1:Number, int2:Number = 0):int {
            if (int1 == int2) return int1;
            if (int2 < int1) {
                var t:int = int1;
                int1 = int2;
                int2 = t;
            }
            var dis:Number = Math.abs(int2 - int1);
            var result:int = Math.random() * dis + int1 >> 0;
            return result;
        }
        
        /** 随机填充数组 */
        public static function fulfillArr(arr:Array, fillValue:Array = [0]):void {
            for (var i:int = 0; i < arr.length; i++) {
                if (arr[i] is Array) {
                    fulfillArr(arr[i], fillValue);
                } else {
                    var n:int = createInt(0, fillValue.length);
                    arr[i] = fillValue[n];
                }
            }
            
        }
    }
}

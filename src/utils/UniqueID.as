package utils {
    public class UniqueID {
        private static var id:int = 0;
        
        public static function getOne():int {
            return id++;
        }
    }
}

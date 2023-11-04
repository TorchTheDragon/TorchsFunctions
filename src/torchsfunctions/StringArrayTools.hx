package torchsfunctions;

using StringTools;

class StringArrayTools{
    /**
        Checks a provided value to see if it is in the provided blacklist

        @param value The value you would like to be checked
        @param blacklist The provided blacklist you would like to use to check
    **/
    public static function checkBlacklist(value:String, blacklist:Array<String>):Bool {
        var val:String = '';
        for (phrase in blacklist) {
            if (value == phrase) {trace(phrase + ' is in the blacklist'); return false; val = phrase; break;} 
        }
        trace(val + ' is not in blacklist');
        return true;
    }
}
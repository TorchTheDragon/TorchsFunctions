package torchsfunctions;

using StringTools;

class ArrayTools{
    /**
        Checks a provided value to see if it is in the provided blacklist

        @param value The value you would like to be checked
        @param blacklist The provided blacklist you would like to use to check
    **/
    public static function checkBlacklist(value:String, blacklist:Array<String>):Bool {
        for (phrase in blacklist) {
            if (value == phrase) {trace(phrase + ' is in the blacklist'); return true; break;} 
        }
        trace(value + ' is not in blacklist');
        return false;
    }
    /**
        Essentially takes a double array and only returns the first parts of it.

        Ex. [['A', "b"], ['c', "d"]] will only return as ['A', 'c']
    
        @param bigArray Just an Array with more arrays in it.
        @return An array that only has the first value of array within an array.
    **/
    public static function grabFirstVal(bigArray:Array<Array<Dynamic>>):Array<Dynamic> {
        var tempArray:Array<Dynamic> = [];
        for (item in bigArray) {
            if (Std.isOfType(item, Array)) {
                tempArray.push(item[0]);
            }
        }
        return tempArray;
    }
}
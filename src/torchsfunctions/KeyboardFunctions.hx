package torchsfunctions;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

using StringTools;

class KeyboardFunctions{
    /**
     * Just a simple function to determine which key was pressed. Good for sequential keypresses. An example of how to use this is by simply adding the value to a string in the update function.
     * 
     * Ex: 
     * ```
     * public var value:String = '';
     * override function update(elapsed:Float) {
     *      value += keypressToString(); // This will add a key to the string everytime a key is pressed
     * }
     * ```
     * @return Key that was pressed as a String
     */
    public static function keypressToString():String
    {
        var characterToAdd:String = "";
        if (FlxG.keys.justPressed.ANY) {
            final key = cast(FlxG.keys.firstJustPressed(), FlxKey);
            if (key != FlxKey.NONE){
                final i = key.toString().toUpperCase();
                characterToAdd += FlxKey.fromStringMap.get(i);
            }
        }
        return characterToAdd;
    }
}
package torchsfunctions;

import flixel.tweens.FlxEase;
import lime.system.System;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class ExtraFunctions{
    /**
    Just insert an ease name, like linear or quadOut for example, and it'll return it as an actual FlxEase value instead of a string. Useful if you have something customizable instead of perma set to a ease.

    @param easeName The ease you want the function to return

    @return FlxEase

    @author LunarCleint
    **/
    public static function stringToEase(easeName:String, ?suffix:String = "")
        return Reflect.field(FlxEase, easeName + (easeName == "linear" ? "" : suffix));
}

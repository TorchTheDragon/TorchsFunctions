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
    **/
    public static function stringToEase(easeName:String) {
        // a shitty way to convert a string to a ease but it should work for now
        var daEase:String = 'FlxEase.linear';
        for (ease in Type.getInstanceFields(FlxEase)){
            if (Type.typeof(Reflect.getProperty(FlxEase, ease)) != TFunction)
                continue;

            daEase = 'FlxEase.${ease.toLowerCase().trim()}';
            trace(daEase);

            if (daEase.substr(8, daEase.length - 1) == easeName.toLowerCase().trim()){
                // final e = Reflect.field(FlxEase, cast(daEase, FlxEase));
                final e = cast daEase;
                trace(e);
                return e;
            }
        }
        return FlxEase.linear;
    }
    /**
    This simply just restarts the current application. That's it.
    **/
    public static function restartApp()
    {
        #if cpp
        var os = Sys.systemName();
        var args = "Test.hx";
        var app = "";
        var workingdir = Sys.getCwd();

        FlxG.log.add(app);

        app = Sys.programPath();

        var result = systools.win.Tools.createProcess(app, args, workingdir, false, false);

        if (result == 0)
        {
            FlxG.log.add('Hmmmmmm....');
            System.exit(1337);
        }
        else
            throw "Failed to restart";
        #end
    }
}
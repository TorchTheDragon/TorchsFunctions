package torchsfunctions.functions;

import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
import flixel.system.FlxAssets.FlxShader;
import flixel.FlxCamera;
import flixel.FlxSprite;

// This might get moved into my functions library

class ShaderUtils {
    // I don't get why this couldn't be a ShaderFilter and had to be a BitmapFilter
    public static function applyFiltersToCams(cameras:Array<FlxCamera>, filters:Array<BitmapFilter>) {
        for (camera in cameras) {
            camera.filters = filters;
        }
    }

    public static function applyFilterToCams(cameras:Array<FlxCamera>, filter:BitmapFilter) {
        for (camera in cameras) {
            camera.filters = [filter];
        }
    }

    public static function applyShadersToCams(cameras:Array<FlxCamera>, shaders:Array<FlxShader>) {
        for (camera in cameras) {
            var filters:Array<BitmapFilter> = [];
            for (shader in shaders) {
                var tempFilter:ShaderFilter = new ShaderFilter(shader);
                filters.push(tempFilter);
            }
            camera.setFilters(filters);
        }
    }

    public static function applyShaderToCams(cameras:Array<FlxCamera>, shader:FlxShader) {
        for (camera in cameras) {
            var tempFilter:ShaderFilter = new ShaderFilter(shader);
            camera.setFilters([tempFilter]);
        }
    }

    public static function applyShaderToObjects(objects:Array<FlxSprite>, shader:FlxShader) {
        for (object in objects) {
            object.shader = shader;
        }
    }

    public static function clearFiltersOnCams(cameras:Array<FlxCamera>) {
        for (camera in cameras) {
            camera.setFilters(null);
        }
    }

    public static function clearShadersOnObjects(objects:Array<FlxSprite>) {
        for (object in objects) {
            object.shader = null;
        }
    }
}
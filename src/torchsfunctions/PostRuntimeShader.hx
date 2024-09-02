package torchsfunctions;

import flixel.addons.display.FlxRuntimeShader;
import flixel.FlxCamera;
import flixel.FlxG;
import lime.graphics.opengl.GLProgram;
import lime.utils.Log;
import openfl.display.ShaderInput;
import openfl.utils.Assets;

using StringTools;

class PostRuntimeShader extends FlxRuntimeShader {
	var defaultVertHead:String = '
	#pragma header
	varying vec2 screenCoord;';
	var defaultVertBody:String = '
	screenCoord = vec2(
        openfl_TextureCoord.x > 0.0 ? 1.0 : 0.0,
        openfl_TextureCoord.y > 0.0 ? 1.0 : 0.0
    );
	#pragma body';

	var defaultFragHead:String = '
	#pragma header

	varying vec2 screenCoord;
	uniform vec2 uScreenResolution;
	uniform vec4 uCameraBounds;

	vec2 screenToWorld(vec2 screenCoord) {
		float left = uCameraBounds.x;
		float top = uCameraBounds.y;
		float right = uCameraBounds.z;
		float bottom = uCameraBounds.w;
		vec2 scale = vec2(right - left, bottom - top);
		vec2 offset = vec2(left, top);
		return screenCoord * scale + offset;
	}

	vec2 worldToScreen(vec2 worldCoord) {
		float left = uCameraBounds.x;
		float top = uCameraBounds.y;
		float right = uCameraBounds.z;
		float bottom = uCameraBounds.w;
		vec2 scale = vec2(right - left, bottom - top);
		vec2 offset = vec2(left, top);
		return (worldCoord - offset) / scale;
	}

	vec2 bitmapCoordScale() {
		return openfl_TextureCoordv / screenCoord;
	}

	vec2 screenToBitmap(vec2 screenCoord) {
		return screenCoord * bitmapCoordScale();
	}

	vec4 sampleBitmapScreen(vec2 screenCoord) {
		return texture2D(bitmap, screenToBitmap(screenCoord));
	}

	vec4 sampleBitmapWorld(vec2 worldCoord) {
		return sampleBitmapScreen(worldToScreen(worldCoord));
	}';
	var defaultFragBody:String = '#pragma body';

    public function new(?fragmentSource:String = null, ?vertexSource:String = null) {
		if (vertexSource != null) {
			vertexSource = vertexSource.replace('#pragma header', defaultVertHead);
			vertexSource = vertexSource.replace('#pragma body', defaultVertBody);
		} else {
            vertexSource = defaultVertHead + "\nvoid main() {\n" + defaultVertBody + "\n}";
        }
		if (fragmentSource != null) {
			fragmentSource = fragmentSource.replace('#pragma header', defaultFragHead);
			fragmentSource = fragmentSource.replace('#pragma body', defaultFragBody);
		} else {
            fragmentSource = defaultFragHead + "\nvoid main() {\n" + defaultFragBody + "\n}";
        }

        super(fragmentSource, vertexSource);
		setResolution(FlxG.width, FlxG.height);
    }

	public function update(elapsed:Float) {
		// This is only here for override purposes, please incorporate this into your state's own update function.
	}

	public function setResolution(screenWidth:Float, screenHeight:Float) {
        this.setFloatArray('uScreenResolution', [screenWidth, screenHeight]);
    }

    public function updateViewInfo(screenWidth:Float, screenHeight:Float, camera:FlxCamera):Void {
        setResolution(screenWidth, screenHeight);
		this.setFloatArray('uCameraBounds', [camera.viewLeft, camera.viewTop, camera.viewRight, camera.viewBottom]);
    }

    override function __createGLProgram(vertexSource:String, fragmentSource:String):GLProgram {
        try {
            final res = super.__createGLProgram(vertexSource, fragmentSource);
            return res;
        } catch (error) {
            Log.warn(error); 
            return null;
        }
    }

    /**
	 * Modify a bitmap data parameter of the shader.
	 * @param name The name of the parameter to modify.
	 * @param value The new value to use.
	 */
	public function setBitmapData(name:String, value:openfl.display.BitmapData):Void
    {
        var prop:ShaderInput<openfl.display.BitmapData> = Reflect.field(this.data, name);
        if (prop == null)
        {
            trace('[WARN] Shader sampler2D property ${name} not found.');
            return;
        }
        prop.input = value;
    }
}
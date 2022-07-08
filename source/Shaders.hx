package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;
import openfl.filters.ShaderFilter;

class Shaders
{
    public static function toCamera(clss:FlxShader):ShaderFilter {
        return new ShaderFilter(clss);
    }
}

class Greyscale
{
    public var shader:GreyscaleShader;

    public function new() {
        shader = new GreyscaleShader();
    }
}
class GreyscaleShader extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        void main() {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
            float avg = (color.r * color.a + color.g * color.a + color.b * color.a) / 3;
            gl_FragColor = vec4(avg, avg, avg, color.a);
        }
    ')
    public function new() {
        super();
    }
}

class Sepia
{
    public var shader:SepiaShader;

    public function new() {
        shader = new SepiaShader();
    }
}
class SepiaShader extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        void main() {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);

            float rr = 0.3;
            float rg = 0.769;
            float rb = 0.189;
            float ra = 0.0;
            
            float gr = 0.3;
            float gg = 0.686;
            float gb = 0.168;
            float ga = 0.0;
            
            float br = 0.272;
            float bg = 0.534;
            float bb = 0.131;
            float ba = 0.0;
            
            float red = (rr * color.r) + (rb * color.b) + (rg * color.g) + (ra * color.a);
            float green = (gr * color.r) + (gb * color.b) + (gg * color.g) + (ga * color.a);
            float blue = (br * color.r) + (bb * color.b) + (bg * color.g) + (ba * color.a);

            gl_FragColor = vec4(red, green * 0.85, blue * 0.8, color.a);
        }
    ')
    public function new() {
        super();
    }
}

class Invert
{
    public var shader:InvertShader;

    public function new() {
        shader = new InvertShader();
    }
}
class InvertShader extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        void main() {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
            gl_FragColor = vec4((1.0 - color.r) * color.a, (1.0 - color.g) * color.a, (1.0 - color.b) * color.a, color.a);
        }
    ')
    public function new() {
        super();
    }
}

class Greenscreen
{
    public var shader:GreenscreenShader;
    public function new(color:Int) {
        shader = new GreenscreenShader();
        setColor(color);
    }

    public function setColor(value:Int = 0x00ff00) {
        var r_ = ((value >> 16 & 0xFF) / 2.55) / 100;
        var g_ = ((value >> 8 & 0xFF) / 2.55) / 100;
        var b_ = ((value & 0xFF) / 2.55) / 100;
        shader.red.value = [r_];
        shader.green.value = [g_];
        shader.blue.value = [b_];
    }
    public function setThreshold(percent:Int = 0) {
        shader.threshold.value = [percent / 100];
    }
}
class GreenscreenShader extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        uniform float threshold = 0.0;
        uniform float red = 0.0;
        uniform float green = 0.0;
        uniform float blue = 0.0;

        bool c(float source, float color) {
            return (source < color + threshold && source > color - threshold);
        }

        void main() {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
            float a = color.a;
            float r = color.r * a;
            float g = color.g * a;
            float b = color.b * a;
            if (c(r, red) && c(g, green) && c(b, blue)) {
                a = 0.0;
                r = 0.0;
                g = 0.0;
                b = 0.0;
            }
            gl_FragColor = vec4(r, g, b, a);
        }
    ')
    public function new() {
        super();
    }
}

class ChromaAberrationShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header

		uniform float rX = 0.02;
		uniform float gX = 0.0;
		uniform float bX = -0.02;
		uniform float rY = 0.0;
		uniform float gY = 0.0;
		uniform float bY = 0.0;

		void main()
		{
			vec4 col1 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(rX, rY));
			vec4 col2 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(gX, gY));
			vec4 col3 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(bX, bY));
			vec4 toUse = texture2D(bitmap, openfl_TextureCoordv);
			toUse.r = col1.r;
			toUse.g = col2.g;
			toUse.b = col3.b;

			gl_FragColor = toUse;
		}
    ')
	public function new()
	{
		super();
	}
}
class ChromaAberration
{
	public var shader:ChromaAberrationShader;

    public function new() {
        shader = new ChromaAberrationShader();
    }

    public function setX(r:Float = 0.0, g:Float = 0.0, b:Float = 0.0)
	{
		shader.rX.value = [r];
		shader.gX.value = [g];
		shader.bX.value = [b];
	}
    public function setY(r:Float = 0.0, g:Float = 0.0, b:Float = 0.0)
	{
		shader.rY.value = [r];
		shader.gY.value = [g];
		shader.bY.value = [b];
	}
}

class CrtTvShader extends FlxShader
{
    // https://www.shadertoy.com/view/Ms23DR
    // used under the the license CC Attribution Non Commercial Sharealike 
    @:glFragmentSource('
    #pragma header

    // Loosely based on postprocessing shader by inigo quilez, License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
    uniform float iTime;
    
    vec2 curve(vec2 uv)
    {
        uv = (uv - 0.5) * 2.0;
        uv *= 1.1;	
        uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
        uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);
        uv  = (uv / 2.0) + 0.5;
        uv =  uv *0.92 + 0.04;
        return uv;
    }
    void main()
    {
        vec2 q = openfl_TextureCoordv;
        vec2 uv = q;
        uv = curve( uv );
        vec3 oricol = texture2D( bitmap, vec2(q.x,q.y) ).xyz;
        vec3 col;
        float x =  sin(0.3*iTime+uv.y*21.0)*sin(0.7*iTime+uv.y*29.0)*sin(0.3+0.33*iTime+uv.y*31.0)*0.0017;
    
        col.r = texture2D(bitmap,vec2(x+uv.x+0.001,uv.y+0.001)).x+0.05;
        col.g = texture2D(bitmap,vec2(x+uv.x+0.000,uv.y-0.002)).y+0.05;
        col.b = texture2D(bitmap,vec2(x+uv.x-0.002,uv.y+0.000)).z+0.05;
        col.r += 0.08*texture2D(bitmap,0.75*vec2(x+0.025, -0.027)+vec2(uv.x+0.001,uv.y+0.001)).x;
        col.g += 0.05*texture2D(bitmap,0.75*vec2(x+-0.022, -0.02)+vec2(uv.x+0.000,uv.y-0.002)).y;
        col.b += 0.08*texture2D(bitmap,0.75*vec2(x+-0.02, -0.018)+vec2(uv.x-0.002,uv.y+0.000)).z;
    
        col = clamp(col*0.6+0.4*col*col*1.0,0.0,1.0);
    
        float vig = (0.0 + 1.0*16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y));
        col *= vec3(pow(vig,0.3));
    
        col *= vec3(0.95,1.05,0.95);
        col *= 2.8;
    
        float scans = clamp( 0.35+0.1*sin(2.5*iTime+uv.y*openfl_TextureCoordv.y*1.5), -0.1, 1.0);
        
        float s = pow(scans,1.7);
        col = col*vec3( 0.4+0.7*s) ;
    
        col *= 1.0+0.01*sin(110.0*iTime);
        if (uv.x < 0.0 || uv.x > 1.0)
            col *= 0.0;
        if (uv.y < 0.0 || uv.y > 1.0)
            col *= 0.0;
        
        col*=1.0-0.65*vec3(clamp((mod(gl_FragCoord.x, 2.0)-1.0)*2.0,0.0,1.0));
        
        float comp = smoothstep( 0.1, 0.9, sin(iTime) );
        
        // Remove the next line to stop cross-fade between original and postprocess
        // col = mix( col, oricol, comp );
    
        gl_FragColor = vec4(col,1.0);
    }
    ')
    public function new() {
        super();
    }
}
class CrtTv
{
    public var shader:CrtTvShader;
    public function new() {
        shader = new CrtTvShader();
        shader.iTime.value = [0];

        Main.updateShaders.push(update);
    }
    public function update(elapsed:Float) {
        shader.iTime.value[0] += elapsed;
    }
}

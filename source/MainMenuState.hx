package;

import openfl.net.URLRequest;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import openfl.net.URLRequest;
import openfl.Lib;


using StringTools;
#if sys
import sys.FileSystem;
#end

class MainMenuState extends MusicBeatState
{
    public static var psychEngineVersion:String = '0.5.2h';

    var bg:FlxSprite = new FlxSprite();

    var mod:Float = 60;
    var smod:Float = 5;

    var selector:FlxSprite;
    var options:Array<String> = [
        'freeplay',
        'options',
        'credits',
        'hall of fame',
        'socials'
    ];
    var opts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

    static var curOption:Int = 0;
    static var onRight:Bool = false;

    var quant:Int = #if sys 0 #else 5 #end ;

    override public function create() {
        var logo:FlxSprite = new FlxSprite(0, -60).loadGraphic(Paths.image("menushit/title"));
        logo.scale.x = logo.scale.y = 0.4;
        logo.antialiasing = ClientPrefs.globalAntialiasing;
        logo.updateHitbox();
        logo.screenCenter(X);
        selector = new FlxSprite(0, 400 + (mod * curOption) - smod).loadGraphic(Paths.image("menushit/selector"));
        selector.scale.x = selector.scale.y = 0.5;
        selector.antialiasing = ClientPrefs.globalAntialiasing;
        selector.updateHitbox();

        var loops:Int = 0;
        for (i in options) {
            var txt:FlxText = new FlxText(0, 400 + (mod * loops), 0, i.toUpperCase());
			txt.setFormat(Paths.font("slender.ttf"), 32, 0xffFFFFFF, CENTER);
            txt.screenCenter(X);
            txt.antialiasing = ClientPrefs.globalAntialiasing;
            txt.ID = loops;
            opts.add(txt);

            loops++;
        }

        #if sys
        for (i in FileSystem.readDirectory("assets/images/menushit")) {
            if (i.startsWith("page") && i.endsWith(".png")) {
                var num = Std.parseInt(i.substring(4, i.length - 4).trim());
                if (num != null && num > quant)
                    quant = num;
            }
        }
        #end

        add(bg);
        add(selector);
        add(opts);
        add(logo);

        spawnBG();

        super.create();
    }

    var canType:Bool = true;
    var typed:String = "";

    override public function update(elapsed:Float):Void {
        final newChar:Null<Int> = FlxG.keys.firstJustPressed();
        if (newChar != null && newChar >= 31 && newChar <= 127) {
            typed += String.fromCharCode(newChar).toLowerCase();
            trace("typed: " + typed);
        }

        if (FlxG.sound.music.volume < 0.7)
            {
                FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
            }
        
        if (canType) {
            if (typed.endsWith("he watches")) {
                canType = false;

                PlayState.SONG = Song.loadFromJson("access-denied-hard", "access-denied");
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 2;

                LoadingState.loadAndSwitchState(new PlayState());
            }

            if (controls.UI_UP_P)
                select(-1);
            if (controls.UI_DOWN_P)
                select(1);
            if (FlxG.keys.justPressed.ENTER) {
                switch (options[curOption]) {
                    case 'freeplay':
                        MusicBeatState.switchState(new SlenderFP());
                        // MusicBeatState.switchState(new SlenderFP());
                    case 'options':
                        MusicBeatState.switchState(new options.OptionsState());
                    case 'credits':
                        MusicBeatState.switchState(new CreditsState());
                    case 'hall of fame':
                        MusicBeatState.switchState(new HallofFameState());
                    case 'socials':
                        FlxG.openURL('https://discord.com/invite/m6Rjg78yuS', '_self');
                        FlxG.openURL('https://twitter.com/UntitledFunkers', '_self');
                }
            }
        }

        selector.y = 400 + (mod * curOption) - smod;
        selector.screenCenter(X);

        super.update(elapsed);
    }

    public function select(m:Int = 0):Void {
        curOption += m;
        if (curOption > options.length - 1)
            curOption = 0;
        if (curOption < 0)
            curOption = options.length - 1;
        FlxG.sound.play(Paths.sound('scrollMenu'));
    }

    var olde:Int = -1;
    public function spawnBG(nil:FlxTween = null):Void {
        var rand:Int = -1;
        while (rand == olde) {
            rand = FlxG.random.int(1, quant);
        }
        olde = rand;
        bg.loadGraphic(Paths.image("menushit/page" + rand));

		var randAngle = FlxG.random.float(0, 360);
		var randX = FlxG.random.float(0, 1280);
		var randY = FlxG.random.float(0, 720);
		var randNewX = FlxG.random.float(0, 1280);
		var randNewY = FlxG.random.float(0, 720);

		bg.x = randX;
		bg.y = randY;
		bg.scale.x = 1.8;
		bg.scale.y = 1.6;
		bg.angle = randAngle;
		bg.alpha = 0;
		FlxTween.tween(bg, {alpha: 0.5}, 4, {
			onComplete: function(twn:FlxTween)
			{
				FlxTween.tween(bg, {alpha: 0}, 2);
			}
		});
		FlxTween.tween(bg, {x: randNewX, y: randNewY}, 6, {onComplete: spawnBG});
    }
}

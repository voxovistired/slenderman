package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

typedef SongThing = {
    name:String,
    week:Int,
    icon:String,
    prev:Null<String>
}

class SlenderFP extends MusicBeatState
{
    inline function make(name:String, week:Int = 1, icon:String = 'slender', prev:Null<String> = null):SongThing {
        return {name: name, week: week, icon: icon, prev: prev};
    }
    var options:Array<SongThing> = [];

    var bg:FlxSprite = new FlxSprite();
    var icon:HealthIcon = new HealthIcon();
    var diff:FlxSprite = new FlxSprite(34, 60);
    var light:FlxSprite = new FlxSprite();
    var twn:FlxTween = null;

    static var curDifficulty:Int = 2;
    static var curSelected:Int = 0;
    var songs:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

    public function new() {
        options = [
            make('Play With Me', 0, 'sally'),
            make('Thanatophobia'),
            make('Static'),
            make('Haphephobia'),
            make('Engage')
        ];

        super();
    }

    override public function create() {
        bg.loadGraphic(Paths.image("menushit/freeplayPage"));
        bg.antialiasing = ClientPrefs.globalAntialiasing;

        icon.x = 970;
        icon.screenCenter(Y);
        icon.y -= 20;

        light.loadGraphic(Paths.image("menushit/freeplayLight"));
        light.antialiasing = ClientPrefs.globalAntialiasing;
        light.offset.y = 720;
        light.offset.x = 1280;

        var loops:Int = 0;
        for (i in options) {
            var txt = new FlxText(0, 80 + (80 * loops), 0, i.name);
			txt.setFormat(Paths.font("slender.ttf"), 64, 0xffFFffFF, CENTER);
            txt.screenCenter(X);
            txt.ID = loops;
            if (loops == curSelected) {
                light.y = txt.y + txt.height * 0.5;
                icon.changeIcon(i.icon);
            }
            txt.antialiasing = ClientPrefs.globalAntialiasing;
            songs.add(txt);

            loops++;
        }

        add(bg);
        add(diff);
        add(icon);
        add(songs);
        add(light);

        select();
        changeDiff();
        alpha();

        super.create();
    }

    public function alpha(nil:FlxTween = null) {
        FlxTween.tween(light, {alpha: FlxG.random.float(0.4, 0.8)}, FlxG.random.float(0.2, 2), {onComplete: alpha, ease: FlxEase.smoothStepIn});
    }

    public function moveCam(y:Float, x:Float = 640) {
        if (twn != null)
            twn.cancel();
        twn = FlxTween.tween(light, {y: y, x: x}, 0.3, {ease: FlxEase.smootherStepOut});
    }

    public function changeDiff(n:Int = 0) {
        curDifficulty += n;
        if (curDifficulty < 0)
            curDifficulty = 2;
        if (curDifficulty > 2)
            curDifficulty = 0;

        diff.loadGraphic(Paths.image('menudifficulties/' + (curDifficulty > 0? (curDifficulty > 1? "hard" : "normal") : "easy")));
    }

    public function select(n:Int = 0) {
        curSelected += n;
        if (curSelected < 0)
            curSelected = options.length - 1;
        if (curSelected > options.length - 1)
            curSelected = 0;

        for (i in songs) {
            if (i.ID == curSelected) {
                i.color = 0xff820020;
                moveCam(i.y + i.height * 0.5);
                icon.changeIcon(options[curSelected].icon);
            }
            else
                i.color = 0xff000000;
        }
    }

    override public function update(elapsed:Float) {
        if (controls.UI_UP_P)
            select(-1);
        if (controls.UI_DOWN_P)
            select(1);
        if (controls.UI_LEFT_P)
            changeDiff(-1);
        if (controls.UI_RIGHT_P)
            changeDiff(1);

        if (controls.ACCEPT) {
			var songLowercase:String = Paths.formatToSongPath(options[curSelected].name);
            var dif:String = (curDifficulty > 0? (curDifficulty > 1? "-hard" : "") : "-easy");

			PlayState.SONG = Song.loadFromJson(songLowercase + dif, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			FlxG.sound.music.volume = 0;
            LoadingState.loadAndSwitchState(new PlayState());
        }

        if (controls.BACK) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
        }
        
        super.update(elapsed);
    }
}

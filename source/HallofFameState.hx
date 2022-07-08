package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class HallofFameState extends MusicBeatState
{
	var heads:Array<Dynamic> = ['GamerKong', 'Nethix', 'Migoljif'];
	var socials:Array<Dynamic> = [
		'https://www.youtube.com/c/GamerKongKong',
		'https://youtu.be/dQw4w9WgXcQ',
		'https://www.twitch.tv/migoljif'
	];

	var desc:FlxText;
	var txtRight:FlxText;
	var txtLeft:FlxText;
	var txtArrows:FlxText;
	var hallHeads:FlxSprite;
	var canChange:Bool = true;
	var hasClicked:Bool = false;

	public static var selectedP:Int = 0;

	override function create()
	{
		super.create();

		ClientPrefs.showFPS = false;

		var cover:FlxSprite = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFFFFFFFF);
		cover.scrollFactor.set();
		add(cover);

		var txt:FlxText = new FlxText(10, 0, FlxG.width, 'First three people who have beaten (old) Engage on Hard in the first version of the demo:', 32);

		txt.setFormat("VCR OSD Mono", 42, FlxColor.fromRGB(255, 255, 255), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		add(txt);

		desc = new FlxText(0, 660);
		desc.setFormat("VCR OSD Mono", 42, FlxColor.WHITE, CENTER);
		desc.borderColor = FlxColor.BLACK;
		desc.borderSize = 3;
		desc.borderStyle = FlxTextBorderStyle.OUTLINE;
		desc.text = (selectedP + 1) + '° ' + heads[selectedP];
		desc.screenCenter(X);
		desc.updateHitbox();
		add(desc);

		txtRight = new FlxText(0, 0, FlxG.width, "> ", 32);

		txtLeft = new FlxText(0, 0, FlxG.width, " <", 32);

		txtLeft.setFormat("VCR OSD Mono", 100, FlxColor.WHITE, LEFT);
		txtLeft.borderColor = FlxColor.BLACK;
		txtLeft.borderSize = 3;
		txtLeft.borderStyle = FlxTextBorderStyle.OUTLINE;
		txtLeft.antialiasing = true;
		txtLeft.scale.y = 3;
		txtLeft.screenCenter();

		txtRight.setFormat("VCR OSD Mono", 100, FlxColor.WHITE, RIGHT);
		txtRight.borderColor = FlxColor.BLACK;
		txtRight.borderSize = 3;
		txtRight.borderStyle = FlxTextBorderStyle.OUTLINE;
		txtRight.antialiasing = true;
		txtRight.scale.y = 3;
		txtRight.screenCenter();

		add(txtRight);
		add(txtLeft);

		hallHeads = new FlxSprite(0, 0);
		hallHeads.loadGraphic(Paths.image('hall of fame/' + heads[selectedP]));
		hallHeads.screenCenter();
		hallHeads.antialiasing = ClientPrefs.globalAntialiasing;
		hallHeads.scale.x = 0.5;
		hallHeads.scale.y = 0.5;
		add(hallHeads);
		daAngle(-10);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			#if !switch
			CoolUtil.browserLoad(socials[selectedP]);
			#end
		}

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
			ClientPrefs.showFPS = FlxG.save.data.showFPS;
		}

		if (canChange)
		{
			if (FlxG.keys.justPressed.RIGHT)
			{
				hasClicked = true;
				FlxG.sound.play(Paths.sound('click-start'));
				txtRight.color = FlxColor.CYAN;
				if (selectedP >= heads.length - 1)
					selectedP = 0;
				else
					selectedP++;
			}
			if (FlxG.keys.justPressed.LEFT)
			{
				hasClicked = true;
				FlxG.sound.play(Paths.sound('click-start'));
				txtLeft.color = FlxColor.CYAN;
				if (selectedP <= 0)
					selectedP = heads.length - 1;
				else
					selectedP--;
			}

			if(hasClicked)
			{
				if (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT)
				{
					hasClicked = false;
					canChange = false;
					txtLeft.color = FlxColor.WHITE;
					txtRight.color = FlxColor.WHITE;
					FlxG.sound.play(Paths.sound('click-end'));

					FlxTween.tween(desc, {alpha: 0}, 0.1);
					FlxTween.tween(hallHeads, {alpha: 0}, 0.2);
					FlxTween.tween(hallHeads.scale, {x: 0, y: 0}, 0.2, {
						onComplete: function(twn:FlxTween)
						{
							hallHeads.loadGraphic(Paths.image('hall of fame/' + heads[selectedP]));
							FlxTween.tween(hallHeads.scale, {x: 0.5, y: 0.5}, 0.1);
							FlxTween.tween(hallHeads, {alpha:1}, 0.1, {onComplete: function(twn:FlxTween){
								canChange = true;
							}});
							desc.text = (selectedP + 1) + '° ' + heads[selectedP];
							FlxTween.tween(desc, {alpha: 1}, 0.05);
							desc.screenCenter(X);
							hallHeads.screenCenter();
						}
					});
				}
			}
		}

		// dakblake's rap lmao
		// https://youtu.be/P87DJnpSBqA?t=12

		super.update(elapsed);
	}

	public function daAngle(m:Float)
	{
        FlxTween.tween(hallHeads, {angle: m}, 1, {
            onComplete: function(twn:FlxTween)
            {
                daAngle(m * -1);
            }
        });
	}
}

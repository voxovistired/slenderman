local hel = 1.0;

function onCreatePost()
	setProperty('boyfriend.visible', false);
	setProperty('GameOverSubstate.characterName', 'operator');
	setProperty('camFollox.x', 0);
	setProperty('camFollox.y', 0);
	setProperty('dad.alpha', 0.00001);
	scaleObject('dad', 0.9, 0.9);
	if flashingLights then
		makeAnimatedLuaSprite('stat', 'statics/holy_shit', -260, -200);
		addAnimationByPrefix('stat', 'statanim', 'idle', 36);
		setScrollFactor('stat', 0, 0);
		setProperty('stat.alpha', 0.1);
		scaleObject('stat', 1.2, 1.2);

		makeAnimatedLuaSprite('topstat', 'statics/holy_shit', -260, -200);
		addAnimationByPrefix('topstat', 'statanim', 'idle', 36);
		setScrollFactor('topstat', 0, 0);
		setProperty('topstat.alpha', 0.00001);
		scaleObject('topstat', 1.2, 1.2);

		addLuaSprite('stat', false);
		addLuaSprite('topstat', true);
		objectPlayAnimation('stat', 'statanim', true);
		objectPlayAnimation('topstat', 'statanim', true);
	end
	setProperty('iconP2.alpha', getProperty('dad.alpha'));
end
function onStepHit()
	if doDrain then
		hel = getProperty('health');
		setProperty('health', hel - 0.006);
	end

	if songName == 'Access Denied' then
		if curStep == 12 then
			setProperty('topstat.alpha', 0.1);
		end
		if curStep == 22 then
			setProperty('topstat.alpha', 0.2);
		end
		if curStep == 32 then
			setProperty('topstat.alpha', 0.3);
		end
		if curStep == 41 then
			setProperty('topstat.alpha', 0);
		end
		if curStep == 45 then
			setProperty('topstat.alpha', 1);
		end
		if curStep == 46 then
			setProperty('topstat.alpha', 0);
		end
		if curStep == 47 then
			setProperty('topstat.alpha', 1);
		end
		if curStep == 48 then
			setProperty('topstat.alpha', 0);
		end
		if curStep == 50 then
			setProperty('topstat.alpha', 1);
		end
		if curStep == 52 then
			setProperty('topstat.alpha', 0);
			setProperty('dad.alpha', 0.2);
		end
		if curStep == 53 then
			setProperty('topstat.alpha', 1);
		end
		if curStep == 54 then
			setProperty('topstat.alpha', 0);
			setProperty('dad.alpha', 0.4);
		end
		if curStep == 56 then
			setProperty('topstat.alpha', 1);
		end
		if curStep == 57 then
			setProperty('topstat.alpha', 0);
			setProperty('dad.alpha', 0.8);
		end
		if curStep == 59 then
			setProperty('topstat.alpha', 1);
		end
		if curStep == 63 then
			setProperty('topstat.alpha', 0.1);
			setProperty('dad.alpha', 1);
		end
		if curStep == 448 then
			setProperty('topstat.alpha', 0);
			setProperty('stat.alpha', 0);
			setProperty('camHUD.alpha', 0);
			setProperty('camGame.alpha', 0);
			setShader('dad', 'greyscale');
		end
		if curStep == 464 then
			setProperty('topstat.alpha', 0);
			setProperty('stat.alpha', 0.3);
			setProperty('camHUD.alpha', 1);
			setProperty('camGame.alpha', 1);
		end
		if curStep == 992 then
			setProperty('stat.alpha', 0.8);
			setProperty('topstat.alpha', 0.1);
		end
		if curStep == 1008 then
			setProperty('topstat.alpha', 0.25);
			setProperty('camHUD.alpha', 0.75);
		end
		if curStep == 1016 then
			setProperty('topstat.alpha', 0.4);
			setProperty('camHUD.alpha', 0.6);
		end
		if curStep == 1030 then
			setProperty('topstat.alpha', 0.6);
			setProperty('camHUD.alpha', 0.4);
		end
		if curStep == 1040 then
			setProperty('topstat.alpha', 0);
			setProperty('stat.alpha', 0.4);
			setProperty('camHUD.alpha', 1);
		end
	end
	if songName == 'Epiphany' then      --[[🤫]]
		if curStep == 8 then
			setProperty('topstat.alpha', 0.4);
			setProperty('dad.alpha', 0.4);
		end
		if curStep == 18 then
			setProperty('topstat.alpha', 0.8);
			setProperty('dad.alpha', 0.8);
		end
		if curStep == 31 then
			setProperty('dad.alpha', 1);
			setProperty('topstat.alpha', 0);
		end
		if curStep == 544 then
			setProperty('camHUD.alpha', 0);
			setProperty('camGame.alpha', 0);
		end
		if curStep == 576 then
			setProperty('camHUD.alpha', 1);
			setProperty('camGame.alpha', 1);
		end
		if curBeat == 648 then
			setProperty('topstat.alpha', 0.3);
		end
		if curBeat == 776 then
			setProperty('topstat.alpha', 0.6);
		end
		if curBeat == 788 then
			setProperty('topstat.alpha', 0.4);
			setProperty('dad.alpha', 0.6);
		end
		if curBeat == 792 then
			setProperty('topstat.alpha', 0.2);
			setProperty('dad.alpha', 0);
		end
	end
end

local globMod = 120
local follow = false
function onUpdate(elapsed)
	setProperty('iconP2.alpha', getProperty('dad.alpha'));
    local xMod = 0
    local yMod = 0
    local anim = getProperty("boyfriend.animation.curAnim.name"):lower()
    anim = anim:gsub("sing", "")
    if anim == 'left' then
        xMod = 0 - globMod
    end
    if anim == 'down' then
        yMod = globMod
    end
    if anim == 'up' then
        yMod = 0 - globMod
    end
    if anim == 'right' then
        xMod = globMod
    end
    local mx = screenWidth * 0.5
    local my = screenHeight * 0.5
    setProperty("camFollow.x", mx - 640 + xMod)
    setProperty("camFollow.y", my - 600 + yMod)
end

function onUpdatePost()
	setProperty('gf.alpha', 0);
	setProperty('gf.visible', false);
end

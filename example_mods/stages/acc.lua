function onCreate()
	if not lowQuality then
		makeLuaSprite('sky', 'slender/woods/sky', -614.4, -355)
		setScrollFactor('sky', 0.1, 0.1)
		scaleObject('sky', 0.7, 0.7)
		
		makeLuaSprite('tree', 'slender/woods/backtree', -614.4, -325)
		setScrollFactor('tree', 0.4, 0.4)
		scaleObject('tree', 0.6, 0.6)

		makeLuaSprite('fog', 'slender/woods/fog', -614.4, -355)
		setScrollFactor('fog', 0.6, 0.6)
		scaleObject('fog', 0.6, 0.6)
        setProperty('fog.alpha', 0.0001)

		makeLuaSprite('ground', 'slender/woods/ground', -614.4, -355)
		setScrollFactor('ground', 1, 1)
		scaleObject('ground', 0.6, 0.6)

		makeLuaSprite('trees', 'slender/woods/trees', -614.4, -355)
		setScrollFactor('trees', 1, 1)
		scaleObject('trees', 0.6, 0.6)

		makeLuaSprite('forefog', 'slender/woods/forefog', -614.4, -420)
		setScrollFactor('forefog', 1.1, 0.15)
		scaleObject('forefog', 0.6, 0.6)
        setProperty('forefog.alpha', 0.0001)

        local l = '30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14'
        local r = '15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29'
        makeAnimatedLuaSprite('gfF', 'characters/GF', 780, 90);
        addAnimationByIndices('gfF', 'idle dad l', 'idle-dad', l, 24);
        addAnimationByIndices('gfF', 'idle dad r', 'idle-dad', r, 24);
        addAnimationByIndices('gfF', 'idle bf l', 'idle-bf', l, 24);
        addAnimationByIndices('gfF', 'idle bf r', 'idle-bf', r, 24);
        addAnimationByIndices('gfF', 'scared dad l', 'scared-dad', l, 24);
        addAnimationByIndices('gfF', 'scared dad r', 'scared-dad', r, 24);
        addAnimationByIndices('gfF', 'scared bf l', 'scared-bf', l, 24);
        addAnimationByIndices('gfF', 'scared bf r', 'scared-bf', r, 24);
        objectPlayAnimation('gfF', 'idle bf l', true)

		addLuaSprite('sky', false)
		addLuaSprite('tree', false)
        addLuaSprite('fog', false)
		addLuaSprite('ground', false)
        addLuaSprite('gfF', false);
		addLuaSprite('trees', true)
        addLuaSprite('forefog', true)
	else
		makeLuaSprite('lowground', 'slender/woods/low quality', -614.4, -355)
		setScrollFactor('lowground', 1, 1)
		scaleObject('lowground', 0.6, 0.6)
		addLuaSprite('lowground', false)
	end
end
function onCreatePost()
    setProperty('gf.alpha', 0.0001);
    addCharacterToList("jeff2", "dad")
    addCharacterToList("bf-camera", "bf")
    addCharacterToList("bf-slender", "bf")

    setObjectOrder('gfF', getObjectOrder('gfGroup') + 1)
end

local prefix = 'idle'
local suffix = 'l'
function onStepHit()
    if curStep == 288 then
        doTweenAlpha('fogIn', 'fog', 1, (60 / curBpm) * 4, "quadinout")
        doTweenAlpha('forefogIn', 'forefog', 1, (60 / curBpm) * 4, "quadinout")
        setProperty("defaultCamZoom", 0.4)
    end
    if curStep == 292 then
        setProperty("defaultCamZoom", 0.8)
    end
    if curStep == 670 then
        prefix = 'scared'
        setProperty("gf.alpha", 1)
        setProperty("defaultCamZoom", 0.6)
        triggerEvent("Change Character", "bf", "bf-camera")
    end
    if curStep == 937 then
        triggerEvent("Change Character", "dad", "jeff2")
        triggerEvent("Change Character", "bf", "bf-slender")
        setProperty("gf.alpha", 0)
        setProperty("defaultCamZoom", 0.8)
    end
end
local char = 'bf'
function onMoveCamera(c)
    if c == 'dad' then
        char = c
    else
        char = 'bf'
    end
end
function onCountdownTick()
    onBeatHit()
end
function onBeatHit()
    if suffix == 'l' then
        suffix = 'r'
    else
        suffix = 'l'
    end
    objectPlayAnimation('gfF', prefix..' '..char..' '..suffix, true)
end

function mysplit (inputstr, sep)    -- splits a string (by Adrian Mole https://stackoverflow.com/questions/1426954/split-string-in-lua) 
    if sep == nil then
        return {inputstr}
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local talkative = {}
function onCreate()
    if flashingLights then -- adds hud overlaying shits and static stage aaaaaaaaaaaaaaaaaa
        makeAnimatedLuaSprite('stats', 'statics/holy_shit', -340, -200) -- static stage
        addAnimationByPrefix('stats', 'statanim', 'idle', 36)
        setScrollFactor('stats', 0, 0)
        scaleObject('stats', 1.2, 1.2)
        setProperty('stats.visible', false)

        makeAnimatedLuaSprite('stat', 'statics/holy_shit', -140, -140)
        addAnimationByPrefix('stat', 'statanim', 'idle', 36)
        setScrollFactor('stat', 0, 0)
        setProperty('stat.alpha', 0.2)
        scaleObject('stat', 1.2, 1.2)
        setProperty('stat.visible', false)

        makeAnimatedLuaSprite('jumpscare', 'statics/jumpscare', 0, 0)
        addAnimationByPrefix('jumpscare', 'jumpanim', 'jumpscare', 24)
        setScrollFactor('jumpscare', 0, 0)
        setProperty('jumpscare.alpha', 0.0001)
        
        makeLuaSprite('crt', 'statics/crt', 0, 0)
        setScrollFactor('crt', 0, 0)
        setGraphicSize('crt', getPropertyFromClass('flixel.FlxG', 'width') + 1, getPropertyFromClass('flixel.FlxG', 'height') + 1)
        print('Set the size of "crt" to '..getPropertyFromClass('flixel.FlxG', 'width')..', '..getPropertyFromClass('flixel.FlxG', 'height'))

        makeLuaSprite('camon', 'statics/cam_on', 20, 20)
        setScrollFactor('camon', 0, 0)
        setProperty('camon.visible', false)
        
        makeLuaSprite('camoff', 'statics/cam_off', 20, 20)
        setScrollFactor('camoff', 0, 0)

        makeAnimatedLuaSprite('dying', 'statics/holy_shit', -140, -140)
        addAnimationByPrefix('dying', 'statanim', 'idle', 36)
        setScrollFactor('dying', 0, 0)
        setProperty('dying.alpha', 0.0001)
        scaleObject('dying', 1.2, 1.2)

        setObjectCamera('stat', 'hud')
        setObjectCamera('jumpscare', 'hud')
        setObjectCamera('camon', 'hud')
        setObjectCamera('camoff', 'hud')
        setObjectCamera('scan', 'hud')
        setObjectCamera('crt', 'hud')
        setObjectCamera('dying', 'hud')

        addLuaSprite('stats')
        addLuaSprite('stat')
        addLuaSprite('jumpscare')
        addLuaSprite('camon')
        addLuaSprite('camoff')
        if native then else
            addLuaSprite('crt')
        end

        objectPlayAnimation('stat', 'statanim', true)
        objectPlayAnimation('jumpscare', 'jumpanim', true)

        local daName = getPropertyFromClass("PlayState", "SONG.song")
        daName = daName:gsub(" ", "-")
        daName = daName:lower()
    
        local file = getTextFromFile("data/"..daName.."/jumpscares.txt")
        local lines = mysplit(file, ",")
    
        for i = 1, #lines do
            local line = lines[i]:gsub(" ", "")
            talkative[#talkative + 1] = tonumber(line)
        end
    end
end
function onCountdownTick()
    if getPropertyFromClass("PlayState", "SONG.player2") == 'sally' then else
        addLuaSprite('dying', true)
    end
end

local calc = true
local oldhp = 1
function onUpdatePost()
    if oldhp > getProperty("health") then
        calc = true;
    end
    oldhp = getProperty("health")

    if getPropertyFromClass("PlayState", "SONG.song"):lower() == "engage" then
        if calc then
            setProperty('dying.alpha', (1 - (getProperty("health") * 1)) * 0.22)
        end
    else
        if calc then
            setProperty('dying.alpha', (1 - (getProperty("health") * 1)) * 0.4)
        end
    end
end
function onBeatHit()
    if curBeat % 2 == 0 then
        local scanlineHeight = 200
    
        cancelTween("scan")
        removeLuaSprite("scan")
        makeLuaSprite('scan', 'statics/white_scanline')
        setGraphicSize("scan", 1280, scanlineHeight)
    
        if flashingLights then
            if native then else
                addLuaSprite('scan')
            end
            setObjectCamera('scan', 'hud')
        end
    
        local from = 0 - scanlineHeight
        local to = 720
        if downscroll then
            from = 720
            to = 0 - scanlineHeight
        end
        setProperty("scan.y", from)
        local duration = getPropertyFromClass("Conductor", "crochet") / 1000
        doTweenY("scanning", "scan", to, duration)
    end

    if curBeat % 2 == 0 then
        setProperty('camoff.visible', true)
        setProperty('camon.visible', false)
    else
        setProperty('camoff.visible', false)
        setProperty('camon.visible', true)
    end
end

local on = false
function onStepHit()
    function onStepHit()
        for i = 1, #talkative do
            if talkative[i] == curStep then
                -- debugPrint(talkative[i])
                if on then
                    setProperty("jumpscare.alpha", 0.0001)
                else
                    setProperty("jumpscare.alpha", 1)
                    oldhp = 0.0001
                    calc = false
                    setProperty("health", 0.0001)
                end
                on = not on
            end
        end
    end
end

function onEvent(name)
    if name == "disable static" then
        oldhp = getProperty("health")
        calc = false
    end
end

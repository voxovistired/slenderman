function onCreatePost()
    makeLuaSprite("slowStart")
    makeGraphic("slowStart", screenWidth, screenHeight, "ffffff")
    setProperty("slowStart.color", getColorFromHex("000000"))
    setObjectCamera("slowStart", "hud")
    addLuaSprite("slowStart")
    setProperty("defaultCamZoom", 1.6)
end

function onCountdownTick(c)
    if c == 4 then
        doTweenAlpha("start", "slowStart", 0.5, ((60 / curBpm) * 4) * 8, "smootherstepinout")
    end
end

function onTweenCompleted(tag)
    if tag == "start" then
        setObjectCamera("slowStart", "other")
        setProperty("defaultCamZoom", 0.8)
        cancelTween("start")
        setProperty("slowStart.color", getColorFromHex("ffffff"))
        setProperty("slowStart.alpha", 1)
        doTweenAlpha("flash", "slowStart", 0, (60 / curBpm) * 4, "quadpout")
    end
end

function onBeatHit()
    if curBeat == 97 then
        setProperty("defaultCamZoom", 1)
    end
    if curBeat == 128 then
        setProperty("defaultCamZoom", 0.8)
    end
    if curBeat == 192 then
        setProperty("defaultCamZoom", 1)
        doTweenAlpha("prfnd", "blammedLightsBlack", 0.75, ((60 / curBpm) * 4) * 8, "smootherstepinout")
        doTweenAlpha("prfndTrees", "trees", 0.25, ((60 / curBpm) * 4) * 8, "smootherstepinout")
    end
    if curBeat == 193 then
        setProperty("defaultCamZoom", 1.1)
    end
    if curBeat == 192 then
        setProperty("defaultCamZoom", 1.2)
    end
    if curBeat == 224 then
        setProperty("defaultCamZoom", 0.8)
        setProperty("blammedLightsBlack.alpha", 0)
        setProperty("trees.alpha", 1)
    end
end


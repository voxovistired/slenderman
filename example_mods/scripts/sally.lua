local animFinished = false

function onCreatePost()
    makeAnimatedLuaSprite("sally", "slender/woods/sally-angle", 1200, 200)
    addAnimationByPrefix("sally", "spawn", "spawn", 24, false)
    addAnimationByPrefix("sally", "beat", "bop", 24, false)
    addLuaSprite("sally", true)
    playAnim("spawn")
    setProperty("sally.alpha", 0.0001)
end

local offsets = {spawn = {x = 160, y = 36}, beat = {x = 0, y = 0}}
function playAnim(name)
    setProperty("sally.offset.x", offsets[name]["x"])
    setProperty("sally.offset.y", offsets[name]["y"])
    objectPlayAnimation("sally", name, true)
end

function onBeatHit()
    if animFinished and curBeat % 2 == 0 then
        playAnim("beat")
    end
end

function onUpdatePost()
    if getProperty("sally.animation.curAnim.finished") then
        animFinished = true
    end
end

function onEvent(name, skip)
    if name == 'spawn sally' then
        setProperty("sally.alpha", 1)
        if not skip == '1' then
            animFinished = false
            playAnim("spawn")
        end
    end
end
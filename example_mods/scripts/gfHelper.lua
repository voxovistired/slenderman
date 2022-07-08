local s = ""
local nextInQueue = nil
local run = true

function onCreatePost()
    if getPropertyFromClass("PlayState", "SONG.song"):lower() == "haphephobia" or getPropertyFromClass("PlayState", "SONG.song"):lower() == "engage" then
        setProperty("gfSpeed", 2)
        s = "s-"
    end
    if getProperty("gf.curCharacter"):find("slender") > 0 then
        run = false
    end

    addCharacterToList("gf-right", "gf")
    addCharacterToList("gf-s-left", "gf")
    addCharacterToList("gf-s-right", "gf")
end

function onCountdownTick(c)
    local x = getProperty("camFollow.x")
    local avg = (getProperty("dad.x") + getProperty("boyfriend.x")) * 0.5
    if x > avg then
        nextInQueue = "right"
    else
        nextInQueue = "left"
    end
    onBeatHit()
end

function onMoveCamera(c)
    if c == 'boyfriend' then
        nextInQueue = "right"
    else
        nextInQueue = "left"
    end
end

local oldMember = nil
function onBeatHit()
    if not run then return end

    if nextInQueue == nil or nextInQueue == oldMember then else
        oldMember = nextInQueue
        local anim = getProperty("gf.animation.curAnim.name")
        local frame = getProperty("gf.animation.curAnim.curFrame")
        triggerEvent("Change Character", "gf", "gf-"..s..nextInQueue)
        characterPlayAnim("gf", anim, true)
        local frames = getProperty("gf.animation.curAnim.frames")
        local f = frame
        if frame > frames then
            f = frames
        end
        setProperty("gf.animation.curAnim.curFrame", f)
        nextInQueue = nil
    end
end

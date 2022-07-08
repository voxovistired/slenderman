local globMod = 120
local follow = false
function onUpdate(elapsed)
    if getProperty("dad.curCharacter"):find("slender") and follow then
        local xMod = 0
        local yMod = 0
        local anim = getProperty("dad.animation.curAnim.name"):lower()
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
        local dadmx = getProperty("dad.x") + getProperty("dad.width") * 0.5
        local dadmy = getProperty("dad.y") + getProperty("dad.height") * 0.5
        setProperty("camFollow.x", dadmx + 150 + xMod)
        setProperty("camFollow.y", dadmy - 100 - 120 + yMod)
    end
end
function onMoveCamera(c)
    if c == 'boyfriend' then
        follow = false
    else
        follow = true
    end
end

function onCountdownTick(c)
    if c == 1 then
        triggerEvent("Change Scroll Speed", "0.7", "0.0001")
    end
end

function onStepHit()
    if curStep == 256 then
        triggerEvent("Change Scroll Speed", "0.2", tostring((60 / curBpm) * 8))
    end
    if curStep == 304 then
        triggerEvent("Change Scroll Speed", "0.3", tostring(60 / curBpm))
    end
    if curStep == 308 then
        triggerEvent("Change Scroll Speed", "0.4", tostring(60 / curBpm))
    end
    if curStep == 312 then
        triggerEvent("Change Scroll Speed", "0.5", tostring((60 / curBpm) * 0.5))
    end
    if curStep == 314 then
        triggerEvent("Change Scroll Speed", "0.6", tostring((60 / curBpm) * 0.5))
    end
    if curStep == 316 then
        triggerEvent("Change Scroll Speed", "0.7", tostring((60 / curBpm) * 0.25))
    end
    if curStep == 317 then
        triggerEvent("Change Scroll Speed", "0.7", tostring((60 / curBpm) * 0.25))
    end
    if curStep == 318 then
        triggerEvent("Change Scroll Speed", "0.8", tostring((60 / curBpm) * 0.25))
    end
    if curStep == 319 then
        triggerEvent("Change Scroll Speed", "0.9", tostring((60 / curBpm) * 0.25))
    end
    if curStep == 320 then
        triggerEvent("Change Scroll Speed", "1", tostring((60 / curBpm) * 0.25))
    end
end
local ogAlpha = 1
function onBeatHit()
    if curBeat == 184 or curBeat == 976 then
        setProperty("jumpscare.alpha", 1)
        doTweenAlpha("jumpOut(a window)", "jumpscare", 0.0001, 2.22, 'smootherstepout')
    end
    if curBeat == 184 or curBeat == 652 then
        for i = 0, 3 do
            ogAlpha = getPropertyFromGroup("strumLineNotes", i, "alpha")
            noteTweenAlpha("jumpOut("..i.." windows)", i, 0, 2.22, 'smootherstepout')
        end
    end
    if curBeat == 252 or curBeat == 716 then
        for i = 0, 3 do
            noteTweenAlpha("jumpIn("..i.." windows)", i, ogAlpha, (60 / curBpm) * 4, 'smootherstepout')
        end
    end
end

function OnUpdate()
    if (curBeat >= 210 and curBeat <= 215) or (curBeat >= 660 and curBeat <= 690) then
        setProperty("dying.visible", false)
    else 
        setProperty("dying.visible", true)
    end
end
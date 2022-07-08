function onCreate()
	for i = 0, getProperty("unspawnNotes.length") - 1 do
        if getPropertyFromGroup("unspawnNotes", i, "noteType") == "Hurt Note" then
            if getPropertyFromClass("PlayState", "SONG.player2") == "sally" then
                setPropertyFromGroup("unspawnNotes", i, "ignoreNote", true)
            end
            setPropertyFromGroup("unspawnNotes", i, "earlyHitMult", 0.2)
            setPropertyFromGroup("unspawnNotes", i, "missHealth", 0.5)
        end
    end
end
function onUpdatePost()
	for i = 0, getProperty("notes.length") - 1 do
        if getPropertyFromGroup("notes", i, "noteType") == "Hurt Note" then     -- literally changing the game logics 
            local time = getPropertyFromClass("Conductor", "songPosition")
            local safeZone = getPropertyFromClass("Conductor", "safeZoneOffset")
            if getPropertyFromGroup("notes", i, "strumTime") < time - safeZone * 0.5 and not getPropertyFromGroup("notes", i, "wasGoodHit") then
                setPropertyFromGroup("notes", i, "tooLate", true)
            end
        end
    end
end

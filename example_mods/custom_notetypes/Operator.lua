function onCreate()
	for i = 0, getProperty("unspawnNotes.length") - 1 do
        if getPropertyFromGroup("unspawnNotes", i, "noteType") == "Operator" then
            setPropertyFromGroup("unspawnNotes", i, "ignoreNote", getPropertyFromGroup("unspawnNotes", i, "mustPress"))
            setPropertyFromGroup("unspawnNotes", i, "hitCausesMiss", true)
            setPropertyFromGroup("unspawnNotes", i, "missHealth", 2)
            setPropertyFromGroup("unspawnNotes", i, "texture", "operatorNote")
            setPropertyFromGroup("unspawnNotes", i, "earlyHitMult", 0.2)
        end
    end
end

function onUpdatePost()
	for i = 0, getProperty("notes.length") - 1 do
        if getPropertyFromGroup("notes", i, "noteType") == "Operator" then     -- literally changing the game logics 
            local time = getPropertyFromClass("Conductor", "songPosition")
            local safeZone = getPropertyFromClass("Conductor", "safeZoneOffset")
            if getPropertyFromGroup("notes", i, "strumTime") < time - safeZone * 0.5 and not getPropertyFromGroup("notes", i, "wasGoodHit") then
                setPropertyFromGroup("notes", i, "tooLate", true)
            end
        end
    end
end

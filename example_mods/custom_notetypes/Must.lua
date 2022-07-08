function onCreate()
	for i = 0, getProperty("unspawnNotes.length") - 1 do
        if getPropertyFromGroup("unspawnNotes", i, "noteType") == "Must" then
            setPropertyFromGroup("unspawnNotes", i, "texture", "DISTORTED_NOTE_assets")
            setPropertyFromGroup("unspawnNotes", i, "missHealth", 2)
        end
    end
end

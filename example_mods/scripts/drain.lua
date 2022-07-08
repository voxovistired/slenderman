function opponentNoteHit(id)
    local s = songName:lower();
    s = s:gsub(' ', '-')
    local h = 0.0
    if (s == 'thanatophobia') then
        h = 0.005
    end
    if (s == 'static') then
        h = 0.008
    end
    if (s == 'unstable') then
        h = 0.012
    end
    if (s == 'engage') then
        h = 0.02
    end
    if (getProperty("health") - h > 0) then
        setProperty("health", getProperty("health") - h)
    end
    if getProperty("dad.curCharacter"):match("slender") then
    end
end

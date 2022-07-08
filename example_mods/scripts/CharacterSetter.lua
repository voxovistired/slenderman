local song = ''
function onCreate()
    setPropertyFromClass("PlayState", "SONG.player3", "gf-left")
    setPropertyFromClass("PlayState", "SONG.player1", "bf-slender-n")
    setPropertyFromClass("PlayState", "SONG.player2", "slenderman")
    song = getPropertyFromClass("PlayState", "SONG.song"):lower()
    song = song:gsub(" ", "-")
    if song == 'play-with-me' then
        setPropertyFromClass("PlayState", "SONG.player2", "sally")
    end
    if song == 'haphephobia' or song == 'engage' then
        setPropertyFromClass("PlayState", "SONG.player1", "bf-slender")
        setPropertyFromClass("PlayState", "SONG.player3", "gf-s-left")
    end
    if song == 'access-denied' then
        setPropertyFromClass("PlayState", "SONG.player2", "operator")
    end
    if song == 'accelerant' then
        setPropertyFromClass("PlayState", "SONG.player2", "jeff")
        setPropertyFromClass("PlayState", "SONG.player3", "slendertricky")
    end
end
function onCreatePost()
    if song == 'haphephobia' or song == 'engage' then
        triggerEvent("Change Character", "gf", "gf-s-left")
    elseif song == 'accelerant' then
        triggerEvent("Change Character", "gf", "slendertricky")
    else
        triggerEvent("Change Character", "gf", "gf-left")
    end
end

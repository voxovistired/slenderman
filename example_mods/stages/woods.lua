function onCreate()
	if not lowQuality then
		makeLuaSprite('sky', 'slender/woods/sky', -614.4, -355);
		setScrollFactor('sky', 0.1, 0.1);
		scaleObject('sky', 0.7, 0.7);
		
		makeLuaSprite('tree', 'slender/woods/backtree', -614.4, -325);
		setScrollFactor('tree', 0.4, 0.4);
		scaleObject('tree', 0.6, 0.6);

		makeLuaSprite('fog', 'slender/woods/fog', -614.4, -355);
		setScrollFactor('fog', 0.6, 0.6);
		scaleObject('fog', 0.6, 0.6);
		-- setShader('fog', 'heatver');

		makeLuaSprite('ground', 'slender/woods/ground', -614.4, -355);
		setScrollFactor('ground', 1, 1);
		scaleObject('ground', 0.6, 0.6);

		makeLuaSprite('trees', 'slender/woods/trees', -614.4, -355);
		setScrollFactor('trees', 1, 1);
		scaleObject('trees', 0.6, 0.6);

		makeLuaSprite('forefog', 'slender/woods/forefog', -614.4, -355);
		setScrollFactor('forefog', 1.1, 0.15);
		scaleObject('forefog', 0.6, 0.6);
		-- setShader('forefog', 'flag');

		addLuaSprite('sky', false);
		addLuaSprite('tree', false);
        if getPropertyFromClass("PlayState", "SONG.player2") == 'sally' then else
		    addLuaSprite('fog', false);
        end
		addLuaSprite('ground', false);
		addLuaSprite('trees', true);
        if getPropertyFromClass("PlayState", "SONG.player2") == 'sally' then else
		    addLuaSprite('forefog', false);
        end

		-- callStatementless('createUI');
	else
		makeLuaSprite('lowground', 'slender/woods/low quality', -614.4, -355);
		setScrollFactor('lowground', 1, 1);
		scaleObject('lowground', 0.6, 0.6);
		addLuaSprite('lowground', false);
	end
	close(true);
end
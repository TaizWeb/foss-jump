windowWidth = 400
windowHeight = 600

Player = {
	x = (windowWidth-25)/2,
	y = (windowHeight-25)-75,
	height = 25,
	width = 25,
	dx = 0,
	dy = 0,
	ifFalling = false
}

Platforms = {
	totalPlatforms = 0,
	lastY = windowHeight,
	platforms = {}
}

seed = 42

function Platforms.spawnPlatform()
	width = 200
	height = 25
	math.randomseed(os.time() * seed)
	seed = seed + seed % 10
	x = math.random() * (windowWidth - width)
	--math.randomseed(os.time() * seed)
	--seed = seed + seed % 10
	--y = math.random() * (windowHeight - 200)
	y = Platforms.lastY - 50
	Platforms.lastY = y

	Platforms.totalPlatforms = Platforms.totalPlatforms + 1
	Platforms.platforms[Platforms.totalPlatforms] = {x = x, y = y, width = width, height = height}
end

-- Test platforms
Platforms.spawnPlatform()
Platforms.spawnPlatform()
Platforms.spawnPlatform()
Platforms.spawnPlatform()
Platforms.spawnPlatform()

function love.load()
	love.window.setTitle("Foss Jump")
	love.keyboard.setKeyRepeat(true)
	love.window.setMode(windowWidth, windowHeight)
end

function love.keypressed(key, scancode, isrepeat)
	if (key == "space" and not Player.isFalling) then
		Player.dy = -20
		Player.isFalling = true
	end
end

function love.update()
	-- Player movement
	if (love.keyboard.isDown("left")) then
		Player.dx = -5
	elseif (love.keyboard.isDown("right")) then
		Player.dx = 5
	else
		Player.dx = 0
	end

	-- Make player fall when not on ground
	if (not (Player.y >= (windowHeight-25)-75)) then
		Player.y = Player.y + 5
	end

	-- Make player bounce when they hit the ground
	if ((Player.y == (windowHeight-25)-75)) then
		Player.dy = -20
		Player.isFalling = true
	end

	-- Add forces
	Player.x = Player.x + Player.dx
	Player.y = Player.y + Player.dy

	-- Gravity
	if (Player.isFalling) then
		if (Player.dy == 0) then
			Player.isFalling = false
		else
			Player.dy = Player.dy + 1
		end
	end

	-- Check for screen wrap
	if (Player.x > windowWidth) then
		Player.x = 0
	elseif (Player.x < 0) then
		Player.x = windowWidth
	end
end

function love.draw()
	love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)
	for i=1,Platforms.totalPlatforms do
		love.graphics.rectangle('fill', Platforms.platforms[i].x, Platforms.platforms[i].y, Platforms.platforms[i].width,	Platforms.platforms[i].height)
	end
end


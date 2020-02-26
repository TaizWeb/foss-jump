Player = {
	x = (love.graphics.getWidth()-25)/2,
	y = (love.graphics.getHeight()-25)-75,
	height = 25,
	width = 25,
	dx = 0,
	dy = 0,
	ifFalling = false
}

function love.load()
	love.window.setTitle("Foss Jump")
	love.keyboard.setKeyRepeat(true)
	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()
end

function love.keypressed(key, scancode, isrepeat)
	if (key == "space" and not Player.isFalling) then
		Player.dy = -20
		Player.isFalling = true
	end
end

function love.update()
	if (not (Player.y >= (love.graphics.getHeight()-25)-75)) then
		Player.y = Player.y + 5
	end
	if ((Player.y == (love.graphics.getHeight()-25)-75)) then
		Player.dy = -20
		Player.isFalling = true
	end
	Player.x = Player.x + Player.dx
	Player.y = Player.y + Player.dy
	if (Player.isFalling) then
		if (Player.dy == 0) then
			Player.isFalling = false
		else
			Player.dy = Player.dy + 1
		end
	end
end

function love.draw()
	love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)
end


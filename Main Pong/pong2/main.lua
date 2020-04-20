--[import lib]
push = require 'push'	

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432

--[First function of the game; load all screen and others config]

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
    smallfont = love.graphics.newFont('font.ttf',8)
    love.graphics.setFont(smallfont)
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end

--[Close key function]

function love.keypressed(key)
    if key == 'escape' then
		love.event.quit()
	end
end

--[Screen graphics and text config]

function love.draw()
	push:apply('start')
	love.graphics.clear(81, 81, 81, 255)
	love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
	--[first paddle]
	love.graphics.rectangle('fill', 10, 30, 5, 20)
	--[Second paddle]
	love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)
	--[Ball]
	love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
	push:apply('end')
end

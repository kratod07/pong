--[import lib]
push = require 'push'	

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 900

VIRTUAL_HEIGHT = 386
VIRTUAL_WIDTH = 123

--[First function of the game; screen config]

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
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

--[Screen text config]

function love.draw()
	push:apply('start')
	love.graphics.printf(
		'Hola Chavez',
		0, --[ x Center based]
		VIRTUAL_HEIGHT / 2 - 6 , --[ y Starting halfway on the screen (Default font size on love2d is 12)]
		VIRTUAL_WIDTH, --[ Alignment with the entire window]
		'center')
	push:apply('end')
end

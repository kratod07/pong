
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

--[First function of the game; screen config]

function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end

--[Screen text config]

function love.draw()
	love.graphics.printf(
		'Hola Chavez',
		0, --[ x Center based]
		WINDOW_HEIGHT / 2 - 6 , --[ y Starting halfway on the screen (Default font size on love2d is 12)]
		WINDOW_WIDTH, --[ Alignment with the entire window]
		'center')
end

--[import lib]
push = require 'push'	

--[VARIABLES]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432

PADDLE_SPEED = 180

--[First function of the game; load all screen and others config]

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
    smallfont = love.graphics.newFont('font.ttf',8)
    scorefont = love.graphics.newFont('font.ttf',32)
    love.graphics.setFont(smallfont)
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
    })
    
    player1score = 0
    player2score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

end

--[Dt function on game render]
function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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
    love.graphics.setFont(smallfont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scorefont)
    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT /3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT /3)
	--[first paddle]
	love.graphics.rectangle('fill', 10, player1Y, 5, 20)
	--[Second paddle]
	love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
	--[Ball]
	love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
	push:apply('end')
end

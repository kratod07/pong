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

    math.randomseed(os.time())

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

    ballX = VIRTUAL_HEIGHT / 2 - 2
    ballY = VIRTUAL_WIDTH / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = 'start'
end

--[Dt function on game render]
function love.update(dt)

    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

--[keys function]

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else 
            gameState = 'start'

            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

--[Screen graphics and text config]

function love.draw()
    push:apply('start')
    
    love.graphics.clear(81, 81, 81, 255)

    love.graphics.setFont(smallfont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Play Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scorefont)

    love.graphics.print(tostring(player1score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT /3)

    love.graphics.print(tostring(player2score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT /3)

	--[first paddle]
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    
	--[Second paddle]
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
    
	--[Ball]
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    
    push:apply('end')
    
end
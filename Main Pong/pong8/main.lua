--[import lib]
push = require 'push'	

Class = require 'class'

require 'Paddle'

require 'Ball'

--[VARIABLES]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432

PADDLE_SPEED = 180

--[First function of the game; load all screen and others config]

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())

    smallfont = love.graphics.newFont('font.ttf',8)

    scorefont = love.graphics.newFont('font.ttf',32)

    love.graphics.setFont(smallfont)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
    })
    
    player1Score = 0
    player2Score = 0

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'
end

--[Dt function on game render]
function love.update(dt)
    --[Collision module]
    if gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.05
            ball.x = player1.x + 5
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.05
            ball.x = player2.x - 4
            if ball.dy < 0 then
                ball.dy = -math.random(10, 15)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy * 1.02
        end
        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy * 1.02
        end
    end
    --[score keep]
    if ball.x < 0 then
        servingPlayer = 1
        player2Score = player2Score + 1
        ball:reset()
        gameState= 'start'
    end

    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1Score = player1Score + 1
        ball:reset()
        gameState = 'start'
    end
    --[Key bindings]
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
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

            ball:reset()
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
    player1:render()
    
	--[Second paddle]
    player2:render()
    
	--[Ball]
    ball:render()

    --[Fps display]
    displayFPS()
    
    push:apply('end')
    
end

function displayFPS()
    love.graphics.setFont(smallfont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS' .. tostring(love.timer.getFPS()), 0, 0)
end
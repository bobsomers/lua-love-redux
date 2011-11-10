-- Some global "constants" for the size of the screen.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

-- Load our Player class.
love.filesystem.load("player.lua")()
love.filesystem.load("enemy.lua")()

function love.load()
    -- Set the background color for when we redraw the frame.
    love.graphics.setBackgroundColor(255, 255, 255)

    -- Seed the random number generator for a new experience every time!
    math.randomseed(os.time())

    -- Create a new player that accelerates at 300 pixels per second with 0.92
    -- friction.
    player = Player(300, 0.92)

    -- Create a new enemy that has a base speed of 100 pixels per second with
    -- multipliers of 1.5 and 2.0.
    enemy = Enemy(50, 1.5, 2.0)
end

function love.update(dt)
    -- Update the player.
    player:update(dt)

    -- Update the enemy.
    enemy:update(dt)
end

function love.draw()
    -- Draw the enemy.
    enemy:draw()

    -- Draw the player.
    player:draw()

    -- Draw the player's speed in the top left of the screen. Set the color to
    -- black so we can see the text, but then reset it to white so our images
    -- continue to draw properly.
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Speed: " .. math.floor(player.velocity:len()), 10, 10)
    love.graphics.setColor(255, 255, 255)
end

function love.keypressed(key)
    -- Quit the game when we press escape.
    if key == "escape" then
        love.event.push("q") -- quit
    end
end

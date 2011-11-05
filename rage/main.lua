-- Renaming some libraries for convenience.
local graphics = love.graphics
local mouse = love.mouse
local vector = require "hump.vector"

-- Some "constants" for the size of the screen.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

-- How much should we increase the players velocity? (in pixels per second)
PLAYER_ACCEL = 100

function love.load()
    -- Set the background color for when we redraw the frame.
    graphics.setBackgroundColor(255, 255, 255)

    -- Create a table to hold information about the player.
    player = {
        image = graphics.newImage("assets/determined.png"),
        position = vector(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2),
        velocity = vector(0, 0)
    }

end

function love.update(dt)
    -- If the player has their left mouse button down, add some velocity
    -- to the player in the direction from the player to the mouse.
    if mouse.isDown("l") then
        local player2mouse = vector(mouse.getX(), mouse.getY()) - player.position
        player2mouse:normalize_inplace()
        player.velocity = player.velocity + (player2mouse * PLAYER_ACCEL * dt)
    end 

    -- Update the player's position based on their current position and
    -- velocity.
    player.position = player.position + (player.velocity * dt)
end

function love.draw()
    -- Draw the player
    graphics.draw(player.image, player.position.x, player.position.y, 0, 1, 1,
        player.image:getWidth() / 2, player.image:getHeight() / 2)
end

function love.mousepressed(x, y, button)
    if button == "l" then
        local player2mouse = vector(x, y) - player.position
        player2mouse:normalize_inplace()
    end

end

function love.keypressed(key)
    -- Quit the game when we press escape.
    if key == "escape" then
        love.event.push("q") -- quit
    end
end

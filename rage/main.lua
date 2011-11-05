-- Renaming some libraries for convenience.
local gfx = love.graphics
local vector = require "hump.vector"

-- Some "constants" about our environment.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

function love.load()
    -- Set the background color for when we redraw the frame.
    gfx.setBackgroundColor(255, 255, 255)

    -- Create a table to hold information about the player.
    player = {
        image = gfx.newImage("assets/determined.png"),
        position = vector(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    }

end

function love.update(dt)

end

function love.draw()
    -- Draw the player
    gfx.draw(player.image, player.position.x, player.position.y, 0, 1, 1,
        player.image:getWidth() / 2, player.image:getHeight() / 2)
end

-- Renaming some libraries for convenience.
local graphics = love.graphics
local mouse = love.mouse
local vector = require "hump.vector"

-- Some "constants" for the size of the screen.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

-- How much should we increase the players velocity? (in pixels per second)
PLAYER_ACCEL = 300

-- How much velocity should we retain, every update? Think of this as a
-- percentage of the last update's velocity.
PLAYER_FRICTION = 0.92

function love.load()
    -- Set the background color for when we redraw the frame.
    graphics.setBackgroundColor(255, 255, 255)

    -- Create a table to hold information about the player.
    player = {
        image = graphics.newImage("assets/determined.png"),
        position = vector(SCREEN_WIDTH * 3 / 4, SCREEN_HEIGHT * 3 / 4),
        velocity = vector(0, 0)
    }

    -- Create some tables to hold information about the enemies.
    level_images = {
        graphics.newImage("assets/happy.png")
    }
    enemies = {}
    enemies[#enemies + 1] = {
        position = vector(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4)
    }

end

function love.update(dt)
    if mouse.isDown("l") then
        -- If the player has their left mouse button down, add some velocity
        -- to the player in the direction from the player to the mouse.
        local player2mouse = vector(mouse.getX(), mouse.getY()) - player.position
        player2mouse:normalize_inplace()
        player.velocity = player.velocity + (player2mouse * PLAYER_ACCEL * dt)
    else
        -- If the player *doesn't* have their left mouse button down, bleed off
        -- velocity to simulate friction.
        player.velocity = player.velocity * PLAYER_FRICTION;
    end

    -- Update the player's position based on their current position and
    -- velocity.
    player.position = player.position + (player.velocity * dt)
end

function love.draw()
    -- Draw the enemies.
    for i, v in ipairs(enemies) do
        graphics.draw(level_images[1], v.position.x, v.position.y, 0, 1, 1,
            level_images[1]:getWidth() / 2, level_images[1]:getHeight() / 2)
    end

    -- Draw the player.
    local player_direction = 1
    if mouse.getX() < player.position.x then
        player_direction = -1
    end
    graphics.draw(player.image, player.position.x, player.position.y, 0,
        0.3 * player_direction, 0.3,
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

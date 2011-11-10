-- Some global "constants" for the size of the screen.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

-- Load our Player class.
love.filesystem.load("player.lua")()

function love.load()
    -- Set the background color for when we redraw the frame.
    love.graphics.setBackgroundColor(255, 255, 255)

    -- Seed the random number generator for a new experience every time!
    math.randomseed(os.time())

    -- Create a new player that accelerates at 300 pixels per second with 0.92
    -- friction.
    player = Player(300, 0.92)

    -- Create some tables to hold information about the enemies.
    --[[
    level_images = {
        graphics.newImage("assets/happy.png")
    }
    enemies = {}
    enemies[1] = {
        position = vector(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4),
        velocity = vector((math.random() * 2) - 1, (math.random() * 2) - 1):normalize_inplace() * LEVEL1_SPEED
    }
    --]]
end

function love.update(dt)
    -- Update the player.
    player:update(dt)

    --[[
    -- Update the enemies' positions.
    for i, enemy in ipairs(enemies) do
        enemy.position = enemy.position + (enemy.velocity * dt)

        -- Constrain the enemies to the screen.
        local halfWidth = level_images[1]:getWidth() / 2
        local halfHeight = level_images[1]:getHeight() / 2
        if enemy.position.x - halfWidth < 0 then
            enemy.position.x = 0 + halfWidth
            enemy.velocity.x = enemy.velocity.x * -1
        elseif enemy.position.x + halfWidth > SCREEN_WIDTH then
            enemy.position.x = SCREEN_WIDTH - halfWidth
            enemy.velocity.x = enemy.velocity.x * -1
        end
        if enemy.position.y - halfHeight < 0 then
            enemy.position.y = 0 + halfHeight
            enemy.velocity.y = enemy.velocity.y * -1
        elseif enemy.position.y + halfHeight > SCREEN_HEIGHT then
            enemy.position.y = SCREEN_HEIGHT - halfHeight
            enemy.velocity.y = enemy.velocity.y * -1
        end
    end
    --]]
end

function love.draw()
    --[[
    -- Draw the enemies.
    for i, v in ipairs(enemies) do
        graphics.draw(level_images[1], v.position.x, v.position.y, 0, 1, 1,
            level_images[1]:getWidth() / 2, level_images[1]:getHeight() / 2)
    end
    --]]

    -- Draw the player.
    player:draw()
end

function love.keypressed(key)
    -- Quit the game when we press escape.
    if key == "escape" then
        love.event.push("q") -- quit
    end
end

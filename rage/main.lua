-- Some global "constants" for the size of the screen.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

-- Have we won the game?
game_won = false

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

    -- Create a new enemy that has a base speed of 50 pixels per second with
    -- multipliers of 1.5 and 2.0.
    enemy = Enemy(50, 1.5, 2.0)

    -- Create some fonts for our UI
    small_font = love.graphics.newFont("assets/oldpress.ttf", 48)
    large_font = love.graphics.newFont("assets/oldpress.ttf", 72)
end

function love.update(dt)
    -- Don't do anything if we already won.
    if game_won then
        return
    end

    -- Update the enemy.
    enemy:update(dt)

    -- Update the player.
    player:update(dt)

    -- Check to see if the player and enemy are colliding. We'll treat them
    -- both as circles, so we can simple check to see if the distance between
    -- their centers is less than their combined radii.
    local distance = player.position:dist(enemy.position)
    local player_radius = player.image:getWidth() / 2
    local enemy_radius = enemy.images[enemy.level]:getWidth() / 2
    if distance < player_radius + enemy_radius then
        -- We only level up if the player's speed was at least 400
        if player.velocity:len() >= 400 then
            level_up()
        end
    end
end

function love.draw()
    -- Draw the enemy.
    enemy:draw()

    -- Draw the player.
    player:draw()

    -- Draw the some info in the top left of the screen. Set the draw color to
    -- black so we can see the text.
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(small_font)
    love.graphics.print("Speed: " .. math.floor(player.velocity:len()), 20, 10)
    love.graphics.print("Level: " .. enemy.level, 20, 60)

    -- If we won, display our win message.
    if game_won then
        love.graphics.setColor(255, 0, 0)
        love.graphics.setFont(large_font)
        love.graphics.print("FFFFFFFUUUUUUUUUUUU", 180, 200)
        love.graphics.print("YOU WIN", 320, 300)
    end

    -- Reset the draw color to white so our images draw properly.
    love.graphics.setColor(255, 255, 255)
end

function love.keypressed(key)
    -- Quit the game when we press escape.
    if key == "escape" then
        love.event.push("q") -- quit
    end
end

function level_up()
    if enemy.level >= 3 then
        game_won = true
    else
        -- Level up the enemy.
        enemy.level = enemy.level + 1
        
        -- Reset the player and enemy.
        player:reset()
        enemy:reset()
    end
end

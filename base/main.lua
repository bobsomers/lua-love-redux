-- Some global "constants" for the size of the screen.
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

-- Have we won the game?
game_won = false

-- Load our Player and Enemy classes.
love.filesystem.load("player.lua")()
love.filesystem.load("enemy.lua")()

function love.load()
    -- TODO
end

function love.update(dt)
    -- TODO
end

function love.draw()
    love.graphics.print("Hello, CPGD!", 100, 100)

    -- TODO
end

function love.keypressed(key)
    -- Quit the game when we press escape.
    if key == "escape" then
        love.event.push("q") -- quit
    end
end

function level_up()
    -- TODO
end

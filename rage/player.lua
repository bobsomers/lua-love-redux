-- Let's use the class mechanism from HUMP.
local Class = require "hump.class"

-- And the vector helper!
local Vector = require "hump.vector"

-- Define our player's constructor.
Player = Class(function(self, accel, friction)
    -- How much should we increase the player's velocity? (in pixels per second)
    self.accel = accel

    -- How much velocity should we retain, every update? Think of this as a
    -- percentage of the last update's velocity.
    self.friction = friction

    -- Load the image that will represent the player.
    self.image = love.graphics.newImage("assets/determined.png")

    -- Where should the player spawn?
    self.position = Vector(SCREEN_WIDTH * 3 / 4, SCREEN_HEIGHT * 3 / 4)

    -- What should the player's initial velocity be?
    self.velocity = Vector(0, 0)
end)

function Player:update(dt)
    if love.mouse.isDown("l") then
        -- The player has their left mouse button down, so let's add some
        -- velocity to the player in the direction from the player to the
        -- mouse pointer.
        local player2mouse = Vector(love.mouse.getX(), love.mouse.getY()) - self.position
        player2mouse:normalize_inplace()
        self.velocity = self.velocity + (player2mouse * self.accel * dt)
    else
        -- The player doesn't have their left mouse button down, so let's bleed
        -- off some velocity to simulate friction.
        self.velocity = self.velocity * self.friction
    end

    -- Update the player's position based on their current position and their
    -- velocity.
    self.position = self.position + (self.velocity * dt)
end

function Player:draw()
    -- We'll "scale" our image on the X axis by either +1 or -1, depending on
    -- which way he needs to be facing to look at the mouse.
    local facing = 1
    if love.mouse.getX() < self.position.x then
        facing = -1
    end

    -- Draw our player at position (x, y) with no rotation, 1.0 scale on the Y
    -- axis and "facing" scale on the X axis, and defining the center of our
    -- player to be in the center of the image.
    love.graphics.draw(self.image,
        self.position.x, self.position.y,
        0,
        facing, 1,
        self.image:getWidth() / 2, self.image:getHeight() / 2)
end

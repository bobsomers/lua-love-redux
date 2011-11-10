-- Let's use the class mechanism from HUMP.
local Class = require "hump.class"

-- And the vector helper!
local Vector = require "hump.vector"

Enemy = Class(function(self, speed, multiplier1, multiplier2)
    -- What is the base speed of our enemy? (in pixels per second)
    self.speed = speed

    -- Let's store our multipliers in an array.
    self.multipliers = {
        1.0, -- base multiplier
        multiplier1,
        multiplier2
    }

    -- Load the images that will represent the enemy into an array.
    self.images = {
        love.graphics.newImage("assets/happy.png"),
        love.graphics.newImage("assets/confused.png"),
        love.graphics.newImage("assets/rage.png")
    }

    -- Let's keep track of the current "level", which is also conveniently
    -- the index into the multipliers and images arrays.
    self.level = 1

    -- Where should the enemy spawn?
    self.position = Vector(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4)

    -- Let's make his starting direction random. We do this by choosing two
    -- random numbers between -1 and +1, and using them as X and Y parameters
    -- for a vector. We then normalize this direction vector (to make it unit
    -- length).
    self.direction = Vector((math.random() * 2) - 1, (math.random() * 2) - 1)
    self.direction:normalize_inplace()
end)

function Enemy:reset()
    self.position = Vector(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4)
    self.direction = Vector((math.random() * 2) - 1, (math.random() * 2) - 1)
    self.direction:normalize_inplace()
end

function Enemy:update(dt)
    -- Compute the velocity vector by multiplying our direction vector (which
    -- is unit length) by the base speed times the current multiplier.
    local velocity = self.direction * (self.speed * self.multipliers[self.level] * dt)

    -- Update the enemy's position.
    self.position = self.position + velocity

    -- Constrain the enemy's movement to the bounds of the screen. Account for
    -- his width and height by adding his halfWidth and halfHeight to his
    -- position (since we consider his position in the center of the image.
    local halfWidth = self.images[self.level]:getWidth() / 2
    local halfHeight = self.images[self.level]:getHeight() / 2
    if self.position.x - halfWidth < 0 then
        self.position.x = 0 + halfWidth
        self.direction.x = self.direction.x * -1
    elseif self.position.x + halfWidth > SCREEN_WIDTH then
        self.position.x = SCREEN_WIDTH - halfWidth
        self.direction.x = self.direction.x * -1
    end
    if self.position.y - halfHeight < 0 then
        self.position.y = 0 + halfHeight
        self.direction.y = self.direction.y * -1
    elseif self.position.y + halfHeight > SCREEN_HEIGHT then
        self.position.y = SCREEN_HEIGHT - halfHeight
        self.direction.y = self.direction.y * -1
    end
end

function Enemy:draw()
    -- We'll "scale" our image on the X axis by either +1 or -1, depending on
    -- which way he needs to be facing to look in his direction of travel.
    local facing = 1
    if self.direction.x < 0 then
        facing = -1
    end

    -- Draw the enemy at position (x, y) with no rotation, 1.0 scale on the Y
    -- axis and "facing" scale on the X axis, and defining the center of our
    -- enemy to be in the center of the image.
    love.graphics.draw(self.images[self.level],
        self.position.x, self.position.y,
        0,
        facing, 1,
        self.images[self.level]:getWidth() / 2, self.images[self.level]:getHeight() / 2)
end

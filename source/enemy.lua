import 'player'

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, speed, direction)
    local enemyImage = gfx.image.new("images/enemy")
    assert( enemyImage )

    self:setImage(enemyImage)
    self:moveTo(x, y)
    self:setCollideRect(0, 0, 16, 16)
    self.speed = speed
    self.direction = direction
    self:add()
end

function Enemy:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.direction, self.y +(self.speed * enemySpeedMultiplier))

-- Collision Logic
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']

            if collidedObject:isa(Player) then
                self:remove()
                collidedObject:remove()
                resetPlayer()
            end
        end
    end


    -- avoid walls
    if (self.x >= 384) then

        self.direction = math.random(-3,0)
    end

    if (self.x <= 16) then

        self.direction = math.random(0,3)
    end
    -- remove enemies from off screen
    if (self.y > 240) then
        self:remove()
    end
end

-- enemy collisions are overlapping currently but may want to bounce off each other
function Enemy:collisionResponse()
    return 'overlap'
end
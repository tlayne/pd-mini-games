import 'player'

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(AnimatedSprite)

function Enemy:init(x, y, speed, direction)
    local enemyTable = gfx.imagetable.new("images/enemy-table-32-32")
    --local enemyImage = gfx.image.new("images/enemy")
    --assert( enemyImage )
    --below translates to sprite = AnimatedSprite.new(path)
    Enemy.super.init(self, enemyTable)

    self:addState("exist", 1, 4, {tickStep = 2})
    self:addState("cease", 5, 9, {tickStep = 2})
    self:setDefaultState('exist')
    self:playAnimation()
    self:moveTo(x, y)
    self:setCollideRect(6, 3, 23, 23)
    self.speed = speed
    self.direction = direction
    self:add()
end

function Enemy:update()
    --required to update animation frames... duh
    self:updateAnimation()
    
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.direction, self.y +(self.speed * enemySpeedMultiplier))

-- Collision Logic
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']

            if collidedObject:isa(Player) then
                resetPlayer(collidedObject)
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

-- check if enemy is on screen
-- experimental and not used currently
--function screenEnemies()
--    local allSprites = gfx.sprite.getAllSprites()
--    for index, sprite in ipairs(allSprites) do
--        if sprite:isa(Enemy) then
--            if sprite.y > -10 then
--                return true
--            end
--        end
--    end
-- end

-- enemy collisions are overlapping currently but may want to bounce off each other
function Enemy:collisionResponse()
    return 'overlap'
end
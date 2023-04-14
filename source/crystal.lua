import 'player'

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Crystal').extends(AnimatedSprite)

function Crystal:init(x, y, speed, tier)
    local crystalTable = gfx.imagetable.new("images/crystal-table-16-16")
    --local enemyImage = gfx.image.new("images/enemy")
    --assert( enemyImage )
    --below translates to sprite = AnimatedSprite.new(path)
    Crystal.super.init(self, crystalTable)

    self:addState("pure", 1, 1, {tickStep = 2})
    self:addState("cracked", 2, 2, {tickStep = 2})
    self:addState("shattered", 3, 3, {tickStep = 2})
    self:addState("data", 4, 4, {tickStep = 2})
    self:addState("collect", 5, 5, {tickStep = 2})
    self:setDefaultState('pure')
    self:playAnimation()
    self:moveTo(x, y)
    self:setCollideRect(0, 0, 16, 16) -- (only set if state is data)
    self.speed = speed
    self.tier = tier
    self.direction = 0.1
    self:setZIndex(-1)
    self:add()
end

function Crystal:update()
    --required to update animation frames... duh
    self:updateAnimation()
    
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.direction, self.y + self.speed)

-- Collision Logic
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']

            if collidedObject:isa(Player) then
                if self.currentState == "data" then
                    self:changeState("collect")
                    self.direction = collidedObject.x
                    self.speed = collidedObject.speed
                    self.states.collect.onLoopFinishedEvent = function(self)
                        self:remove()
                        self.tier = true
                        print(self.tier)
                    end 
                else 
                    function collidedObject:collisionResponse()
                        return 'overlap'
                    end
                end
            end
        end
    end

    -- remove from off screen
    if (self.y > 240) then
        self:remove()
    end
end


function collectCrystal()


end

-- Clear all crystals from the screen
function clearCrystals()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Crystal) then
            sprite:remove()
        end
    end
end

-- enemy collisions should overlap
function Enemy:collisionResponse()
    return 'overlap'
end
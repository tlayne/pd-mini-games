import 'player'

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Crystal').extends(AnimatedSprite)

function Crystal:init(x, y, speed, direction)
    local crystalTable = gfx.imagetable.new("images/crystal-24-24")
    --local enemyImage = gfx.image.new("images/enemy")
    --assert( enemyImage )
    --below translates to sprite = AnimatedSprite.new(path)
    Crystal.super.init(self, crystalTable)

    self:addState("pure", 1, 4, {tickStep = 2})
    self:addState("cracked", 5, 9, {tickStep = 2})
    self:addState("shattered", 5, 9, {tickStep = 2})
    self:addState("data", 5, 9, {tickStep = 2})
    self:addState("collect", 5, 9, {tickStep = 2})
    self:setDefaultState('pure')
    self:playAnimation()
    self:moveTo(x, y)
    self:setCollideRect(6, 3, 23, 23) -- (only set if state is data)
    self.speed = speed
    self.direction = direction
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
                print("get")
            end
        end
    end

    -- remove from off screen
    if (self.y > 240) then
        self:remove()
    end
end


-- enemy collisions should overlap
function Enemy:collisionResponse()
    return 'overlap'
end
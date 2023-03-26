local pd <const> = playdate
local gfx <const> = pd.graphics

class('Laser').extends(gfx.sprite)

function Laser:init(x, y, speed, direction)
    local laserImage = gfx.image.new(2,5)
    gfx.pushContext(laserImage)
        gfx.drawRect(0,0,2,5)
    gfx.popContext(laserImage)
    self:setImage(laserImage)

    self:setCollideRect(0,0, self:getSize())
    self.speed = speed
    self.direction = direction
    self:moveTo(x, y)
    self:add()
end

function Laser:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.direction, self.y - self.speed)
    
    -- Collision Logic
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']

            if collidedObject:isa(Enemy) then
                collidedObject:remove()
                incrementScore()
                shipPower = shipPower + 1
                if (shipPower == 5 or shipPower == 10 or shipPower == 20) then
                    setCrankUI(true)
                    crankyTimer = pd.timer.performAfterDelay(3600, function()
                        setCrankUI(false)
                    end)
                end
            end
        end
        self:remove()
    elseif (self.y < 0) then
        self:remove()
    end
end

function laserLimit()
    local laserActive = 0
    local allSprites = gfx.sprite.getAllSprites()
    
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Laser) then
            laserActive = laserActive + 1
        end
    end

    return laserActive
end

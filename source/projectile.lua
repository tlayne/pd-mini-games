local pd <const> = playdate
local gfx <const> = pd.graphics

class('Projectile').extends(gfx.sprite)

function Projectile:init(x, y, speed, direction)
    local projectileSize = 2
    local projectileImage = gfx.image.new(projectileSize * 2, projectileSize * 2)
    gfx.pushContext(projectileImage)
        gfx.drawCircleAtPoint(projectileSize, projectileSize, projectileSize)
    gfx.popContext(projectileImage)
    self:setImage(projectileImage)

    self:setCollideRect(0,0, self:getSize())
    self.direction = direction
    self.speed = speed
    self:moveTo(x, y)
    self:add()
end

function Projectile:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.direction, self.y - self.speed)
    
    -- Collision Logic
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']

            if collidedObject:isa(Enemy) then
                kill:play()
                collidedObject:remove()
                self:remove()
                incrementScore()
                shipPower = shipPower + 1
                if (shipPower == 5 or shipPower == 10 or shipPower == 20 or shipPower == 40) then
                    setCrankUI(true)
                    crankyTimer = pd.timer.performAfterDelay(4200, function()
                        setCrankUI(false)
                    end)
                end
            end
        end
    elseif (self.y < 0) then
        self:remove()
    end
end

function projectileLimit()
    local projectileActive = 0
    local allSprites = gfx.sprite.getAllSprites()
    
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Projectile) then
            projectileActive = projectileActive + 1
        end
    end

    return projectileActive
end

function Projectile:collisionResponse()
    return 'overlap'
end
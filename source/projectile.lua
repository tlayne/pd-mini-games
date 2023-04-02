local pd <const> = playdate
local gfx <const> = pd.graphics

class('Projectile').extends(gfx.sprite)

function Projectile:init(x, y, speed, direction)
    -- local projectileSize = 2
    -- local projectileImage = gfx.image.new(projectileSize * 2, projectileSize * 2)
    -- gfx.pushContext(projectileImage)
    --     gfx.fillCircleAtPoint(projectileSize, projectileSize, projectileSize)
    -- gfx.popContext(projectileImage)
    bulletTable = gfx.imagetable.new("images/bullet-table-6-6")
   

    self:setImage(bulletTable[1])
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
                self:remove()
                kill:play()
                collidedObject:forceNextAnimation(true, "cease")
                collidedObject.speed = 0
                collidedObject.direction = 0
                killTimer = pd.timer.performAfterDelay(200, function()
                    collidedObject:remove()
                end)
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
    end

    -- remove projectiles from off screen
    if (self.y < 0) then
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
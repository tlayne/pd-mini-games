local pd <const> = playdate
local gfx <const> = pd.graphics

class('Projectile').extends(gfx.sprite)

function Projectile:init(x, y, speed)
    local projectileSize = 2
    local projectileImage = gfx.image.new(projectileSize * 2, projectileSize * 2)
    gfx.pushContext(projectileImage)
        gfx.drawCircleAtPoint(projectileSize, projectileSize, projectileSize)
    gfx.popContext(projectileImage)
    self:setImage(projectileImage)

    self:setCollideRect(0,0, self:getSize())
    self.speed = speed
    self:moveTo(x, y)
    self:add()
end

function Projectile:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y - self.speed)
    
    -- Collision Logic
    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']

            if collidedObject:isa(Enemy) then
                collidedObject:remove()
            end
        end
        self:remove()
    elseif (self.y < 0) then
        self:remove()
    end
end

-- need to clear projectiles when they go off screen at some point
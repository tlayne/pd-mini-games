local pd <const> = playdate
local gfx <const> = pd.graphics

-- display lifesprite 2 times
-- remove lifesprite if player dies

local lifeSprite1
local lifeSprite2

function createLifeDisplay()
    
    lifeCount = 2
    lifeImage = gfx.image.new("images/life")
    assert( lifeImage )

    lifeSprite1 = gfx.sprite.new(lifeImage)
    lifeSprite1:setImage(lifeImage)
    lifeSprite1:setCenter(0, 0)
    lifeSprite1:moveTo(10, 230)
    lifeSprite1:add()

    lifeSprite2 = gfx.sprite.new(lifeImage)
    lifeSprite2:setImage(lifeImage)
    lifeSprite2:setCenter(0, 0)
    lifeSprite2:moveTo(20, 230)
    lifeSprite2:add()
end

function resetLife()
    lifeCount = 2
end 

function loseLife()
    lifeCount -= 1
    if (lifeCount == 1) then
        lifeSprite2:remove()
    elseif (lifeCount == 0) then
        lifeSprite1:remove()
    else
        print(lifeCount)
    end
end
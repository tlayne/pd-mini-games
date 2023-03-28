local pd <const> = playdate
local gfx <const> = pd.graphics

local powerSprite1
local powerSprite2
local powerSprite3
local powerSprite4
local bombSprite

function createPowerDisplay()
    
    shipPower = 0
    powerUpTable = gfx.imagetable.new("images/power-table-15-7")

    powerSprite1 = gfx.sprite.new()
    powerSprite1:setImage( powerUpTable[1] )
    powerSprite1:setCenter(0, 0)
    powerSprite1:moveTo(30, 230)
    powerSprite1:add()

    powerSprite2 = gfx.sprite.new()
    powerSprite2:setImage( powerUpTable[2] )
    powerSprite2:setCenter(0, 0)
    powerSprite2:moveTo(30, 230)

    powerSprite3 = gfx.sprite.new()
    powerSprite3:setImage( powerUpTable[3] )
    powerSprite3:setCenter(0, 0)
    powerSprite3:moveTo(30, 230)

    powerSprite4 = gfx.sprite.new()
    powerSprite4:setImage( powerUpTable[4] )
    powerSprite4:setCenter(0, 0)
    powerSprite4:moveTo(30, 230)

    bombImage = gfx.image.new('images/bomb')
    bombSprite = gfx.sprite.new()
    bombSprite:setImage(bombImage)
    bombSprite:setCenter(0, 0)
    bombSprite:moveTo(50, 230)
end

function useBomb()
    clearEnemies()
    bombSprite:remove()
    bombCount = 0
end

function resetPower()
    shipPower = 0
    powerLevel = "stage1"
    powerSprite2:remove()
    powerSprite3:remove()
    powerSprite4:remove()
end 

function increasePower()
    if (powerLevel == "stage1") then
        powerLevel = "stage2"
    elseif (powerLevel == "stage2") then
        powerLevel = "stage3"
    elseif (powerLeve == "stage3") then
        powerLevel = "stage4"
    else
        if (bombCount == 0) then
            bombCount += 1
        end
    end
end

-- resetPower in the loselife function from lifedisplay
function powerDisplayUpdate()
    if (shipPower >= 5 and shipPower < 10) then
        spin:play()
        powerLevel = "stage2"
        powerSprite2:add()
        setCrankUI(false)
    elseif (shipPower >= 10 and shipPower < 20) then
        spin:play()
        powerLevel = "stage3"
        powerSprite2:remove()
        powerSprite3:add()
        setCrankUI(false)
    elseif (shipPower >= 20 and powerLevel ~= "stage4") then
        spin:play()
        powerLevel = "stage4"
        powerSprite3:remove()
        powerSprite4:add()
        setCrankUI(false)
    -- This triggers repeatedly upon reaching 40+ need to limit it somehow
    elseif (shipPower >= 40 and powerLevel == "stage4") then
        if (bombCount == 0) then
            bombCount += 1
            spin:play()
            bombSprite:add()
        end
    end
end
local pd <const> = playdate
local gfx <const> = pd.graphics

local powerSprite1
local powerSprite2
local powerSprite3
local powerSprite4

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

end

function resetPower()
    shipPower = 0
    powerSprite2:remove()
    powerSprite3:remove()
    powerSprite4:remove()
end 

-- resetPower in the loselife function from lifedisplay
function powerDisplayUpdate()
    if (shipPower >= 5 and shipPower < 10) then
        powerSprite2:add()
        setCrankUI(false)
    elseif (shipPower >= 10 and shipPower < 20) then
        powerSprite2:remove()
        powerSprite3:add()
        setCrankUI(false)
    elseif (shipPower >= 20) then
        powerSprite3:remove()
        powerSprite4:add()
        setCrankUI(false)
    end
end
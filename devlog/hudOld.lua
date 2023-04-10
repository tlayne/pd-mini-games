-- just change this to an animated sprite >:-(
local pd <const> = playdate
local gfx <const> = pd.graphics

function setHud()

    hudTable = gfx.imagetable.new("images/hud-table-400-30")
    hudSprite = gfx.sprite.new()
    hudAnimation = gfx.animation.loop.new(400, hudTable)
    hudSprite:setImage(hudTable[1])
    hudSprite:setCenter(0, 0)
    hudSprite:setZIndex(5)
    hudSprite:moveTo(0, 210)
    hudSprite:add()

end



    function hudAlert()
        hudSprite.update = function()
            hudAnimation.startFrame = 1
            hudAnimation.endFrame = 2
            hudAnimation.shouldLoop = true
            hudAnimation.delay = 400
            hudSprite:setImage(hudAnimation:image())
            hudCharge()
        end
    end


    function hudCharge()
       
    local crankChange, accCrankChange = pd.getCrankChange()

        if (accCrankChange >= 1 and crankStat == true) then
            hudAnimation.startFrame = 3
            hudAnimation.endFrame = 38
            hudAnimation.shouldLoop = false
-- i can multiply delay and accCrankChange to dynamically change this?
            hudAnimation.delay = 4000
            hudAnimation.frame = 3
            hudSprite:setImage(hudAnimation:image())
            print(accCrankChange)
            
            if (hudAnimation.frame == 38) then
                powerDisplayUpdate()
            end

            if (accCrankChange == 0) then
                hudAnimation.paused = true
                hudAnimation.startFrame = hudAnimation.frame
                hudAnimation.endFrame = 1
                hudAnimation.delay = 400
                hudSprite:setImage(hudAnimation:image())
                pd.timer.performAfterDelay(500, function()
                    hudAnimation.paused = false
                end)
                if (hudAnimation.frame == 1) then
                    hudAlert()
                end

            end
        end
    end

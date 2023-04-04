local pd <const> = playdate
local gfx <const> = pd.graphics

function setHud()

    hudTable = gfx.imagetable.new("images/hud-table-400-30")
    hudSprite = gfx.sprite.new()
    hudAnimation = gfx.animation.loop.new(400, hudTable)
    hudAnimation.startFrame = 1
    hudAnimation.endFrame = 2
    hudSprite:setImage(hudTable[1])
    hudSprite:setCenter(0, 0)
    hudSprite:setZIndex(5)
    hudSprite:moveTo(0, 210)
    hudSprite:add()

end

function hudAlert()
    hudSprite.update = function()
        if crankStat == true then
            hudSprite:setImage(hudAnimation:image())
        end
    end
end

function hudCharge()

end
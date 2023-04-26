local pd <const> = playdate
local gfx <const> = pd.graphics

function createAchievementDisplay()

    cheevBg = gfx.image.new("images/bgcheevo")
    cheevImg = gfx.image.new("images/crystalFill")
    
    cheevBgSprite = gfx.sprite.new()
    cheevBgSprite:setImage(cheevBg)
    cheevBgSprite:setCenter(0,0)
    cheevBgSprite:moveTo(0,0)
    cheevBgSprite:setZIndex(-100)
    cheevBgSprite:add()

end

-- This works! Still need to program for all achievement text
-- The button needs to be drawn in white and rotated
function updateAchievementDisplay()

    local cheevXTable = {46, 79, 112, 145, 254, 303, 254, 303, 254, 303}
    local cheevYTable = {67, 67, 67, 67, 64, 64, 97, 97, 130, 130}
    local iter = 1
    for achievement, boo in pairs(achievements) do
        if (achievements[achievement] == true) then
            cheevX = cheevXTable[iter]
            cheevY = cheevYTable[iter]
            gfx.pushContext(cheevBg)
                cheevImg:draw(cheevX,cheevY)
            gfx.popContext()
            iter += 1
        end
    end
    cheevBgSprite:setImage(cheevBg)

end
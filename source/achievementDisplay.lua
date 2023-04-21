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

-- This works! Still need to program for all achievements and update playGameButton
-- The button needs to be drawn in white and rotated
function updateAchievementDisplay()

    print(achievements.first)
    if (achievements.first == true) then
        gfx.pushContext(cheevBg)
            cheevImg:draw(46,67)
        gfx.popContext()
        cheevBgSprite:setImage(cheevBg)
    end

end
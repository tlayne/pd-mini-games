local pd <const> = playdate
local gfx <const> = pd.graphics

function setScrollingBackground()
    local backgroundImage1 = gfx.image.new("images/background1")
    local backgroundImage2 = gfx.image.new("images/background2")
    local backgroundSprite1 = gfx.sprite.new (backgroundImage1)
    local backgroundSprite2 = gfx.sprite.new(backgroundImage2)
    local scrollSpeed = 0.7

    backgroundSprite1:setCenter(0, 1)
    backgroundSprite1:moveTo (0, 240)
    backgroundSprite1:setZIndex(-1000)
    backgroundSprite1:add()
    backgroundSprite2:setCenter (0, 1)
    backgroundSprite2:moveTo (0, -719)
    backgroundSprite2:setZIndex(-1000)
    backgroundSprite2:add()

    function backgroundSprite1:update()
        backgroundSprite1:moveBy(0, scrollSpeed)
        if (backgroundSprite2.y >= 240 and backgroundSprite2.y <= 250) then
            backgroundSprite1: moveTo(0, backgroundSprite2.y - 960)
        end
    end

    function backgroundSprite2:update()
        backgroundSprite2:moveBy(0, scrollSpeed)
        if (backgroundSprite1.y >= 240 and backgroundSprite1.y <= 250) then
            backgroundSprite2:moveTo(0,backgroundSprite1.y - 960)
        end
    end
end
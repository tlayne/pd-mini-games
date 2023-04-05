local pd <const> = playdate
local gfx <const> = pd.graphics

function setScrollingBackground()
    local backgroundImage1 = gfx.image.new("images/background1")
    local backgroundImage2 = gfx.image.new("images/background2")
    local planetsImage = gfx.image.new("images/bgplanets")
    local backgroundSprite1 = gfx.sprite.new (backgroundImage1)
    local backgroundSprite2 = gfx.sprite.new(backgroundImage2)
    local backgroundPlanets = gfx.sprite.new(planetsImage)
    local scrollSpeed = 0.7
    local planetSpeed = 1

    backgroundSprite1:setCenter(0, 1)
    backgroundSprite1:moveTo (0, 240)
    backgroundSprite1:setZIndex(-1000)
    backgroundSprite1:add()

    backgroundSprite2:setCenter(0, 1)
    backgroundSprite2:moveTo (0, -719)
    backgroundSprite2:setZIndex(-1000)
    backgroundSprite2:add()

    backgroundPlanets:setCenter(0,1)
    backgroundPlanets:moveTo(0,-100)
    backgroundPlanets:setZIndex(-500)
    backgroundPlanets:add()

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

    function backgroundPlanets:update()
        backgroundPlanets:moveBy(0, planetSpeed)
        if (backgroundPlanets.y > 1200) then
            backgroundPlanets:moveTo(0, -480)
        end
    end
end
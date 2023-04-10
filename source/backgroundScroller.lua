local pd <const> = playdate
local gfx <const> = pd.graphics

function setScrollingBackground()

    math.randomseed(pd.getSecondsSinceEpoch())

    local backgroundImage1 = gfx.image.new("images/background1")
    --local backgroundImage2 = gfx.image.new("images/background2")
    local planetsImage = gfx.image.new("images/bgplanets")
    local nearStarsImage = gfx.image.new("images/bgstars1")
    local backgroundSprite1 = gfx.sprite.new (backgroundImage1)
    local backgroundSprite2 = gfx.sprite.new(backgroundImage1)
    local backgroundPlanets = gfx.sprite.new(planetsImage)
    local nearStars1 = gfx.sprite.new(nearStarsImage)
    local nearStars2 = gfx.sprite.new(nearStarsImage)
    local scrollSpeed = 0.7
    local starSpeed = 1
    local planetSpeed = 1.3
    local planetLocation = math.random(200, 600)

    backgroundSprite1:setCenter(0, 1)
    backgroundSprite1:moveTo (0, 240)
    backgroundSprite1:setZIndex(-1000)
    backgroundSprite1:add()

    backgroundSprite2:setCenter(0, 1)
    backgroundSprite2:moveTo (0, -719)
    backgroundSprite2:setZIndex(-1000)
    backgroundSprite2:add()

    nearStars1:setCenter(0, 1)
    nearStars1:moveTo (0, 240)
    nearStars1:setZIndex(-500)
    nearStars1:add()

    nearStars2:setCenter(0, 1)
    nearStars2:moveTo (0, -719)
    nearStars2:setZIndex(-500)
    nearStars2:add()

    backgroundPlanets:setCenter(1,1)
    backgroundPlanets:moveTo(planetLocation,-100)
    backgroundPlanets:setZIndex(-300)
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

    function nearStars1:update()
        nearStars1:moveBy(0, starSpeed)
        if (nearStars2.y >= 240 and nearStars2.y <= 250) then
            nearStars1: moveTo(0, nearStars2.y - 960)
        end
    end

    function nearStars2:update()
        nearStars2:moveBy(0, starSpeed)
        if (nearStars1.y >= 240 and nearStars1.y <= 250) then
            nearStars2:moveTo(0,nearStars1.y - 960)
        end
    end

    function backgroundPlanets:update()
        backgroundPlanets:moveBy(0, planetSpeed)
        if (backgroundPlanets.y > 1200) then
            backgroundPlanets:moveTo(planetLocation, -480)
        end
    end
end
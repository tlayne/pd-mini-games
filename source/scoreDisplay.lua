local pd <const> = playdate
local gfx <const> = pd.graphics
local scoreSprite

function createScoreDisplay()
    scoreSprite = gfx.sprite.new()
    score = 0
    scoreSprite:setCenter(0, 0)
    scoreSprite:moveTo(310, 4)
    scoreSprite:add()
end

function updateDisplay()

    -- Use this to set font but currently this font has no : and I need one for SCORE: 10
    grds = gfx.font.new("assets/fonts/grds")
    gfx.setFont(grds)

    local scoreText = 'SCORE ' .. score
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local scoreImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    scoreSprite:setImage(scoreImage)
end

function incrementScore()
    score += 1
    updateDisplay()
end

function resetScore()
    score = 0
    updateDisplay()
end

function getScore()
    return score
end
local pd <const> = playdate
local gfx <const> = pd.graphics
local scoreSprite
local scoreCount

function createScoreDisplay()
    scoreSprite = gfx.sprite.new()
    score = 0
    scoreSprite:setCenter(0, 0)
    scoreSprite:moveTo(345, 217)
    scoreSprite:add()

    scoreCount = gfx.sprite.new()
    scoreCount:setCenter(0, 0)
    scoreCount:moveTo(356, 227)
    scoreCount:add()
end

function updateDisplay()

    grds = gfx.font.new("assets/fonts/grds")
    gfx.setFont(grds)

    local scoreText = 'SCORE'
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local scoreImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    scoreSprite:setImage(scoreImage)
    scoreSprite:setZIndex(6)

    local scoreNumber = score    
    local numberWidth, numberHeight = gfx.getTextSize(scoreNumber)
    local numberImage = gfx.image.new(numberWidth, numberHeight)
    gfx.pushContext(numberImage)
        gfx.drawText(scoreNumber, 0, 0)
    gfx.popContext()
    scoreCount:setImage(numberImage)
    scoreCount:setZIndex(6)
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
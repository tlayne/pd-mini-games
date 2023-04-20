local pd <const> = playdate
local gfx <const> = pd.graphics
local scoreSprite
local scoreCount
local highscore
local totalscore
local deathcount
local scoreTable

-- If there is a highscore stored, it loads it to the game, otherwise it initialises it to zero
function loadHighscore()
    scoreTable = playdate.datastore.read('scoreInfo')
    if scoreTable ~= nil then
        highscore = scoreTable[1]
        totalscore = scoreTable[2]
        deathcount = scoreTable[3]
        bossCount = scoreTable[4]
    else
        scoreTable = {}
        scoreTable[1] = 0
        scoreTable[2] = 0
        scoreTable[3] = 0
        scoreTable[4] = 0
        highscore = 0
        totalscore = 0
        deathcount = 0
        bossCount = 0 -- need to update bossCount on boss when defeated
    end
end

-- Saves the score to the device if it's higher than the highscore
-- Called on player death, but also should call on beat game
function saveScore(newScore)
    if scoreTable ~= nil then
        scoreTable[2] = scoreTable[2] + newScore
        scoreTable[3] = scoreTable[3] + 3
        scoreTable[4] = scoreTable[4] + bossCount
        playdate.datastore.write(scoreTable, 'scoreInfo')
        print('The current kill count is ' .. scoreTable[2])
        print('The current death count is ' .. scoreTable[3])
        if newScore > scoreTable[1] then
            scoreTable[1] = newScore
            playdate.datastore.write(scoreTable, 'scoreInfo')
            print('The new highscore is ' .. scoreTable[1])
        end
    end
end

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
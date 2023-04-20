import "crystal"

local pd <const> = playdate
local gfx <const> = pd.graphics

local crystalTimer
local cheevoTable

-- If there is a highscore stored, it loads it to the game, otherwise it initialises it to zero
function loadAchieved()
    cheevoTable = playdate.datastore.read('cheevoInfo')
    if cheevoTable ~= nil then
        achievements.first = cheevoTable.first
        achievements.second = cheevoTable.second
        achievements.third = cheevoTable.third
        achievements.fourth = cheevoTable.fourth
        achievements.fifth = cheevoTable.fifth
        achievements.sixth = cheevoTable.sixth
        achievements.seventh = cheevoTable.seventh
        achievements.eighth = cheevoTable.eighth
        achievements.ninth = cheevoTable.ninth
        achievements.tenth = cheevoTable.tenth
    else
        cheevoTable = {}
        cheevoTable.first = false
        cheevoTable.second = false
        cheevoTable.third = false
        cheevoTable.fourth = false
        cheevoTable.fifth = false
        cheevoTable.sixth = false
        cheevoTable.seventh = false
        cheevoTable.eighth = false
        cheevoTable.ninth = false
        cheevoTable.tenth = false
        achievements.first = false
        achievements.second = false
        achievements.third = false
        achievements.fourth = false
        achievements.fifth = false
        achievements.sixth = false
        achievements.seventh = false
        achievements.eighth = false
        achievements.ninth = false
        achievements.tenth = false
    end
end

-- Saves the score to the device if it's higher than the highscore
-- Called on player death, but also should call on beat game
function saveAchieved()
    if cheevoTable ~= nil then
        cheevoTable.first = achievements.first
        cheevoTable.second = achievements.second
        cheevoTable.third = achievements.third
        cheevoTable.fourth = achievements.fourth
        cheevoTable.fifth = achievements.fifth
        cheevoTable.sixth = achievements.sixth
        cheevoTable.seventh = achievements.seventh
        cheevoTable.eighth = achievements.eighth
        cheevoTable.ninth = achievements.ninth
        cheevoTable.tenth = achievements.tenth
        playdate.datastore.write(cheevoTable, 'cheevoInfo')
    end
end

function startCrystalSpawner()
    -- Randomly spawn enemies
    math.randomseed(pd.getSecondsSinceEpoch())
    createCrystalTimer()
end

function createCrystalTimer()
    -- Countdown until next enemy
    local crystalTime = math.random(20000, 50000)

    -- Wait random amount of time, create a new timer, then spawn an enemy
    crystalTimer = pd.timer.performAfterDelay(crystalTime, function()
        createCrystalTimer()
        spawnCrystal()
    end)
end

function spawnCrystal()
    local crystalPosition = math.random(0, 400)
    local crystalSpeed = math.random(1, 2)
    local crystalKey

-- Example Achievement Spawn works, so I just need to create statements for all achievements.
-- Earn your first power up
-- Change crystalKey to string 'first' etc. then change crystal collision
    if (powerLevel == "stage2" and achievements.first == false) then
        crystalKey = "first"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
-- Earn your second power up
    elseif (powerLevel == "stage3" and achievements.second == false) then
        crystalKey = "second"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    elseif (powerLevel == "stage4" and achievements.third == false) then
-- Earn your third power up
        crystalKey = "third"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    elseif (bombCount == 1 and achievements.fourth == false) then
-- Earn a bomb
        crystalKey = "fourth"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    elseif (lifeCount == 1 and achievements.fifth == false) then
-- Die one time
        crystalKey = "fifth"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)     
    elseif (lifeCount == 2 and powerLevel == "stage1" and score == 100 and achievements.sixth == false) then   
-- Reach 100 without dying or powering up
        crystalKey = "sixth"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey) 
    elseif (bossCount == 1 and achievements.seventh == false) then
-- Defeat the boss at least once        
        crystalKey = "seventh"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey) 
    elseif (gameState == "boss battle" and lifeCount == 0 and achievements.eighth == false) then
-- Reach the boss no lives left
        crystalKey = "eighth"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    elseif (gameState == "boss battle" and bombCount == 1 and achievements.ninth == false) then
-- Reach the boss without using a bomb
        crystalKey = "ninth"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    elseif (score == 0 and lifeCount < 2 and achievements.tenth == false) then
-- Die without killing any broodlings        
        crystalKey = "tenth"
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    end

-- gotta go fast - earn a shipsspeedmultiplier of ??
-- infinite space - cycle through all parallax backgrounds once
-- collect all data crystals

end

function stopCrystalSpawner()
    if crystalTimer then
        crystalTimer:remove()
    end
end

-- Clear all enemies from the screen
function clearCrystals()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Crystal) then
            sprite:remove()
        end
    end
end
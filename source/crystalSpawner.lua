import "crystal"

local pd <const> = playdate
local gfx <const> = pd.graphics

local crystalTimer

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
    if (powerLevel == "stage2" and achievements.first == false) then
        crystalKey = achievements.first
        Crystal(crystalPosition, -40, crystalSpeed, crystalKey)
    end
-- earn your second power up
-- earn your third power up
-- die one time 
-- use a bomb or earn a bomb?
-- earn a score of ?? without dying or powering up
-- reach a score of ??
-- stay in sync - keep your score and power level the same for so many seconds
-- pacifist - don't kill any enemies and stay alive for so many seconds
-- gotta go fast - earn a shipsspeedmultiplier of ??
-- infinite space - cycle through all parallax backgrounds once
-- get to the boss without using a bomb
-- defeat the boss at least once
-- defeat the boss with no lives left
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
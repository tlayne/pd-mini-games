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
    local crystalTime = math.random(700, 1200)

    -- Wait random amount of time, create a new timer, then spawn an enemy
    crystalTimer = pd.timer.performAfterDelay(crystalTime, function()
        createCrystalTimer()
        spawnCrystal()
    end)
end

function spawnCrystal()
    local crystalPosition = math.random(0, 400)
    -- will change direction to player current position rather than random
    local crystalDirection = math.random(-3, 3)
    local crystalSpeed = math.random(2, 5)

    Enemy(crystalPosition, -40, crystalDirection, crystalSpeed)
end

function stopCrystalTimer()
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
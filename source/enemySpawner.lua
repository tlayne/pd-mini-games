import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startEnemySpawner()
    -- Randomly spawn enemies
    math.randomseed(pd.getSecondsSinceEpoch())
    createEnemyTimer()
end

function createEnemyTimer()
    -- Countdown until next enemy
    local spawnTime = math.random(700, 1200)

    -- Wait random amount of time, create a new timer, then spawn an enemy
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function()
        createEnemyTimer()
        spawnEnemy()
    end)
end

function spawnEnemy()
    local spawnPosition = math.random(0, 400)
    -- will change direction to player current position rather than random
    local spawnDirection = math.random(-3, 3)
    local spawnSpeed = math.random(2, 5)

    Enemy(spawnPosition, -20, spawnSpeed, spawnDirection)
end

function stopEnemySpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

-- Clear all enemies from the screen
function clearEnemies()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Enemy) then
            sprite:remove()
        end
    end
end
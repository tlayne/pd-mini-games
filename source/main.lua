import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"
import "libraries/AnimatedSprite"
import "globals"
import "sceneController"
import "playGameButton"
import "player"
import "enemySpawner"
import "scoreDisplay"
import "lifeDisplay"
import "CoreLibs/crank"
import "powerUp"
import "soundController"

local pd <const> = playdate
local gfx <const> = pd.graphics


setStartingScene()

function resetGame()
    resetScore()
    resetLife()
    resetPower()
    clearEnemies()
    stopEnemySpawner()
    startEnemySpawner()
    enableInput()
    bombCount = 0
end

function setCrankUI(boo)
    crankStat = boo
    if crankStat == true then
        pd.ui.crankIndicator:start()
    end
end

function pd.update()

    gfx.sprite.update()
    pd.timer.updateTimers()
    pd.setCrankSoundsDisabled(true)

    if crankStat == true then
        pd.ui.crankIndicator:update()
    end
end
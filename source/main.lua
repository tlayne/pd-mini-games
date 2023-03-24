import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "globals"
import "sceneController"
import "playGameButton"
import "player"
import "enemySpawner"
import "scoreDisplay"
import "lifeDisplay"


local pd <const> = playdate
local gfx <const> = pd.graphics

setStartingScene()

function resetGame()
    resetScore()
    resetLife()
    clearEnemies()
    stopEnemySpawner()
    startEnemySpawner()
end

function pd.update()

    gfx.sprite.update()
    pd.timer.updateTimers()

end
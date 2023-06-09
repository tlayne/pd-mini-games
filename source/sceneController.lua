local pd <const> = playdate
local gfx <const> = pd.graphics

-- Removes all sprites from the screen
function clearSprites()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        sprite:remove()
    end
 end

 function clearEnemies()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Enemy) then
            sprite:remove()
        end
    end
 end

 -- Sets the background image
function setBackground(imageName)
    -- Display a background image
    local backgroundImage = gfx.image.new( "images/" .. imageName )
    assert( backgroundImage )
  
    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            backgroundImage:draw( 0, 0 )
        end
    )
 end

 -- SCENES
 function setStartingScene()
    gameState = 'start'
    clearSprites()
    PlayGameButton(35,150)
    setBackground('splashScreen')
 end

 function setGameScene()
    gameState = 'game'
    clearSprites()
    loadSounds()
    loadMusic()
    createScoreDisplay()
    createLifeDisplay()
    createPowerDisplay()
    Player(200, 180)
    Hud()
    setScrollingBackground()
    startEnemySpawner()
    startCrystalSpawner()
 end

 function  setBossScene()
   gameState = "boss battle"
 end

 function setCollectScene()
    gameState = 'collection'
    clearSprites()
    PlayGameButton(35,150)
    loadAchieved()
    createAchievementDisplay()
    updateAchievementDisplay()
 end

 function setCreditsScene()
    gameState = 'credits'
    clearSprites()
    PlayGameButton(35,150)
    setBackground('credits')
 end

 function setVictoryScene()
   gameState = "victory"
 end

 function setGameOverScene()
    gameState = 'game over'
    lifeCount = 2
    clearSprites()

    stopEnemySpawner()
    stopCrystalSpawner()
    PlayGameButton(35, 150)
    setBackground('endScreen')
 end
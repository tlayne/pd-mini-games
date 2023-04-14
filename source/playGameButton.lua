local pd <const> = playdate
local gfx <const> = pd.graphics
 
class('PlayGameButton').extends(gfx.sprite)

-- This will most likely be a cartridge menu eventually where user can select multiple options instead of one
-- I think the grid tutorial from squid will work nicely

function PlayGameButton:init(x, y)
    local gameButton = gfx.image.new(6, 6)
    gfx.pushContext(gameButton)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillTriangle(1, 1, 3, 3, 6, 6)
    gfx.popContext(gameButton)
    self:setImage(gameButton)
    self:moveTo(x, y)
    self:add()
end

-- When the A button is pressed and released, the game state changes and the user can play the game
function playdate.AButtonUp()
    if gameState == 'start' or gameState == 'game over' then
        setGameScene()
        resetGame()
    end
 end
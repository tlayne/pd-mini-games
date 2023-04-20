local pd <const> = playdate
local gfx <const> = pd.graphics
 
class('PlayGameButton').extends(gfx.sprite)

-- This will most likely be a cartridge menu eventually where user can select multiple options instead of one
-- I think the grid tutorial from squid will work nicely

function PlayGameButton:init(x, y)
    local gameButton = gfx.image.new(18, 18)
    gfx.pushContext(gameButton)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillTriangle(0, 0, 9, 9, 0, 18)
    gfx.popContext(gameButton)
    self:setImage(gameButton)
    self:moveTo(x, y)
    self:add()
end

-- When the A button is pressed and released, the game state changes and the user can play the game
-- I can either do if statements based on gamestate or I can clearsprites in each scene to get rid of the game button when necessary
function PlayGameButton:update()
        function playdate.AButtonUp()
            if (gameState == 'start' or gameState ~= 'game') then
                if self.y == 150 then
                    setGameScene()
                    resetGame()
                elseif self.y == 180 then
                    setCollectScene()
                elseif self.y == 210 then
                    setCreditsScene()
                end
            end
-- This works right now, but I should setup a game over screen that mimics the menu choices of the start scene
            if gameState == 'game over' then
                setStartingScene()
            end

        end
        
        function playdate.BButtonUp()
            if (gameState == 'collection' or gameState == 'credits') then
                setStartingScene()
            end
        end

        function playdate.downButtonUp()
            if (gameState == 'start' and gameState ~= 'game') then
                if self.y == 150 then
                    self:moveTo(self.x, 180)
                elseif self.y == 180 then
                    self:moveTo(self.x, 210)
                elseif self.y == 210 then
                    self:moveTo(self.x, 150)
                end
            end
        end
    
        function playdate.upButtonUp()
            if (gameState == 'start' and gameState ~= 'game') then
                if self.y == 150 then
                    self:moveTo(self.x, 210)
                elseif self.y == 180 then
                    self:moveTo(self.x, 150)
                elseif self.y == 210 then
                    self:moveTo(self.x, 180)
                end
            end
        end
end
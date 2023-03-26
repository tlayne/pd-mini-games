import "projectile"

local pd <const> = playdate
local gfx <const> = pd.graphics
 
class('Player').extends(AnimatedSprite)
 
-- Instantiates the Player
function Player:init(x, y)
    local playerTable = gfx.imagetable.new("images/deprecated/player-table-32-32")
    -- Set image table to the sprite
    Player.super.init(self, playerTable)

    self:addState("idle", 12, 14, {tickStep = 2})
    self:addState("bankLeft", 11, 11)
    self:addState("bankRight", 1, 1)
    self:addState("roll", 1, 11, {tickStep = 2, nextAnimation = 'idle'})
    self:playAnimation()
    self:moveTo( x, y )
    self:setCollideRect(5, 2, 22, 30)
    self:add()
 
    self.speed = 4
end

 
-- Runs every time the playdate refreshes, constantly checking if a button is being presssed (multiple can be pressed at once)
function Player:update()
    self:updateAnimation()
   -- Allow player movement with the D-pad
   if playdate.buttonIsPressed( playdate.kButtonUp ) then
       if (self.y > 160) then
           self:moveBy( 0, -self.speed * shipSpeedMultiplier )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonRight ) then
       if (self.x < 384) then
            self:changeState("bankRight")
           self:moveBy( self.speed * shipSpeedMultiplier, 0 )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonDown ) then
       if (self.y < 210 ) then
           self:moveBy( 0, self.speed * shipSpeedMultiplier )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonLeft ) then
       if (self.x > 16) then
            self:changeState("bankLeft")
           self:moveBy( -self.speed * shipSpeedMultiplier, 0 )
       end
   end
   if pd.buttonJustPressed(pd.kButtonA) then
        local projectileActive = projectileLimit()
        if (projectileActive < 4) then
            Projectile(self.x, self.y - 18, 5)
        end
   end

   if pd.buttonJustReleased(playdate.kButtonLeft) then
    self:changeState("idle")
   end
   if pd.buttonJustReleased(playdate.kButtonRight) then
    self:changeState("idle")
   end
   function pd.cranked(change, acceleratedChange)
        if change > 1 then
            self:changeState("roll")
            powerDisplayUpdate()
        end
   end
end


function resetPlayer()
    
    stopEnemySpawner()
    resetPower()
    loseLife()
    setCrankUI(false)
    
    padTimer = pd.timer.performAfterDelay(1200, function()
        if (lifeCount >= 0) then
            Player(200, 180)
            startEnemySpawner()
        else
            setGameOverScene()
        end
    end)
end
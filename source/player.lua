import "projectile"

local pd <const> = playdate
local gfx <const> = pd.graphics
 
class('Player').extends(AnimatedSprite)
 
-- Instantiates the Player
function Player:init(x, y)
    local playerTable = gfx.imagetable.new("images/player-table-32-32")
    -- Set image table to the sprite
    Player.super.init(self, playerTable)

    self:addState("idle", 1, 3, {tickStep = 2})
    self:addState("bankLeft", 14, 14)
    self:addState("bankRight", 4, 4)
    self:addState("roll", 4, 14, {tickStep = 2, nextAnimation = 'idle'})
    self:addState("dead", 15, 21, {tickStep = 2, })
    self:setDefaultState('idle')
    self:playAnimation()
    self:moveTo( x, y )
    self:setCollideRect(5, 2, 22, 26)
    self:add()

    self.speed = 4
end

 
-- Runs every time the playdate refreshes, constantly checking if a button is being presssed (multiple can be pressed at once)
function Player:update()
    self:updateAnimation()
-- Allow player movement with the D-pad if inputEnabled is true
if (inputEnabled == true) then
   if playdate.buttonIsPressed( playdate.kButtonUp ) then
       if (self.y > 130) then
           self:moveBy( 0, -self.speed * shipSpeedMultiplier )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonRight ) then
       if (self.x < 384) then
           self:moveBy( self.speed * shipSpeedMultiplier, 0 )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonDown ) then
       if (self.y < 190 ) then
           self:moveBy( 0, self.speed * shipSpeedMultiplier )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonLeft ) then
       if (self.x > 16) then
           self:moveBy( -self.speed * shipSpeedMultiplier, 0 )
       end
   end
   if pd.buttonJustPressed(pd.kButtonA) then
        projectileActive = projectileLimit()

        if (powerLevel == "stage1" and projectileActive < 3) then
            laser:play()
            Projectile(self.x, self.y - 18, 5, 0)
        elseif (powerLevel == "stage2" and projectileActive < 6) then
            laser:play()
            Projectile(self.x - 15, self.y - 6, 6, 0)
            Projectile(self.x + 15, self.y - 6, 6, 0)
        elseif (powerLevel == "stage3" and projectileActive < 9) then
            laser:play()
            Projectile(self.x, self.y - 18, 5, 0)
            Projectile(self.x - 15, self.y - 6, 6, 0)
            Projectile(self.x + 15, self.y - 6, 6, 0)
        elseif (powerLevel == "stage4" and projectileActive < 12) then
            laser:play()
            Projectile(self.x, self.y - 18, 5, 0)
            Projectile(self.x - 15, self.y - 6, 6, -1)
            Projectile(self.x + 15, self.y - 6, 6, 1)
        end
   end

   if pd.buttonJustPressed(pd.kButtonB) then
        if (bombCount == 1) then
            sonic:play()
            useBomb()
        end
   end

   if pd.buttonJustReleased(playdate.kButtonLeft) then
    self:changeState("idle")
   end
   if pd.buttonJustReleased(playdate.kButtonRight) then
    self:changeState("idle")
   end
   if pd.buttonJustPressed(playdate.kButtonLeft) then
    self:changeState("bankLeft")
   end
   if pd.buttonJustPressed(playdate.kButtonRight) then
    self:changeState("bankRight")
   end
   if doABarrelRoll == true then
    self:changeState('roll')
    self.states.roll.onLoopFinishedEvent = function(self)
        doABarrelRoll = false
    end 
   end
--   function pd.cranked(change, acceleratedChange)
--        if change > 1 then
--            self:changeState("roll")
--            powerDisplayUpdate()
--        end
--    end
end
end

function enableInput()
    inputEnabled = true
end

function disableInput()
    inputEnabled = false
end

function resetPlayer(playerReference)
    disableInput()
    powerCycle = false
    wyverWav:stop()
    splod:play()
    --playerReference:changeState("dead")
    playerReference:forceNextAnimation(true, "dead")
    
    splodeTimer = pd.timer.performAfterDelay(300, function()
        playerReference:remove()
    end)
    
    stopEnemySpawner()
    stopCrystalSpawner()
    clearEnemies()
    clearCrystals()
    resetPower()
    loseLife()
    setCrankUI(false)

    padTimer = pd.timer.performAfterDelay(1200, function()
        if (lifeCount >= 0) then
            enableInput()
            wyverWav:play(0)
            Player(200, 180)
            startEnemySpawner()
            startCrystalSpawner()
        else
            saveScore(getScore())
            setGameOverScene()
        end
    end)
end

function Player:collisionResponse()
    return 'overlap'
end
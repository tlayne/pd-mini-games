import "projectile"

local pd <const> = playdate
local gfx <const> = pd.graphics
 
class('Player').extends(gfx.sprite)
 
-- Instantiates the Player
function Player:init(x, y)
   local playerImage = gfx.image.new("images/playerImage")
   assert( playerImage )
   self:setImage(playerImage)
   self:moveTo( x, y )
   self:setCollideRect(2, 4, 20, 32)
   self:add()
 
   self.speed = 4
end
 
-- Runs every time the playdate refreshes, constantly checking if a button is being presssed (multiple can be pressed at once)
function Player:update()
   -- Allow player movement with the D-pad
   if playdate.buttonIsPressed( playdate.kButtonUp ) then
       if (self.y > 160) then
           self:moveBy( 0, -self.speed * shipSpeedMultiplier )
       end
   end
   if playdate.buttonIsPressed( playdate.kButtonRight ) then
       if (self.x < 384) then
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
           self:moveBy( -self.speed * shipSpeedMultiplier, 0 )
       end
   end
   if pd.buttonJustPressed(pd.kButtonA) then
        Projectile(self.x, self.y - 15, 5)
   end
end

-- this will be for scrolling background
--Just make it a sprite, place it in the background, and then move it down by how how fast you want to move it every frame.

local pd <const> = playdate
local gfx <const> = pd.graphics

function setScrollingBackground(imageName1, imageName2)
local backgroundImage1 = gfx.image.new( "images/" .. imageName1 )
local backgroundImage2 = gfx.image.new("images/" .. imageName2)
local backgroundSprite1 = gfx.sprite.new(backgroundImage1)
local backgroundSprite2 = gfx.sprite.new(backgroundImage2)

backgroundSprite:setCenter(0, 0)
backgroundSprite:moveTo(0, 0)
backgroundSprite:add()

local _, backgroundHeight = backgroundSprite:getSize()

-- In update step
local scrollSpeed = 10
backgroundSprite:moveBy(0, scrollSpeed)
if backgroundSprite.y > backgroundSize / 2 then
  backgroundSprite:moveBy(0, -backgroundSize/2)
end

--Something like that. I think the moving back code wouldn't work because it would look like it's snapping
--which is why I think you'll either need to cut the background in half and have two sprites, or double the background to tile it.


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
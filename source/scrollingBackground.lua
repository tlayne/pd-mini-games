
-- this will be for scrolling background
--Just make it a sprite, place it in the background, and then move it down by how how fast you want to move it every frame.
local backgroundImage = gfx.image.new(...)
local backgroundSprite = gfx.sprite.new(backgroundImage)
backgroundSprite:setCenter(0.5, 1.0)
backgroundSprite:moveTo(200, 240)
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
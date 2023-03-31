
-- this will be for scrolling background
--Just make it a sprite, place it in the background, and then move it down by how how fast you want to move it every frame.

local pd <const> = playdate
local gfx <const> = pd.graphics

function setScrollingBackground()

  local backgroundImage1 = gfx.image.new("images/background1")
  local backgroundImage2 = gfx.image.new("images/background2")
  local backgroundSprite1 = gfx.sprite.new(backgroundImage1)
  local backgroundSprite2 = gfx.sprite.new(backgroundImage2)

  backgroundSprite1:setCenter(0, 1)
  backgroundSprite1:moveTo(0, 240)
  backgroundSprite1:setZIndex(-1000)
  backgroundSprite1:add()

--local _, backgroundHeight = backgroundSprite1:getSize()

-- In update step

  function backgroundSprite1:update()
    local scrollSpeed = 0.7
    local backgroundSize = 960
    backgroundSprite1:moveBy(0, scrollSpeed)
     -- if backgroundSprite1.y > backgroundSize / 2 then
       -- backgroundSprite:moveBy(0, -backgroundSize/2)
              -- will need to add 2nd background, wait until 1st goes offscreen, remove 1st, then add 1st again at bottom etc.
      -- end
    end
end

--Something like that. I think the moving back code wouldn't work because it would look like it's snapping
--which is why I think you'll either need to cut the background in half and have two sprites, or double the background to tile it.
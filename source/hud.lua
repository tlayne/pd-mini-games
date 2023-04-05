-- issues
-- Still no barrel roll
-- charge resets on enemy kill because enemy collision causes crankstat to be true (maybe a good gameplay angle)
-- can't get decelerate to work, but perhaps if crank is idle for a time decelerate will kick in.

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Hud').extends(AnimatedSprite)

function Hud:init()
    local hudTable = gfx.imagetable.new("images/hud-table-400-30")
  
    Hud.super.init(self,hudTable)

    self:addState("static", 1, 1)
    self:addState("alert", 1, 4, {tickStep = 15, frames = {1,4}})
    self:addState("charge", 4, nil, {tickStep = 3})
    self:addState("decelerate", 38, 1, {tickStep = 15})
    self:setDefaultState('static')
    self:playAnimation()
    self:setCenter(0,0)
    self:setZIndex(5)
    self:moveTo(0, 210)
    self:add()
end

function Hud:update()
    self:updateAnimation()

    if (crankStat == true) then
        self:changeState("alert")
    end

    if (shipPower == 0) then
        self:changeState('static')
    end

local rchange, accChange = pd.getCrankChange()

--sprite.states.default.tickStep = 4 dynamically change tickStep
-- if accChange is > # set tickStep up 2 to 5 is slow, 5 to 10 is medium, 10 + is fast?
-- if accChange is < # set tickStep down

        if (rchange > 1 and crankStat) then
            setCrankUI(false)
            self:changeState("charge")
            print(accChange)
        end

        if (rchange < 1 and crankStat == false) then
            --startDec = self:getCurrentFrameIndex()
            --print(startDec)
            --self.states.decelerate.animationStartingFrame = startDec
            --print(self.states.decelerate.animationStartingFrame)
            --self:changeState("decelerate")
            self:pauseAnimation()
            print("Charging stopped")
        end

        if (rchange > 1 and crankStat == false) then
            self:resumeAnimation()
        end

-- NOT WORKING YET        
        if (self.currentState == self.states.charge) then
            -- check state of enemy or collision?
            print("decharge sound here")
        end

    self.states.charge.onLoopFinishedEvent = function(self)
        self:changeState("static")
        doABarrelRoll = true
        powerDisplayUpdate()
    end 

-- to get this to work I need a countdown from last time crank was turned. If it is too long change the animation to decelerate.
    self.states.decelerate.onLoopFinishedEvent = function(self)
        setCrankUI(true)
        print("Process restarted")
    end

end


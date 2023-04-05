-- issues
-- Still no barrel roll
-- charge resets on enemy kill because enemy collision causes crankstat to be true (maybe a good gameplay angle)
-- can't get decelerate to work, but perhaps if crank is idle for a time decelerate will kick in.

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Hud').extends(AnimatedSprite)

function Hud:init(x, y)
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
    self:moveTo(x, y)
    self:add()
end

function Hud:update()
    self:updateAnimation()

    if (crankStat == true) then
        self:changeState("alert")
    end

local rchange, accChange = pd.getCrankChange()

--sprite.states.default.tickStep = 4 dynamically change tickStep
-- if accChange is > # set tickStep up
-- if accChange is < # set tickStep down

        if (rchange > 1 and crankStat) then
            setCrankUI(false)
            self:changeState("charge")
            print("Charging started")
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

    self.states.charge.onLoopFinishedEvent = function(self)
        self:changeState("static")
        powerDisplayUpdate()
        print("Charge complete")
    end 

    self.states.decelerate.onLoopFinishedEvent = function(self)
        setCrankUI(true)
        print("Process restarted")
    end

end


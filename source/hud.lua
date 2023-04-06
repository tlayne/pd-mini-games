-- issues
-- associate tickstep of charge to acceleration of crank
-- make the default charge time faster so it syncs better with the sound

local pd <const> = playdate
local gfx <const> = pd.graphics


class('Hud').extends(AnimatedSprite)

function Hud:init()
    local hudTable = gfx.imagetable.new("images/hud-table-400-30")
  
    Hud.super.init(self,hudTable)

    self:addState("static", 1, 1)
    self:addState("alert", 1, 4, {tickStep = 15, frames = {1,4}})
    self:addState("charge", 4, nil, {tickStep = 3})
    self:addState("decelerate", 1, 38, {tickStep = 3, reverse = true})
    self:setDefaultState('static')
    self:playAnimation()
    self:setCenter(0,0)
    self:setZIndex(5)
    self:moveTo(0, 210)
    self:add()
end

function Hud:update()
    self:updateAnimation()
    local rchange, accChange = pd.getCrankChange()

    if (crankStat == true) then
        self:changeState("alert")
        powerCycle = true
    end

    if (shipPower == 0) then
        self:changeState('static')
    end

--sprite.states.default.tickStep = 4 dynamically change tickStep
-- if accChange is > # set tickStep up 2 to 5 is slow, 5 to 10 is medium, 10 + is fast?
-- if accChange is < # set tickStep down

        if (rchange > 1 and crankStat) then
            setCrankUI(false)
            self:changeState("charge")
            special:play()
            print(accChange)
        end

        if (rchange < 1 and powerCycle == true and crankStat == false) then
            self:pauseAnimation()
            special:stop()
            startDec = self:getCurrentFrameIndex()
            self.states.decelerate.animationStartingFrame = startDec
            self:changeState("decelerate")

            pd.timer.performAfterDelay(400, function()
                self:resumeAnimation()
            end)
        end

        -- if (rchange > 1 and powerCycle == false and crankStat == false) then
           -- special:play()
            --self:resumeAnimation()
        --end




    self.states.charge.onLoopFinishedEvent = function(self)
        self:changeState("static")
        doABarrelRoll = true
        powerCycle = false
        powerDisplayUpdate()
    end 

    self.states.decelerate.onLoopFinishedEvent = function(self)
        setCrankUI(true)
        alarm:play()
        powerCycle = false
    end

    self.states.decelerate.onStateChangedEvent = function(self)
        if self.currentState == "decelerate" then
            decharge:play()
        end
    end
end


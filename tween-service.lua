--[[
    #     #####  #    #    #    ######  ######     ######  ####### #     # ####### #       ####### ######  ####### ######  
   # #   #     # #   #    # #   #     # #     #    #     # #       #     # #       #       #     # #     # #       #     # 
  #   #  #       #  #    #   #  #     # #     #    #     # #       #     # #       #       #     # #     # #       #     # 
 #     #  #####  ###    #     # ######  #     #    #     # #####   #     # #####   #       #     # ######  #####   ######  
 #######       # #  #   ####### #   #   #     #    #     # #        #   #  #       #       #     # #       #       #   #   
 #     # #     # #   #  #     # #    #  #     #    #     # #         # #   #       #       #     # #       #       #    #  
 #     #  #####  #    # #     # #     # ######     ######  #######    #    ####### ####### ####### #       ####### #     # 
]]

TweenService = {}
TweenService.__index = TweenService

function TweenService.new()
    local self = setmetatable({}, TweenService)
    self.startValue = 0
    self.endValue = 0
    self.duration = 0
    self.easingType = 'Linear'
    self.onComplete = nil
    self.onUpdate = nil
    self.timer = nil
    self.actualValue = 0
    return self
end

function TweenService:start()
    self.timer = setTimer(function()
        local currentTime = getTickCount() - self.startTime
        local progress = (currentTime / self.duration)
        local value = interpolateBetween(self.startValue, 0, 0, self.endValue, 0, 0, progress, self.easingType)
        if progress >= 1 then
            self:stop()
            if self.onComplete then
                self.onComplete(value)
            end
        else
            if self.onUpdate then
                self.onUpdate(value)
            end
        end
    end, 50, 0)
    self.startTime = getTickCount()
end

function TweenService:stop()
    if isTimer(self.timer) then
        killTimer(self.timer)
        self.timer = nil
    end
end

local TweenService = TweenService.new()

Animations = {
    down = {0, 0}
}

function TweenService:setup(startValue, endValue, duration, easingType)
    self.startValue = startValue
    self.endValue = endValue
    self.duration = duration
    self.easingType = easingType
    TweenService:start()
end

function TweenService:setOnUpdate(callback)
    self.onUpdate = callback
end

TweenService:setOnUpdate(function(value)
    Animations.down[1] = value
end)

function TweenService:setEndValue(callback)
    self.onComplete = callback
end

TweenService:setEndValue(function(value)
    Animations.down[2] = value
end)

function TweenService:draw()
    dxDrawRectangle(0, Animations.down[1], 100, 100, tocolor(255, 255, 255))
end

function TweenService:onMouseClick ( button, state, absoluteX, absoluteY )
    if (button == 'left' and state == 'down') then
        if Animations.down[2] ~= absoluteY then
            TweenService:setup(Animations.down[1], absoluteY, 5000, 'InOutQuad')
        end
    end
end

function TweenService:addEventHandlers()
    addEventHandler( 'onClientRender', root, function() self:draw() end)
    addEventHandler('onClientClick', root, function(button, state, absoluteX, absoluteY) self:onMouseClick(button, state, absoluteX, absoluteY) end)
end

TweenService:addEventHandlers()

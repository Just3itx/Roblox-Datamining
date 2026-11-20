-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Otter = require(scriptParentParent.Otter)
local SharedFlags = require(scriptParentParent.SharedFlags)

local bool1 = game:DefineFastFlag("AppIaScrollAwayIgnoreHorizontal", false)
local num1 = game:DefineFastInt("AppIaScrollAwayThreshold", 10)
local FFlagAppIaScrollAwayPinHeader = SharedFlags.FFlagAppIaScrollAwayPinHeader
local FFlagAppIaScopedScrollAway = SharedFlags.FFlagAppIaScopedScrollAway
local FFlagEnableScrollAwayContentScrollableFix = SharedFlags.FFlagEnableScrollAwayContentScrollableFix

local tbl1 = {
    dampingRatio = 1,
    frequency = 3,
    restingVelocityLimit = 0.1,
    restingPositionLimit = 0.1
}

local tbl2 = { binding = nil, motor = nil }

tbl2.__index = tbl2

function tbl2.create(num2: number)
    local binding, var2 = React.createBinding(num2)
    local motor = Otter.createSingleMotor(num2)
    motor:onStep(var2)

    local tbl3 = { binding = binding, motor = motor }

    setmetatable(tbl3, tbl2)

    return tbl3
end

function tbl2:destroy()
    self.motor:destroy()
end

function tbl2:getBinding()
    return self.binding
end

function tbl2:show()
    self.motor:setGoal(Otter.spring(1, tbl1))
end

function tbl2:hide()
    self.motor:setGoal(Otter.spring(0, tbl1))
end

function tbl2:update(num2: number)
    local num3 = math.clamp(self.binding:getValue() + num2, 0, 1)
    self.motor:setGoal(Otter.instant(num3))
end

function tbl2:finishUp()
    if self.binding:getValue() < 0.5 then
        self:hide()
        return
    end
    self:show()
end

local tbl3 = {
    enabled = false,
    header = nil,
    footer = nil,
    footerVisible = false,
    headerScrollAwayDisabled = not FFlagAppIaScrollAwayPinHeader and nil,
    globalTouchDisabled = not FFlagAppIaScopedScrollAway and nil,
    connections = nil,
    touching = false,
    moving = false,
    touchPositionX = 0,
    touchPositionY = 0,
    horizontalLocked = false,
    scrollDistance = 50,
    contentScrollable = true
}

tbl3.__index = tbl3

local var1 = nil

function tbl3.onTouchMoved(tbl4, num2: number)
    if FFlagEnableScrollAwayContentScrollableFix and not tbl4.contentScrollable then
        return
    end
    local var2 = num2 / tbl4.scrollDistance

    if tbl4.footerVisible then
        tbl4.footer:update(var2)
    end

    if not FFlagAppIaScrollAwayPinHeader or not tbl4.headerScrollAwayDisabled then
        tbl4.header:update(var2)
    end
end

function tbl3.onTouchEnded(arg1)
    if arg1.footerVisible then
        arg1.footer:finishUp()
    end

    if not (FFlagAppIaScrollAwayPinHeader and arg1.headerScrollAwayDisabled) then
        arg1.header:finishUp()
    end
end

function tbl3.connectTouch(arg1)
    if arg1.connections ~= nil then
        return
    end
    arg1.connections = {}
    arg1.connections.started = UserInputService.TouchStarted:Connect(function(touch: InputObject)
        arg1.touching = true
        if bool1 then
            arg1.moving = false
            arg1.horizontalLocked = false
            arg1.touchPositionX = touch.Position.X
        end
        arg1.touchPositionY = touch.Position.Y
    end)
    arg1.connections.moved = UserInputService.TouchMoved:Connect(function(touch: InputObject)
        if not arg1.touching or bool1 and arg1.horizontalLocked then
            return
        end

        local touchPositionY = touch.Position.Y
        if arg1.moving then
            local var2 = touchPositionY - arg1.touchPositionY
            arg1.touchPositionY = touchPositionY
            arg1:onTouchMoved(var2)
            return
        end

        if bool1 then
            local num2 = math.abs(touch.Position.X - arg1.touchPositionX)
            local num3 = math.abs(touchPositionY - arg1.touchPositionY)

            if num1 < num2 and num3 < num2 then
                arg1.horizontalLocked = true
                return
            end
            if num1 < num3 then
                arg1.moving = true
                arg1.touchPositionY = touchPositionY
                return
            end
        elseif math.abs(touchPositionY - arg1.touchPositionY) > num1 then
            arg1.moving = true
            arg1.touchPositionY = touchPositionY
        end
    end)

    arg1.connections.ended = UserInputService.TouchEnded:Connect(function(_inputObject: InputObject)
        if not arg1.touching then
            return
        end
        arg1.touching = false
        arg1.moving = false
        if bool1 then
            arg1.horizontalLocked = false
        end
        arg1:onTouchEnded()
    end)
end

function tbl3.disconnectTouch(arg1)
    if arg1.connections == nil then
        return
    end
    for _, connection in pairs(arg1.connections) do
        connection:Disconnect()
    end
    arg1.connections = nil
end

function tbl3.isEnabled(arg1)
    return arg1.enabled
end

function tbl3.setEnabled(tbl4, enabled: boolean)
    if tbl4.enabled == enabled then
        return
    end
    tbl4.enabled = enabled
    if enabled then
        if not FFlagAppIaScopedScrollAway then
            tbl4:connectTouch()
            return
        end

        if not tbl4.globalTouchDisabled then
            tbl4:connectTouch()
        end
    else
        tbl4:disconnectTouch()
        if FFlagEnableScrollAwayContentScrollableFix then
            tbl4.contentScrollable = true
        end
    end
end

function tbl3.setGlobalTouchEnabled(tbl4, bool2: boolean)
    tbl4.globalTouchDisabled = not bool2
    if bool2 then
        if tbl4.enabled then
            tbl4:connectTouch()
        end
    else
        tbl4:disconnectTouch()
    end
end

function tbl3.setContentScrollable(tbl4, contentScrollable: boolean)
    if tbl4.contentScrollable == contentScrollable then
        return
    end
    if not contentScrollable then
        tbl4:show()
    end
    tbl4.contentScrollable = contentScrollable
end

function tbl3.setFooterVisible(tbl4, footerVisible: boolean)
    if tbl4.footerVisible == footerVisible then
        return
    end
    tbl4.footerVisible = footerVisible
    if footerVisible then
        tbl4.footer:show()
        return
    end
    tbl4.footer:hide()
end

function tbl3.getHeaderBinding(arg1)
    return arg1.header:getBinding()
end

function tbl3.getFooterBinding(arg1)
    return arg1.footer:getBinding()
end

function tbl3.setHeaderScrollAwayDisabled(tbl4, headerScrollAwayDisabled: boolean)
    if not FFlagAppIaScrollAwayPinHeader then
        return
    end
    tbl4.headerScrollAwayDisabled = headerScrollAwayDisabled
    if headerScrollAwayDisabled then
        tbl4.header:show()
    end
end

function tbl3.show(arg1)
    if FFlagEnableScrollAwayContentScrollableFix then
        arg1.contentScrollable = true
    end
    arg1.header:show()
    if arg1.footerVisible then
        arg1.footer:show()
    end
end

function tbl3.hide(arg1)
    if not (FFlagAppIaScrollAwayPinHeader and arg1.headerScrollAwayDisabled) then
        arg1.header:hide()
    end
    if arg1.footerVisible then
        arg1.footer:hide()
    end
end

function tbl3.getInstance()
    if not var1 then
        var1 = {}
        setmetatable(var1, tbl3)
        var1:initialize()
    end
    return var1
end

function tbl3.initialize(arg1)
    arg1.header = tbl2.create(1)

    arg1.footer = tbl2.create(0)
end

function tbl3.destroy(arg1)
    arg1.header:destroy()
    arg1.footer:destroy()
    arg1:disconnectTouch()
    var1 = nil
end

function tbl3.setScrollDistance(tbl4, scrollDistance: number)
    if scrollDistance == 0 then
        return
    end
    tbl4.scrollDistance = scrollDistance
end

return {
    isEnabled = function()
        return tbl3.getInstance():isEnabled()
    end,
    setEnabled = function(bool2: boolean)
        tbl3.getInstance():setEnabled(bool2)
    end,
    getHeaderBinding = function()
        return tbl3.getInstance():getHeaderBinding()
    end,
    getFooterBinding = function()
        return tbl3.getInstance():getFooterBinding()
    end,
    setFooterVisible = function(bool2: boolean)
        tbl3.getInstance():setFooterVisible(bool2)
    end,
    setHeaderScrollAwayDisabled = FFlagAppIaScrollAwayPinHeader and function(bool2: boolean)
        tbl3.getInstance():setHeaderScrollAwayDisabled(bool2)
    end or nil,
    show = function()
        tbl3.getInstance():show()
    end,
    hide = function()
        tbl3.getInstance():hide()
    end,
    destroy = function()
        tbl3.getInstance():destroy()
    end,
    setScrollDistance = function(num2: number)
        tbl3.getInstance():setScrollDistance(num2)
    end,
    setGlobalTouchEnabled = FFlagAppIaScopedScrollAway and function(bool2: boolean)
        tbl3.getInstance():setGlobalTouchEnabled(bool2)
    end or nil,
    onTouchMoved = FFlagAppIaScopedScrollAway and function(num2: number)
        local instance = tbl3.getInstance()
        if instance.enabled then
            instance:onTouchMoved(num2)
        end
    end or nil,
    onTouchEnded = FFlagAppIaScopedScrollAway and function()
        local instance = tbl3.getInstance()
        if instance.enabled then
            instance:onTouchEnded()
        end
    end or nil,
    setContentScrollable = function(bool2: boolean)
        tbl3.getInstance():setContentScrollable(bool2)
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Otter = require(scriptParentParentParentParentParent.Otter)
local Button = require(Core.ImageSet.ImageSetComponent).Button
local withStyle = require(Core.Style.withStyle)
local NavigationDirection = require(script.Parent.NavigationDirection)

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local var1 = Roact.PureComponent:extend("ArrowNav")

var1.validateProps = t.intersection(
    t.strictInterface({
        AnchorPoint = t.optional(t.Vector2),
        Position = t.optional(t.UDim2),
        Image = t.table,
        Visible = t.optional(t.union(t.boolean, t.table)),
        navDirection = t.optional(t.userdata),
        onPressHoldInputBegan = t.optional(t.callback),
        onPressHoldInputEnded = t.optional(t.callback),
        defaultUseProps = t.optional(
            t.strictInterface({
                scrollingFrameRef = t.table,
                buttonRefs = t.optional(t.table),
                buttonWidth = t.optional(t.number),
                numButtons = t.optional(t.number),
                padOutsideEdges = t.optional(t.boolean),
                buttonPadding = t.number,
                updateCanvasPosition = t.callback
            })
        )
    }),
    function(arg1)
        if arg1.defaultUseProps then
            if arg1.defaultUseProps.buttonRefs ~= nil then
                if arg1.defaultUseProps.buttonWidth ~= nil then
                    return false, "Cannot set both buttonWidth and buttonRefs"
                end
                if arg1.defaultUseProps.numButtons ~= nil then
                    return false, "Cannot set both numButtons and buttonRefs"
                end
            end
            if arg1.defaultUseProps.buttonWidth ~= nil and arg1.defaultUseProps.numButtons == nil then
                return false, "If setting buttonWidth must also set numButtons"
            end
            if arg1.defaultUseProps.buttonWidth == nil and arg1.defaultUseProps.numButtons ~= nil then
                return false, "If setting numButtons must also set buttonWidth"
            end

            if arg1.defaultUseProps.buttonRefs == nil
                and arg1.defaultUseProps.buttonWidth == nil
                and arg1.defaultUseProps.numButtons == nil
            then
                return false, "Must set either buttonRefs or (buttonWidth and numButtons)"
            end
        end
        return true
    end
)

var1.defaultProps = {
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.new(0, 0, 0, 0),
    Visible = true
}

function var1.init(arg1)
    arg1.holdConn = nil
    arg1.timeOfInputBegan = 0

    function arg1.handleInputBegan(_, arg2)
        local navDirection = arg1.props.navDirection
        if arg1.props.onPressHoldInputBegan then
            arg1.props.onPressHoldInputBegan(arg2, navDirection)
            return
        end
        arg1:onPressHoldInputBegan(arg2, navDirection)
    end

    function arg1.handleInputEnded(_, arg2)
        local navDirection = arg1.props.navDirection
        if arg1.props.onPressHoldInputEnded then
            arg1.props.onPressHoldInputEnded(arg2, navDirection)
            return
        end
        arg1:onPressHoldInputEnded(arg2, navDirection)
    end
end

function var1.getGoal(arg1, arg2)
    return Otter.spring(arg1:getScrollToLocation(arg2), tbl1)
end

function var1.didMount(arg1)
    arg1:setMotor(0)
end

function var1.setMotor(tbl2, num1: number)
    tbl2.motor = Otter.createSingleMotor(num1)
    tbl2.motor:onStep(function(x: number?)
        tbl2.props.defaultUseProps.updateCanvasPosition(Vector2.new(x, 0))
    end)
    tbl2.motor:onComplete(function(x: number?)
        tbl2.props.defaultUseProps.updateCanvasPosition(Vector2.new(x, 0))
    end)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        return Roact.createElement(Button, {
            AnchorPoint = arg1.props.AnchorPoint,
            Position = arg1.props.Position,
            Image = arg1.props.Image,
            Visible = arg1.props.Visible,
            BackgroundTransparency = 1,
            ImageColor3 = theme.IconEmphasis.Color,
            Size = UDim2.fromOffset(36, 36),
            [Roact.Event.InputBegan] = arg1.handleInputBegan,
            [Roact.Event.InputEnded] = arg1.handleInputEnded
        })
    end)
end

function var1.willUnmount(arg1)
    arg1:disconnectHoldConn()
    if arg1.motor then
        arg1.motor:destroy()
        arg1.motor = nil
    end
end

function var1.getNewCanvasPosition(tbl2, x: number)
    return tbl2.props.defaultUseProps.scrollingFrameRef.current.CanvasPosition + Vector2.new(x, 0)
end

function var1.disconnectHoldConn(arg1)
    if arg1.holdConn == nil then
        return
    end
    arg1.holdConn:Disconnect()
    arg1.holdConn = nil
end

function var1.onPressHoldInputBegan(arg1, arg2, arg3)
    if arg2.UserInputState ~= Enum.UserInputState.Begin then
        return
    end
    arg1.timeOfInputBegan = tick()
    arg1:disconnectHoldConn()
    arg1.holdConn = RunService.RenderStepped:connect(function(deltaTime: number)
        local var2 = tick() - arg1.timeOfInputBegan
        local isLeft = NavigationDirection.IsLeft
        local num1 = if arg3 == isLeft then -1 else 1
        local newCanvasPosition = arg1:getNewCanvasPosition(num1 * 500 * deltaTime * var2 ^ 2)
        arg1.props.defaultUseProps.updateCanvasPosition(newCanvasPosition)
    end)
end

function var1.onPressHoldInputEnded(arg1, arg2, arg3)
    if arg2.UserInputState ~= Enum.UserInputState.End then
        return
    end
    local current = arg1.props.defaultUseProps.scrollingFrameRef.current
    if tick() - arg1.timeOfInputBegan <= 0.5 then
        if arg1.motor then
            arg1.motor:destroy()
        end
        arg1:setMotor(current.CanvasPosition.X)
        arg1.motor:setGoal(arg1:getGoal(arg3))
    else
        arg1.motor:setGoal(Otter.instant(current.CanvasPosition.X))
    end
    arg1:disconnectHoldConn()
end

function var1.getScrollToLocation(arg1, isLeft)
    local buttonSizes = arg1:getButtonSizes()

    if isLeft == NavigationDirection.IsLeft then
        return arg1:getScrollToLeftLocation(buttonSizes)
    end
    return arg1:getScrollToRightLocation(buttonSizes)
end

function var1.getButtonSizes(arg1)
    local buttonRefs = arg1.props.defaultUseProps.buttonRefs
    local buttonWidth = arg1.props.defaultUseProps.buttonWidth
    local numButtons = arg1.props.defaultUseProps.numButtons

    if buttonWidth and numButtons then
        return table.create(numButtons, buttonWidth)
    end

    local buttonSizes = {}
    for _, buttonRef in ipairs(buttonRefs) do
        table.insert(buttonSizes, buttonRef.current and buttonRef.current.AbsoluteSize.X or 0)
    end
    return buttonSizes
end

function var1.getScrollToLeftLocation(arg1, arg2)
    local current = arg1.props.defaultUseProps.scrollingFrameRef.current
    local buttonPadding = arg1.props.defaultUseProps.buttonPadding

    local var2 = current.CanvasPosition.X - current.AbsoluteSize.X * 0.4

    local num1 = 0
    for _, value in ipairs(arg2) do
        if var2 <= num1 + value + buttonPadding then
            return num1
        end
        num1 += value + buttonPadding
    end

    return num1
end

function var1.getScrollToRightLocation(arg1, arg2)
    local current = arg1.props.defaultUseProps.scrollingFrameRef.current
    local buttonPadding = arg1.props.defaultUseProps.buttonPadding
    local padOutsideEdges = arg1.props.defaultUseProps.padOutsideEdges

    local var2 = current.CanvasPosition.X + current.AbsoluteSize.X * 0.4

    local var3 = -current.AbsoluteSize.X
    if padOutsideEdges then
        var3 += buttonPadding
    end
    for _, value in ipairs(arg2) do
        if var2 < var3 then
            return var3
        end
        var3 += value + buttonPadding
    end

    return var3
end

return var1

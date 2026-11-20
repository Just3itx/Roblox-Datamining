-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Cryo = require(scriptParentParentParentParent.Cryo)
local Otter = require(scriptParentParentParentParent.Otter)
local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Focusable = require(scriptParentParentParentParent.RoactGamepad).Focusable

local withStyle = require(scriptParentParentParentParent.UIBlox.Core.Style.withStyle)
local useCursorByType = require(scriptParentParent.SelectionCursor.useCursorByType)
local CursorType = require(scriptParentParent.SelectionCursor.CursorType)

local getPageMargin = require(scriptParentParentParent.App.Container.getPageMargin)

local uDim = UDim.new(0, 0)

local tbl1 = { frequency = 3, dampingRatio = 1.5 }

local var1 = Roact.Component:extend("VerticalScrollView")

local strictInterface = t.strictInterface
local tbl2 = {
    size = t.optional(t.UDim2),
    position = t.optional(t.UDim2),
    elasticBehavior = t.optional(t.EnumItem),
    canvasSizeY = t.optional(t.UDim),
    useAutomaticCanvasSize = t.optional(t.boolean),
    paddingHorizontal = t.optional(t.number),
    paddingTop = t.optional(t.number),
    isGamepadFocusable = t.optional(t.boolean),
    Selectable = t.optional(t.boolean),
    [Roact.Change.CanvasPosition] = t.optional(t.callback),
    [Roact.Change.CanvasSize] = t.optional(t.callback),
    scrollingFrameRef = t.optional(t.table),
    onSelectionChanged = t.optional(t.callback),
    CanvasPosition = t.optional(t.union(t.table, t.Vector2)),
    ScrollingEnabled = t.optional(t.boolean),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    cursor = t.table,
    [Roact.Children] = t.optional(t.table)
}
var1.validateProps = strictInterface(tbl2)

var1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0),
    canvasSizeY = UDim.new(2, 0),
    useAutomaticCanvasSize = false,
    isGamepadFocusable = false,
    Selectable = true
}

function var1.init(arg1)
    arg1:setState({ scrollBarThickness = 0, scrollingWithTouch = false })

    local scrollBarImageTransparency, updateScrollBarImageTransparency = Roact.createBinding(0)
    arg1.scrollBarImageTransparency = scrollBarImageTransparency
    arg1.updateScrollBarImageTransparency = updateScrollBarImageTransparency
    arg1.scrollBarImageTransparencyMotor = Otter.createSingleMotor(0)
    arg1.scrollBarImageTransparencyMotor:onStep(arg1.updateScrollBarImageTransparency)

    arg1.lastTimeCanvasPositionChanged = tick()

    arg1.waitToHideSidebarConnection = nil
    function arg1.waitToHideSidebar()
        if tick() - arg1.lastTimeCanvasPositionChanged > 0.7 then
            arg1.scrollBarImageTransparencyMotor:setGoal(Otter.spring(1, tbl1))
            arg1.disconnectWaitToHideSidebar()
        end
    end
    function arg1.disconnectWaitToHideSidebar()
        if arg1.waitToHideSidebarConnection then
            arg1.waitToHideSidebarConnection:Disconnect()
            arg1.waitToHideSidebarConnection = nil
        end
    end
    function arg1.inputBegan(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        arg1.disconnectWaitToHideSidebar()
        arg1:setState({ scrollBarThickness = 8 })

        arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(0))
    end

    function arg1.inputEnded(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseMovement then
            arg1.disconnectWaitToHideSidebar()
            arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(1))
        end
    end
    function arg1.canvasPosition(arg2)
        arg1.lastTimeCanvasPositionChanged = tick()
        if not arg1.waitToHideSidebarConnection and UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
            arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(0))
            arg1:setState({ scrollBarThickness = 2 })

            arg1.waitToHideSidebarConnection = RunService.Heartbeat:Connect(arg1.waitToHideSidebar)
        end

        if arg1.props[Roact.Change.CanvasPosition] then
            arg1.props[Roact.Change.CanvasPosition](arg2)
        end
    end

    function arg1.onGamepadFocused()
        arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(0))
        arg1:setState({ scrollBarThickness = 2 })
    end

    function arg1.onGamepadFocusLost()
        arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(1))
    end

    arg1.parentFrameRef = Roact.createRef()
    local paddingBinding, updatePaddingBinding = Roact.createBinding(0)
    arg1.paddingBinding = paddingBinding
    arg1.updatePaddingBinding = updatePaddingBinding

    function arg1.getPadding(arg2)
        local var6 = arg2 or 0
        if not arg1.props.paddingHorizontal then
            return arg1.paddingBinding:map(function(arg3): UDim
                return UDim.new(0, getPageMargin(arg3) - var6)
            end)
        end

        local offset = math.max(0, arg1.props.paddingHorizontal - var6)
        return UDim.new(0, offset)
    end
end

function var1.renderWithProviders(arg1, arg2, _, selectionImageObject)
    local theme = arg2.Theme

    local canvasSizeY = arg1.props.canvasSizeY
    local prop = arg1.props[Roact.Children] or {}
    local position = arg1.props.position
    local size = arg1.props.size

    local isGamepadFocusable = arg1.props.isGamepadFocusable

    local scrollBarThickness = arg1.state.scrollBarThickness

    local join = Cryo.Dictionary.join
    local tbl3 = {
        scrollingFrameInnerMargin = Roact.createElement("UIPadding", {
            PaddingTop = if arg1.props.paddingTop == nil then nil else UDim.new(0, arg1.props.paddingTop),
            PaddingLeft = arg1.getPadding(),
            PaddingRight = arg1.getPadding(4)
        })
    }
    local var2 = join(tbl3, prop)

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl4 = { BackgroundTransparency = 1, Position = position, Size = size }
    tbl4[Roact.Change.AbsoluteSize] = function(arg3)
        arg1.updatePaddingBinding(arg3.AbsoluteSize.X)
    end
    tbl4[Roact.Ref] = arg1.parentFrameRef
    local tbl5 = {
        scrollingFrameOuterMargins = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, 4) }),
        scrollingFrame = Roact.createElement(isGamepadFocusable and Focusable.ScrollingFrame or "ScrollingFrame", {
            Active = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            ElasticBehavior = arg1.props.elasticBehavior,
            CanvasSize = UDim2.new(uDim, canvasSizeY),
            AutomaticCanvasSize = arg1.props.useAutomaticCanvasSize and Enum.AutomaticSize.Y or nil,
            ScrollBarImageColor3 = theme.UIEmphasis.Color,
            ScrollBarImageTransparency = arg1.scrollBarImageTransparency,
            ScrollBarThickness = scrollBarThickness,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = arg1.props.ScrollingEnabled,
            CanvasPosition = arg1.props.CanvasPosition,
            SelectionImageObject = selectionImageObject,
            onFocusGained = if isGamepadFocusable then arg1.onGamepadFocused or nil else nil,
            onFocusLost = if isGamepadFocusable then arg1.onGamepadFocusLost or nil else nil,
            Selectable = arg1.props.Selectable,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            [Roact.Event.InputBegan] = arg1.inputBegan,
            [Roact.Event.InputEnded] = arg1.inputEnded,
            [Roact.Change.CanvasPosition] = arg1.canvasPosition,
            [Roact.Change.CanvasSize] = arg1.props[Roact.Change.CanvasSize],
            [Roact.Event.SelectionChanged] = arg1.props.onSelectionChanged,
            [Roact.Ref] = arg1.props.scrollingFrameRef
        }, var2)
    }
    return createElement(str1, tbl4, tbl5)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithProviders(arg2, nil, arg1.props.cursor)
    end)
end

function var1.didMount(arg1)
    local value = arg1.parentFrameRef:getValue()
    if value then
        arg1.updatePaddingBinding(value.AbsoluteSize.X)
    end
end

function var1.willUnmount(arg1)
    arg1.disconnectWaitToHideSidebar()
end

return Roact.forwardRef(function(arg1, scrollingFrameRef)
    local cursor = useCursorByType(CursorType.RoundedRect)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { scrollingFrameRef = scrollingFrameRef, cursor = cursor }))
end)

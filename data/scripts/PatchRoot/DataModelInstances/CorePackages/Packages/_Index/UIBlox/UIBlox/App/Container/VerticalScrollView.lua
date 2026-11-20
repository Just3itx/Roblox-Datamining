-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local scriptParent = script.Parent
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent

local Cryo = require(scriptParentParentParentParent.Cryo)
local Otter = require(scriptParentParentParentParent.Otter)
local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Focusable = require(scriptParentParentParentParent.RoactGamepad).Focusable

local withStyle = require(scriptParentParentParentParent.UIBlox.Core.Style.withStyle)
local useCursorByType = require(scriptParentParent.SelectionCursor.useCursorByType)
local CursorType = require(scriptParentParent.SelectionCursor.CursorType)

local Images = require(scriptParentParentParentParent.UIBlox.App.ImageSet.Images)
local ScrollBarType = require(scriptParent.Enum.ScrollBarType)
local ScrollBar = require(script.Parent.ScrollBar)

local tbl1 = { frequency = 3, dampingRatio = 1.5 }

local var1 = Roact.Component:extend("VerticalScrollView")

local strictInterface = t.strictInterface
local tbl2 = {
    size = t.optional(t.UDim2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.number),
    elasticBehavior = t.optional(t.EnumItem),
    canvasSizeY = t.optional(t.UDim),
    automaticSize = t.optional(t.enum(Enum.AutomaticSize)),
    useAutomaticCanvasSize = t.optional(t.boolean),
    isGamepadFocusable = t.optional(t.boolean),
    scrollingEnabled = t.optional(t.boolean),
    selectable = t.optional(t.boolean),
    [Roact.Change.CanvasPosition] = t.optional(t.callback),
    [Roact.Change.CanvasSize] = t.optional(t.callback),
    scrollingFrameRef = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    [Roact.Children] = t.optional(t.table),
    scrollBarType = t.optional(t.string),
    cursor = t.table
}
var1.validateProps = strictInterface(tbl2)

var1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0),
    canvasSizeY = UDim.new(2, 0),
    automaticSize = Enum.AutomaticSize.None,
    useAutomaticCanvasSize = false,
    isGamepadFocusable = false,
    selectable = nil,
    scrollingEnabled = true,
    scrollBarType = ScrollBarType.Compact
}

function var1.init(arg1)
    arg1.parentFrameRef = Roact.createRef()
    arg1.mainCanvasRef = Roact.createRef()

    local scrollPosition, updateScroll = Roact.createBinding(0)
    arg1.scrollPosition = scrollPosition
    arg1.updateScroll = updateScroll
    local mainCanvasSize, updateCanvasSize = Roact.createBinding(Vector2.new(0, 0))
    arg1.mainCanvasSize = mainCanvasSize
    arg1.updateCanvasSize = updateCanvasSize

    arg1:setState({ scrollingWithTouch = false })

    local scrollBarImageTransparency, updateScrollBarImageTransparency = Roact.createBinding(1)
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
        if not arg1.props.scrollingEnabled then
            return
        end

        if arg2.UserInputType == Enum.UserInputType.MouseMovement then
            arg1.disconnectWaitToHideSidebar()
            arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(0))
        end
    end
    function arg1.inputEnded(_, arg2)
        if not arg1.props.scrollingEnabled then
            return
        end

        if arg2.UserInputType == Enum.UserInputType.MouseMovement then
            arg1.disconnectWaitToHideSidebar()
            arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(1))
        end
    end
    function arg1.canvasPosition(arg2)
        arg1.lastTimeCanvasPositionChanged = tick()
        if not arg1.waitToHideSidebarConnection and UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
            arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(0))
            arg1.waitToHideSidebarConnection = RunService.Heartbeat:Connect(arg1.waitToHideSidebar)
        end

        arg1.updateScroll(arg2.CanvasPosition.Y)

        if arg1.props[Roact.Change.CanvasPosition] then
            arg1.props[Roact.Change.CanvasPosition](arg2)
        end
    end

    function arg1.onGamepadFocused()
        arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(0))
    end

    function arg1.onGamepadFocusLost()
        arg1.scrollBarImageTransparencyMotor:setGoal(Otter.instant(1))
    end

    function arg1.getMainCanvasPosition()
        return arg1.scrollPosition:map(function(y: number?): Vector2
            return Vector2.new(0, y)
        end)
    end

    function arg1.onMainCanvasSizeChange(arg2)
        arg1.updateCanvasSize(arg2.AbsoluteCanvasSize)
    end

    function arg1.getMainCanvasSize()
        return arg1.mainCanvasSize:map(function(arg2): UDim2
            return UDim2.new(0, 2, 0, arg2.Y)
        end)
    end

    local viewSize, updateViewSize = Roact.createBinding(Vector2.new(0, 0))
    arg1.viewSize = viewSize
    arg1.updateViewSize = updateViewSize
    local mainCanvasPosition, updateMainCanvasPosition = Roact.createBinding(Vector2.new(0, 0))
    arg1.mainCanvasPosition = mainCanvasPosition
    arg1.updateMainCanvasPosition = updateMainCanvasPosition

    function arg1.onScrollBarDragging(y: number?)
        arg1.updateMainCanvasPosition(Vector2.new(0, y))
    end

    function arg1.onViewSizeChange(arg2)
        arg1.updateViewSize(arg2.AbsoluteSize)
    end

    function arg1.onSelectionChanged(arg2, arg3, _, arg4)
        if not arg3 and arg4 == nil then
            arg1.onGamepadFocusLost()
            return
        end

        if arg3 or arg4:IsDescendantOf(arg2) then
            arg1.onGamepadFocused()
        else
            arg1.onGamepadFocusLost()
        end
    end
end

function var1.getScrollBarStyleProps(_, arg1, arg2)
    local tokens = arg1.Tokens

    if arg2 == ScrollBarType.Wide then
        return {
            userInteractionEnabled = true,
            width = tokens.Size.Size_400,
            handleWidth = tokens.Size.Size_200,
            paddingStartEnd = tokens.Size.Size_100,
            marginRight = 0
        }
    end

    if arg2 ~= ScrollBarType.Gamepad then
        return {
            userInteractionEnabled = false,
            width = tokens.Size.Size_300,
            handleWidth = tokens.Size.Size_50,
            paddingStartEnd = tokens.Size.Size_100,
            marginRight = 0
        }
    end

    return {
        userInteractionEnabled = false,
        width = tokens.Size.Size_400,
        handleWidth = tokens.Size.Size_200,
        handleIcon = Images["icons/controls/keys/xboxRSVertical"],
        handleIconSize = tokens.Size.Size_900,
        handleIconColor = {
            Color = tokens.Color.Content.Emphasis.Color3,
            Transparency = tokens.Color.Content.Emphasis.Transparency
        },
        paddingStartEnd = tokens.Size.Size_600,
        marginRight = tokens.Size.Size_600
    }
end

function var1.renderScrollBar(arg1, arg2)
    local tokens = arg2.Tokens
    local scrollBarStyleProps = arg1:getScrollBarStyleProps(arg2, arg1.props.scrollBarType)

    return Roact.createElement(ScrollBar, {
        userInteractionEnabled = scrollBarStyleProps.userInteractionEnabled,
        width = scrollBarStyleProps.width,
        anchorPoint = Vector2.new(1, 0),
        position = UDim2.new(1, -scrollBarStyleProps.marginRight, 0, 0),
        zIndex = 2,
        transparency = arg1.scrollBarImageTransparency,
        backgroundColor = scrollBarStyleProps.backgroundColor,
        paddingStartEnd = scrollBarStyleProps.paddingStartEnd,
        handleWidth = scrollBarStyleProps.handleWidth,
        handleColor = {
            Color = tokens.Color.Shift.Shift_400.Color3,
            Transparency = tokens.Color.Shift.Shift_400.Transparency
        },
        handleCornerRadius = tokens.Radius.Circle,
        handleIcon = scrollBarStyleProps.handleIcon,
        handleIconColor = scrollBarStyleProps.handleIconColor,
        handleIconSize = scrollBarStyleProps.handleIconSize,
        onDragging = arg1.onScrollBarDragging,
        viewSize = arg1.viewSize,
        canvasSize = arg1.mainCanvasSize,
        canvasPosition = arg1.getMainCanvasPosition()
    })
end

function var1.renderWithProviders(arg1, arg2, _, selectionImageObject)
    local position = arg1.props.position
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local canvasSizeY = arg1.props.canvasSizeY
    local automaticSize = arg1.props.automaticSize
    local automaticSizeY = arg1.props.useAutomaticCanvasSize and Enum.AutomaticSize.Y or nil
    local isGamepadFocusable = arg1.props.isGamepadFocusable
    local scrollingEnabled = arg1.props.scrollingEnabled

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Position = position,
        Size = size,
        AutomaticSize = automaticSize,
        LayoutOrder = layoutOrder,
        ClipsDescendants = true,
        [Roact.Ref] = arg1.parentFrameRef
    }
    local tbl4 = {
        MainCanvas = Roact.createElement(
            isGamepadFocusable and Focusable.ScrollingFrame or "ScrollingFrame",
            {
                Active = false,
                AutomaticSize = automaticSize,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                ElasticBehavior = arg1.props.elasticBehavior,
                CanvasSize = UDim2.new(UDim.new(1, 0), canvasSizeY),
                AutomaticCanvasSize = automaticSizeY,
                CanvasPosition = arg1.mainCanvasPosition,
                ScrollingEnabled = scrollingEnabled,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                Selectable = arg1.props.selectable,
                SelectionImageObject = selectionImageObject,
                onFocusGained = if isGamepadFocusable then arg1.onGamepadFocused or nil else nil,
                onFocusLost = if isGamepadFocusable then arg1.onGamepadFocusLost or nil else nil,
                NextSelectionLeft = arg1.props.NextSelectionLeft,
                NextSelectionRight = arg1.props.NextSelectionRight,
                NextSelectionUp = arg1.props.NextSelectionUp,
                NextSelectionDown = arg1.props.NextSelectionDown,
                [Roact.Event.InputBegan] = arg1.inputBegan,
                [Roact.Event.InputEnded] = arg1.inputEnded,
                [Roact.Change.CanvasPosition] = arg1.canvasPosition,
                [Roact.Change.AbsoluteCanvasSize] = arg1.onMainCanvasSizeChange,
                [Roact.Change.CanvasSize] = arg1.props[Roact.Change.CanvasSize],
                [Roact.Ref] = arg1.props.scrollingFrameRef,
                [Roact.Change.AbsoluteSize] = arg1.onViewSizeChange,
                [Roact.Event.SelectionChanged] = if isGamepadFocusable then arg1.onSelectionChanged else nil
            },
            arg1.props[Roact.Children]
        ),
        ScrollBar = arg1:renderScrollBar(arg2)
    }
    return createElement(str1, tbl3, tbl4)
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return arg1:renderWithProviders(arg2, nil, arg1.props.cursor)
    end)
end

function var1.willUnmount(arg1)
    arg1.disconnectWaitToHideSidebar()
end

return Roact.forwardRef(function(arg1, scrollingFrameRef)
    local cursor = useCursorByType(CursorType.RoundedRect)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { scrollingFrameRef = scrollingFrameRef, cursor = cursor }))
end)

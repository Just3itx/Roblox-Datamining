-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Roact = require(AppBloxParent.Roact)

local var1 = Roact.PureComponent:extend("AppCarousel")

function var1.render(arg1)
    local carouselHeight = arg1.props.carouselHeight
    local canvasWidth = arg1.props.canvasWidth
    local items = arg1.props.items
    local onChangeCanvasPosition = arg1.props.onChangeCanvasPosition
    local onRefCallback = arg1.props.onRefCallback

    local canvasPosition = arg1.props.canvasPosition
    local scrollingEnabled = not arg1.props.scrollingAnimationActive
    local shouldExpandToFitContentHeight = arg1.props.shouldExpandToFitContentHeight

    return Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, carouselHeight),
        AutomaticSize = if shouldExpandToFitContentHeight then Enum.AutomaticSize.Y else nil,
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = false,
        CanvasSize = UDim2.new(0, canvasWidth, 0, carouselHeight),
        AutomaticCanvasSize = if shouldExpandToFitContentHeight then Enum.AutomaticSize.Y else nil,
        CanvasPosition = canvasPosition,
        ScrollingEnabled = scrollingEnabled,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ElasticBehavior = Enum.ElasticBehavior.Always,
        Selectable = false,
        [Roact.Change.CanvasPosition] = onChangeCanvasPosition,
        [Roact.Ref] = onRefCallback
    }, items)
end

return var1

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:21:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local ScrollView = require(Foundation.Components.ScrollView)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local function computeAutomaticSize(tbl1)
    if tbl1.autoSize then
        if tbl1.isOverMaxHeight then
            return Enum.AutomaticSize.X
        end

        return Enum.AutomaticSize.XY
    end

    if tbl1.isOverMaxHeight then
        return Enum.AutomaticSize.None
    end

    return Enum.AutomaticSize.Y
end

local function computeSize(tbl1): UDim2
    local uDim = if tbl1.isOverMaxHeight and tbl1.maxHeight then UDim.new(0, tbl1.maxHeight) else UDim.new()

    if tbl1.autoSize then
        return UDim2.new(UDim.new(), uDim)
    end

    return UDim2.new(tbl1.width or UDim.new(), uDim)
end

local function BaseMenuScrollContainer(tbl1)
    local var1 = React.useBinding(true)
    local var2 = React.useBinding(nil)
    local autoSize = tbl1.autoSize or var1
    local width = tbl1.width or var2
    local maxHeight = tbl1.maxHeight

    local var5, var6 = React.useBinding(UDim2.fromScale(0, 1))

    local isOverMaxHeight = React.useMemo(function()
        return React.joinBindings({ canvasSize = var5, maxHeight = maxHeight }):map(function(tbl2): boolean
            return not (tbl2.maxHeight == nil) and tbl2.canvasSize.Y.Offset > tbl2.maxHeight
        end)
    end, { maxHeight })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        return var6(UDim2.fromOffset(arg1.AbsoluteSize.X, arg1.AbsoluteSize.Y))
    end, { var6 })

    local automaticSize = React.joinBindings({ autoSize = autoSize, isOverMaxHeight = isOverMaxHeight }):map(computeAutomaticSize)

    return React.createElement(
        ScrollView,
        withCommonProps(tbl1.scrollViewProps, {
            ref = tbl1.scrollViewProps.ref,
            sizeConstraint = tbl1.scrollViewProps.sizeConstraint,
            tag = tbl1.scrollViewProps.tag,
            InputSink = tbl1.scrollViewProps.InputSink,
            scrollingFrameRef = tbl1.scrollViewProps.scrollingFrameRef,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                AutomaticSize = automaticSize,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                CanvasSize = var5
            },
            AutomaticSize = automaticSize,
            Size = React.joinBindings({ autoSize = autoSize, width = width, isOverMaxHeight = isOverMaxHeight, maxHeight = maxHeight }):map(
                computeSize
            )
        }),
        React.createElement(
            View,
            { tag = "col size-full-0 auto-y", onAbsoluteSizeChanged = onAbsoluteSizeChanged },
            tbl1.children
        )
    )
end
return BaseMenuScrollContainer

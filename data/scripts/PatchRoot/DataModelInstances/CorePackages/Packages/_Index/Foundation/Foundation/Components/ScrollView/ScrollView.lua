-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local ScrollingFrame = require(script.Parent.ScrollingFrame)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useDefaultTags = require(Foundation.Utility.useDefaultTags)
local withDefaults = require(Foundation.Utility.withDefaults)

local useStyleTags = require(Foundation.Providers.Style.useStyleTags)

local Visibility = require(Foundation.Enums.Visibility)

local ControlState = require(Foundation.Enums.ControlState)

local tbl1 = {
    layout = {
        SortOrder = Enum.SortOrder.LayoutOrder
    },
    scroll = {
        scrollBarVisibility = Visibility.Auto
    },
    AutoLocalize = false,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    isDisabled = false,
    testId = "--foundation-scroll-view"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: ScrollView
    local var1 = withDefaults(arg1, tbl1)

    local var2 = useDefaultTags(var1.tag, "gui-object-defaults")
    local var3 = useStyleTags(var2)

    local controlState, var5 = React.useState(ControlState.Initialize)

    local var6 = table.clone(var1)

    function var6.onStateChanged(arg2)
        var5(arg2)
        if var1.onStateChanged ~= nil then
            var1.onStateChanged(arg2)
        end
    end

    var6.stateLayer = not (var1.onStateChanged or var1.onActivated) and { affordance = "None" } or var1.stateLayer

    var6.selection = { Selectable = false }

    var6.ref = ref
    var6[React.Tag] = var3
    var6.scroll = nil
    var6.layout = nil

    local tbl2 = {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = var1.layout.FillDirection,
            ItemLineAlignment = var1.layout.ItemLineAlignment,
            HorizontalAlignment = var1.layout.HorizontalAlignment,
            HorizontalFlex = var1.layout.HorizontalFlex,
            VerticalAlignment = var1.layout.VerticalAlignment,
            VerticalFlex = var1.layout.VerticalFlex,
            Padding = var1.layout.Padding,
            SortOrder = var1.layout.SortOrder,
            Wraps = var1.layout.Wraps
        })
    }

    if var1.children and typeof(var1.children) == "table" and var1.layout ~= nil and var1.layout.FillDirection ~= nil then
        for k, child in var1.children do
            tbl2[k] = child
        end
    else
        tbl2 = var1.children
    end

    return React.createElement(View, var6, {
        ScrollingFrame = React.createElement(ScrollingFrame, {
            controlState = controlState,
            selection = var1.selection,
            scrollBarVisibility = var1.scroll.scrollBarVisibility,
            onCanvasPositionChanged = var1.onCanvasPositionChanged,
            onAbsoluteCanvasSizeChanged = var1.onAbsoluteCanvasSizeChanged,
            onAbsoluteWindowSizeChanged = var1.onAbsoluteWindowSizeChanged,
            AutomaticSize = var1.scroll.AutomaticSize,
            AutomaticCanvasSize = var1.scroll.AutomaticCanvasSize,
            CanvasSize = var1.scroll.CanvasSize,
            ClipsDescendants = false,
            ScrollingDirection = var1.scroll.ScrollingDirection,
            ScrollingEnabled = var1.scroll.ScrollingEnabled,
            VerticalScrollBarInset = var1.scroll.VerticalScrollBarInset,
            HorizontalScrollBarInset = var1.scroll.HorizontalScrollBarInset,
            ref = var1.scrollingFrameRef
        }, tbl2)
    })
end))

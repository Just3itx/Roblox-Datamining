-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParentParent = script:FindFirstAncestor("Components").Parent.Parent
local InlineLayoutElements = script:FindFirstAncestor("InlineLayoutElements")

local React = require(ComponentsParentParent.React)
local Foundation = require(ComponentsParentParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local InlineSpanElement = require(InlineLayoutElements.InlineSpanElement)
local HoverContext = require(InlineLayoutElements.HoverContext)
local _RenderableInlineElement = require(InlineLayoutElements.RenderableInlineElement)

local module = {}

function HoverContextWrapper(arg1)
    local var1, var2 = HoverContext.useHoverContext(arg1.id)
    local onStateChanged = React.useCallback(function(hover)
        var2(hover == Foundation.Enums.ControlState.Hover)
    end, { var2 })
    local hover = useTokens().Color.State.Hover

    local createElement = React.createElement
    local view = Foundation.View
    local tbl1 = {
        tag = "size-0-0 auto-xy row",
        LayoutOrder = arg1.LayoutOrder,
        onActivated = arg1.onActivated,
        backgroundStyle = 0,
        onStateChanged = 0,
        stateLayer = 0
    }

    if not var1 then
        hover = nil
    end

    tbl1.backgroundStyle = hover
    tbl1.onStateChanged = onStateChanged
    tbl1.stateLayer = {
        affordance = Foundation.Enums.StateLayerAffordance.None
    }
    return createElement(view, tbl1, arg1.children)
end

function module.new(tbl1, tbl2)
    return InlineSpanElement.new(HoverContextWrapper, tbl2, tbl1)
end

return module

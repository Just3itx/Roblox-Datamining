-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)

local _Types = require(script.Parent.Types)
local Sizing = require(script.Parent.Parent.Parent.Sizing)

local indexBindable = Foundation.Utility.indexBindable

return React.forwardRef(function(tbl1, ref) -- name: BubbleView
    local bubble = Sizing.useSizing().bubble
    local paddingX = bubble.paddingX
    local paddingY = bubble.paddingY
    local minHeight = bubble.minHeight
    local contentMaxWidth = bubble.contentMaxWidth
    local cornerRadii = tbl1.cornerRadii

    local cornerRadius = React.useMemo(function()
        return {
            topLeft = indexBindable(cornerRadii, "topLeft"),
            topRight = indexBindable(cornerRadii, "topRight"),
            bottomLeft = indexBindable(cornerRadii, "bottomLeft"),
            bottomRight = indexBindable(cornerRadii, "bottomRight")
        }
    end, { cornerRadii })

    local padding = React.useMemo(function()
        return {
            top = UDim.new(0, paddingY),
            bottom = UDim.new(0, paddingY),
            left = UDim.new(0, paddingX),
            right = UDim.new(0, paddingX)
        }
    end, { paddingX, paddingY })

    local sizeConstraint = React.useMemo(function()
        return {
            MinSize = Vector2.new(0, math.max(0, minHeight - paddingY * 2)),
            MaxSize = Vector2.new(contentMaxWidth, math.huge)
        }
    end, { minHeight, paddingY, contentMaxWidth })

    return React.createElement(Foundation.View, {
        tag = "col align-y-center auto-xy",
        backgroundStyle = tbl1.backgroundStyle,
        cornerRadius = cornerRadius,
        padding = padding,
        sizeConstraint = sizeConstraint,
        LayoutOrder = tbl1.LayoutOrder,
        Visible = tbl1.Visible,
        testId = tbl1.testId,
        ref = ref
    }, tbl1.children)
end)

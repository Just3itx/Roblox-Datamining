-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)

local tbl1 = { name = "lightning-bolt", variant = "Regular" }

return React.memo(function(tbl2) -- name: ExpressionEntryButtonView
    if tbl2.isFullWidth then
        return React.createElement(Foundation.Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fit,
            onActivated = tbl2.onActivated,
            text = tbl2.text or "",
            variant = Foundation.Enums.ButtonVariant.Standard,
            width = UDim.new(1, 0),
            ref = tbl2.buttonRef
        })
    end

    local var1 = tbl2.icon or tbl1
    local icon = tbl2.isActive and {
        name = var1.name,
        variant = "Filled"
    } or var1

    return React.createElement(Foundation.IconButton, {
        icon = icon,
        variant = Foundation.Enums.ButtonVariant.Standard,
        size = if tbl2.size ~= nil then tbl2.size else Foundation.Enums.InputSize.Small,
        isCircular = true,
        isDisabled = false,
        onActivated = tbl2.onActivated,
        ref = tbl2.buttonRef
    })
end)

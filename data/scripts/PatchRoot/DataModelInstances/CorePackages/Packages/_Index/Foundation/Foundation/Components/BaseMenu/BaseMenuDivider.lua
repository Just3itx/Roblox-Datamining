-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function BaseMenuDivider(tbl1)
    local var1 = useTokens()
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            Size = UDim2.new(1, 0, 0, var1.Stroke.Standard),
            tag = "row flex-x-fill",
            testId = "--foundation-menu-divider-item"
        },
        React.createElement(View, { tag = "grow size-0-full", backgroundStyle = var1.Color.Stroke.Default })
    )
end

return BaseMenuDivider

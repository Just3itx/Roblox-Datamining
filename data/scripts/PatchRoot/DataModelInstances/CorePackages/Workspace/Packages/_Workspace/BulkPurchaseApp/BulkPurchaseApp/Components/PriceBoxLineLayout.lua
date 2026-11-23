-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local View = require(BulkPurchaseAppParent.Foundation).View

local function PriceBoxLineLayout(tbl1)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "row align-y-center gap-large size-full-0 auto-y"
        },
        {
            Start = React.createElement(View, { LayoutOrder = 1, tag = "fill auto-y" }, { Content = tbl1.startSlot }),
            End = React.createElement(View, { LayoutOrder = 2, tag = "auto-xy" }, { Content = tbl1.endSlot })
        }
    )
end

return PriceBoxLineLayout

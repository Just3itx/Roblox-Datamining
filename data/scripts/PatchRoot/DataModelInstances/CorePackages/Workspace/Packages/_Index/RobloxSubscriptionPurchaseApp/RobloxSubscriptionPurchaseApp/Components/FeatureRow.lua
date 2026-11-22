-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize

local function FeatureRow(tbl1)
    return React.createElement(
        View,
        {
            tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Icon = React.createElement(Icon, { name = tbl1.iconName, size = IconSize.Medium }),
            FeatureText = React.createElement(
                FoundationText,
                {
                    Text = tbl1.text,
                    tag = "size-full-0 auto-y text-body-medium text-align-x-left content-default"
                }
            )
        }
    )
end
return FeatureRow

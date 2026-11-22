-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreenParentParent = script:FindFirstAncestor("TiltLoadingScreen").Parent.Parent

local React = require(TiltLoadingScreenParentParent.React)
local Foundation = require(TiltLoadingScreenParentParent.Foundation)
local View = Foundation.View
local Icon = Foundation.Icon
local Enums = Foundation.Enums

local function VerifiedBadge(tbl1)
    return React.createElement(View, {
        tag = "auto-xy",
        LayoutOrder = tbl1.LayoutOrder,
        testId = "tilt-verified-badge"
    }, {
        Backplate = React.createElement(Icon, {
            name = "verified-backplate",
            variant = Enums.IconVariant.Filled,
            size = Enums.IconSize.Small,
            style = tbl1.backplateStyle,
            ZIndex = 1
        }),
        Check = React.createElement(Icon, {
            name = "verified-check",
            variant = Enums.IconVariant.Filled,
            size = Enums.IconSize.Small,
            style = tbl1.checkStyle,
            ZIndex = 2
        })
    })
end

return VerifiedBadge

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadgesParent = script:FindFirstAncestor("VerifiedBadges").Parent

local React = require(VerifiedBadgesParent.React)
local Foundation = require(VerifiedBadgesParent.Foundation)

local Icon = Foundation.Icon
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local function VerifiedBadge(tbl1)
    local var1 = useTokens()
    local size = tbl1.size or IconSize.Small
    local style = tbl1.backplateStyle or var1.Color.System.Emphasis
    local var2 = tbl1.checkStyle or var1.Color.Extended.White.White_100

    return React.createElement(View, {
        tag = "auto-xy",
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }, {
        Backplate = React.createElement(
            Icon,
            {
                name = IconName.VerifiedBackplate,
                variant = IconVariant.Filled,
                size = size,
                style = style,
                ZIndex = 1
            }
        ),
        Check = React.createElement(
            Icon,
            {
                name = IconName.VerifiedCheck,
                variant = IconVariant.Filled,
                size = size,
                style = var2,
                ZIndex = 2
            }
        )
    })
end

return VerifiedBadge

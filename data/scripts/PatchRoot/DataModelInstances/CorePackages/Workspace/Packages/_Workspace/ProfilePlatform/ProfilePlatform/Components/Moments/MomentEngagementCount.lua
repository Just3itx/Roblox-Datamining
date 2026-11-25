-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local useAbbreviatedNumberLocalization = require(ProfilePlatformParent.Localization).Hooks.useAbbreviatedNumberLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local useTokens = Foundation.Hooks.useTokens

local function MomentEngagementCount(tbl1)
    local var1 = useAbbreviatedNumberLocalization(tbl1.count or 0)
    local var2 = useTokens()
    local bool1 = tbl1.onMedia == true
    local white100 = if bool1 then var2.Color.Extended.White.White_100 else nil
    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "row align-x-left align-y-center gap-xxsmall auto-xy"
    }
    local tbl3 = {
        Glyph = React.createElement(Icon, {
            LayoutOrder = 1,
            name = tbl1.icon,
            size = IconSize.XSmall,
            variant = if bool1 then IconVariant.Filled else nil,
            style = white100
        }),
        Count = React.createElement(FoundationText, {
            LayoutOrder = 2,
            tag = {
                ["auto-xy text-body-small"] = true,
                ["content-default"] = not bool1
            },
            textStyle = white100,
            Text = var1 or ""
        })
    }
    return createElement(var3, tbl2, tbl3)
end

return MomentEngagementCount

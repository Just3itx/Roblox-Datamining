-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization

local FFlagAvatarSwitcherExpiredItemsWarning = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherExpiredItemsWarning

local function AvatarCompatibilityWarning(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({
        partiallyUnsupported = if FFlagAvatarSwitcherExpiredItemsWarning then nil else "Feature.AvatarSwitcher.Message.PartiallyUnsupported",
        message = if FFlagAvatarSwitcherExpiredItemsWarning then tbl1.message else nil
    })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        InfoIcon = React.createElement(
            Foundation.Image,
            {
                Image = "icons/actions/info",
                Size = UDim2.fromOffset(var1.Size.Size_500, var1.Size.Size_500),
                LayoutOrder = 1
            }
        ),
        CompatibilityWarning = React.createElement(Foundation.Text, {
            tag = "auto-y position-top-right anchor-top-right text-caption-small text-wrap text-align-x-left padding-top-xsmall",
            Size = UDim2.new(1, -var1.Size.Size_500 - var1.Gap.Small, 0, 0),
            Text = if FFlagAvatarSwitcherExpiredItemsWarning then var2.message else var2.partiallyUnsupported,
            LayoutOrder = 2
        })
    }
    return createElement(view, tbl2, tbl3)
end

return AvatarCompatibilityWarning

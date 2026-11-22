-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperienceParent = script:FindFirstAncestor("IAPExperience").Parent

local React = require(IAPExperienceParent.React)

local Foundation = require(IAPExperienceParent.Foundation)
local View = Foundation.View
local Checkbox = Foundation.Checkbox
local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local BadgeShape = Foundation.Enums.BadgeShape
local IconVariant = Foundation.Enums.IconVariant
local IconPosition = Foundation.Enums.IconPosition
local useTokens = Foundation.Hooks.useTokens

local BuilderIcons = require(IAPExperienceParent.BuilderIcons)

local useRemainingTimeText = require(IAPExperienceParent.InExperienceOffers).Hooks.useRemainingTimeText

local useLocalization = require(IAPExperienceParent.Localization).Hooks.useLocalization

local FFlagEnableInExperienceOfferExpiryBadge = require(IAPExperienceParent.SharedFlags).FFlagEnableInExperienceOfferExpiryBadge
local bool1 = game:DefineFastFlag("UpdateOfferExpiryBadgeBoxShape", false)

local function OfferCheckboxRow(tbl1)
    local var1 = useTokens()
    local timeRemaining = useRemainingTimeText(tbl1.expirationTimeUtc)

    local var3 = useLocalization({ endTime = { "Feature.InExperienceShop.Label.EndTime", timeRemaining = timeRemaining or "" } })

    local layoutOrder = tbl1.LayoutOrder or 0

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "row wrap align-x-left items-center gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        padding = {
            right = UDim.new(0, var1.Size.Size_400 + var1.Gap.Medium)
        }
    }
    local tbl3 = {
        Checkbox = React.createElement(Checkbox, {
            LayoutOrder = layoutOrder,
            size = Foundation.Enums.InputSize.XSmall,
            label = tbl1.label,
            isChecked = tbl1.isChecked,
            isDisabled = tbl1.isDisabled,
            onActivated = tbl1.onActivated
        }),
        ExpiryBadge = if FFlagEnableInExperienceOfferExpiryBadge and timeRemaining ~= nil then React.createElement(Badge, {
            LayoutOrder = layoutOrder + 1,
            icon = {
                name = BuilderIcons.Icon.Clock,
                variant = IconVariant.Filled,
                position = IconPosition.Left
            },
            text = var3.endTime,
            variant = BadgeVariant.Standard,
            shape = if bool1 then BadgeShape.Box else nil
        }) else nil
    }
    return createElement(var4, tbl2, tbl3)
end

return OfferCheckboxRow

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local BuilderIcons = require(AvatarExperienceCommonParent.BuilderIcons)
local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization

local useRemainingTimeText = require(AvatarExperienceCommon.Hooks.useRemainingTimeText)

local BadgeVariant = Foundation.Enums.BadgeVariant
local BadgeShape = Foundation.Enums.BadgeShape
local IconVariant = Foundation.Enums.IconVariant
local IconPosition = Foundation.Enums.IconPosition

local function OfferExpiryBadge(tbl1)
    local timeRemaining = useRemainingTimeText(tbl1.expirationTimeInUTC)
    local var2 = useLocalization({ endTime = { "Feature.InExperienceShop.Label.EndTime", timeRemaining = timeRemaining or "" } })

    if timeRemaining == nil then
        return nil
    end

    return (React.createElement(Foundation.Badge, {
        LayoutOrder = tbl1.layoutOrder,
        icon = {
            name = BuilderIcons.Icon.Clock,
            variant = IconVariant.Filled,
            position = IconPosition.Left
        },
        text = var2.endTime,
        variant = BadgeVariant.Standard,
        shape = BadgeShape.Box
    }))
end
return OfferExpiryBadge

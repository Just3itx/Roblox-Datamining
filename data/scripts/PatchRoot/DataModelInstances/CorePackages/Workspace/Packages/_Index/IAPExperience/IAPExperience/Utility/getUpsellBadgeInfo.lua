-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Enums = require(scriptParentParentParent.Foundation).Enums

local BadgeType = require(scriptParentParent.Enums.BadgeType)

local GetFFlagIAPExperienceEnableBestValueBadge = require(scriptParentParent.Flags.GetFFlagIAPExperienceEnableBestValueBadge)

local function getUpsellBadgeInfo(arg1, tbl1)
    local var1

    if arg1 == BadgeType.Popular then
        var1 = tbl1.Popular
    elseif arg1 == BadgeType.LastPurchased then
        var1 = tbl1.LastPurchased
    elseif arg1 == BadgeType.ForYou then
        var1 = tbl1.ForYouItem
    elseif arg1 == BadgeType.BetterValue then
        var1 = tbl1.BetterValue
    elseif arg1 == BadgeType.BestValue and GetFFlagIAPExperienceEnableBestValueBadge() then
        var1 = tbl1.BestValue
    else
        var1 = nil
    end

    local var2

    if arg1 == BadgeType.Popular then
        var2 = Enums.IconName.Flame
    elseif arg1 == BadgeType.ForYou then
        var2 = Enums.IconName.CircleStar
    elseif arg1 == BadgeType.BetterValue then
        var2 = Enums.IconName.Tag
    elseif arg1 == BadgeType.BestValue and GetFFlagIAPExperienceEnableBestValueBadge() then
        var2 = Enums.IconName.Pig
    else
        var2 = nil
    end

    return { text = var1, icon = var2 }
end

return getUpsellBadgeInfo

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local useRemainingTime = require(AvatarExperienceCommonParent.AvatarExperienceUIKit).Hooks.useRemainingTime
local useLocalization = require(AvatarExperienceCommonParent.Localization).Hooks.useLocalization

local getRemainingTimeText = require(AvatarExperienceCommon.Utils.getRemainingTimeText)

local function useRemainingTimeText(str1: string?)
    local var1 = useRemainingTime(str1)
    local number = if var1 == nil then 0 else var1.value

    local var3 = useLocalization({
        daySingular = "Feature.InExperienceShop.Label.Timer.Day.Singular",
        dayPlural = { "Feature.InExperienceShop.Label.Timer.Day.Plural", number = number },
        hourSingular = "Feature.InExperienceShop.Label.Timer.Hour.Singular",
        hourPlural = { "Feature.InExperienceShop.Label.Timer.Hour.Plural", number = number },
        minuteSingular = "Feature.InExperienceShop.Label.Timer.Minute.Singular",
        minutePlural = { "Feature.InExperienceShop.Label.Timer.Minute.Plural", number = number },
        secondSingular = "Feature.InExperienceShop.Label.Timer.Second.Singular",
        secondPlural = { "Feature.InExperienceShop.Label.Timer.Second.Plural", number = number }
    })

    if var1 == nil or var1.value <= 0 then
        return nil
    end

    return getRemainingTimeText(var1, var3)
end

return useRemainingTimeText

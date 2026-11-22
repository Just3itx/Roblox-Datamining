-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    month = {
        singular = "Feature.RobloxSubscription.Label.month",
        plural = "Feature.RobloxSubscription.Label.months"
    },
    year = {
        singular = "Feature.RobloxSubscription.Label.year",
        plural = "Feature.RobloxSubscription.Label.years"
    },
    week = {
        singular = "Feature.RobloxSubscription.label.week",
        plural = "Feature.RobloxSubscription.label.weeks"
    }
}

local tbl2 = {
    singular = "Feature.RobloxSubscription.Label.month",
    plural = "Feature.RobloxSubscription.Label.months"
}

local function getPeriodTypeDisplayLabel(str1: string, bool1: boolean)
    local str2 = string.lower(str1)
    local var1 = tbl1[str2] or tbl2

    return if bool1 then var1.plural else var1.singular
end

return getPeriodTypeDisplayLabel

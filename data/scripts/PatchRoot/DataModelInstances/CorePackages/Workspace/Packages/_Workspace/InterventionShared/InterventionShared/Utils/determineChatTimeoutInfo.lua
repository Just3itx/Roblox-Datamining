-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local LocalizationService = game:GetService("LocalizationService")
local var1 = require(InterventionSharedParent.RobloxAppLocales).Localization.new(LocalizationService.RobloxLocaleId)

local tbl1 = {
    {
        threshold = 86400,
        headingPlural = "Feature.InExperienceIntervention.Heading.ChatSuspension.Plural",
        headingSingle = "Feature.InExperienceIntervention.Heading.ChatSuspension.1Day",
        descriptionActive = "Feature.InExperienceIntervention.Description.ChatSuspension.Days",
        descriptionActiveFormatFunction = function(num1: number): string
            return tostring(math.ceil(num1 / 86400))
        end,
        descriptionExpired = "Feature.InExperienceIntervention.Description.ChatSuspension.Day.Expired",
        unitInSeconds = 86400
    },
    {
        threshold = 3600,
        headingPlural = "Feature.InExperienceIntervention.Heading.ChatSuspension.MultiHour",
        headingSingle = "Feature.InExperienceIntervention.Heading.ChatSuspension.1Hour",
        descriptionActive = "Feature.InExperienceIntervention.Description.ChatSuspension.Hours",
        descriptionActiveFormatFunction = function(unixTimestamp: number): string
            return DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime("HH:mm", LocalizationService.RobloxLocaleId)
        end,
        descriptionExpired = "Feature.InExperienceIntervention.Description.ChatSuspension.Hour.Expired",
        unitInSeconds = 3600
    },
    {
        threshold = 1,
        headingPlural = "Feature.InExperienceIntervention.Heading.ChatSuspension.MultiMinute",
        headingSingle = "Feature.InExperienceIntervention.Heading.ChatSuspension.1Minute",
        descriptionActive = "Feature.InExperienceIntervention.Description.ChatSuspension.Minutes",
        descriptionActiveFormatFunction = function(unixTimestamp: number): string
            return DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime("mm:ss", LocalizationService.RobloxLocaleId)
        end,
        descriptionExpired = "Feature.InExperienceIntervention.Description.ChatSuspension.Minute.Expired",
        unitInSeconds = 60
    }
}

local function func1(num1: number, bool1: boolean)
    if bool1 then
        return var1:Format("Feature.InExperienceIntervention.Heading.ChatSuspension.Expired")
    end

    local str1 = ""
    for _, value in tbl1 do
        if num1 == value.unitInSeconds then
            return (var1:Format(value.headingSingle))
        end

        if value.threshold < num1 then
            local number = math.ceil(num1 / value.unitInSeconds)
            return (var1:Format(value.headingPlural, { number = number }))
        end
    end

    return str1
end

return function(dateTime, num1: number?)
    if dateTime == nil or num1 == nil then
        return 0, "", ""
    end

    local dateTime2 = DateTime.now()
    local num2 = math.max(dateTime.UnixTimestamp - dateTime2.UnixTimestamp, 0)
    local num3 = num1 / 1000000000
    local bool1 = num2 <= 0

    local str1 = ""
    local var2 = func1(num3, bool1)

    for _, value in tbl1 do
        if bool1 then
            if value.threshold <= num3 then
                str1 = var1:Format(value.descriptionExpired, { number = math.ceil(num3 / value.unitInSeconds) })
                break
            end
        elseif value.threshold <= num2 then
            str1 = var1:Format(value.descriptionActive, { number = value.descriptionActiveFormatFunction(num2) })
            break
        end
    end

    return num2, var2, str1
end

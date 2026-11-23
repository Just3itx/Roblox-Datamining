-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _DateTime = require(AppChatParent.Time).DateTime
local Localization = require(AppChatParent.RobloxAppLocales).Localization

local RobloxLocaleId = LocalizationService.RobloxLocaleId
local localization = Localization.new(RobloxLocaleId)

return function(arg1)
    local var1 = DateTime.now().UnixTimestamp - arg1.dateTime.UnixTimestamp

    if var1 < 60 then
        return localization:Format("Feature.Chat.Label.TimestampNow")
    elseif var1 < 3600 then
        local numMinutes = math.floor(var1 / 60)
        if numMinutes == 1 then
            return localization:Format("Feature.Chat.Label.TimestampOneMinuteAbbreviated")
        end
        return localization:Format("Feature.Chat.Label.TimestampMinutesAbbreviatedPlural", { num_minutes = numMinutes })
    elseif var1 < 86400 then
        local numHours = math.floor(var1 / 3600)
        if numHours == 1 then
            return localization:Format("Feature.Chat.Label.TimestampOneHourAbbreviated")
        end
        return localization:Format("Feature.Chat.Label.TimestampHoursAbbreviatedPlural", { num_hours = numHours })
    elseif var1 < 604800 then
        local numDays = math.floor(var1 / 86400)
        if numDays == 1 then
            return localization:Format("Feature.Chat.Label.TimestampOneDayAbbreviated")
        end
        return localization:Format("Feature.Chat.Label.TimestampDaysAbbreviatedPlural", { num_days = numDays })
    elseif var1 < 2592000 then
        local numWeeks = math.floor(var1 / 604800)
        if numWeeks == 1 then
            return localization:Format("Feature.Chat.Label.TimestampOneWeekAbbreviated")
        end
        return localization:Format("Feature.Chat.Label.TimestampWeeksAbbreviatedPlural", { num_weeks = numWeeks })
    else
        return arg1:Format("ll")
    end
end

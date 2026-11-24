-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _Signals = require(DataHydrationParent.Signals)
local createCurrentTimeSignal = require(DataHydrationParent.SignalsUtils).createCurrentTimeSignal

local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local ExperienceEventTypes = require(script.Parent.ExperienceEventTypes)

local num1 = game:DefineFastInt("EventStatusCheckIntervalSec", 30)

local function parseIsoDateTime(str1: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not str1 then
        return nil
    end
    local success, result = pcall(DateTime.fromIsoDate, str1)
    return if success and result ~= nil then result else nil
end

local function deriveFormattedStartDate(arg1, arg2)
    local var1 = parseIsoDateTime(arg1.eventStart)
    if not var1 then
        return nil
    end
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local dateTime = DateTime.now()
    local var2 = var1:ToLocalTime()
    local var3 = dateTime:ToLocalTime()
    local var4 = var1:FormatLocalTime(if var2.Year == var3.Year then "ddd, MMM DD" else "ll", robloxLocaleId)
    local var5 = var1:FormatLocalTime("LT", robloxLocaleId)

    return arg2:Format("Feature.VirtualEvents.Label.DateAtTime"):gsub("{date}", var4):gsub("{time}", var5)
end

local EventStatus = ExperienceEventTypes.EventStatus

local function deriveFormattedRelativeTime(arg1, arg2, arg3)
    local eventStartTimestamp = arg1.eventStartTimestamp
    local eventEndTimestamp = arg1.eventEndTimestamp
    if not (eventStartTimestamp or eventEndTimestamp) then
        return nil
    end
    local var1 = createCurrentTimeSignal(num1)(arg2)

    if not eventStartTimestamp or not (var1 < eventStartTimestamp) then
        if eventEndTimestamp and eventEndTimestamp <= var1 then
            return arg3:Format("Feature.VirtualEvents.Label.Ended")
        else
            return arg3:Format("Feature.VirtualEvents.Label.HappeningNow")
        end
    end

    local var2 = eventStartTimestamp - var1

    if var2 >= 604800 then
        return deriveFormattedStartDate(arg1, arg3)
    end

    local num2 = math.floor(var2 / 86400)
    if num2 >= 2 then
        return arg3:Format("Feature.VirtualEvents.Label.InDays"):gsub("{number}", tostring(num2))
    elseif num2 == 1 then
        return arg3:Format("Feature.VirtualEvents.Label.StartsInOneDay")
    else
        local num3 = math.floor(var2 / 3600)
        if num3 >= 2 then
            return arg3:Format("Feature.VirtualEvents.Label.StartsInHours"):gsub("{number}", tostring(num3))
        elseif num3 == 1 then
            return arg3:Format("Feature.VirtualEvents.Label.StartsInOneHour")
        else
            local num4 = math.floor(var2 / 60)
            if num4 >= 2 then
                return arg3:Format("Feature.VirtualEvents.Label.StartsInMinutes"):gsub("{number}", tostring(num4))
            elseif num4 == 1 then
                return arg3:Format("Feature.VirtualEvents.Label.StartsInOneMin")
            end

            return arg3:Format("Feature.VirtualEvents.Label.StartsNow")
        end
    end
end

local function deriveEventStatus(arg1, arg2)
    local eventStartTimestamp = arg1.eventStartTimestamp
    if not eventStartTimestamp then
        return EventStatus.Upcoming
    end
    local eventEndTimestamp = arg1.eventEndTimestamp
    local var1 = createCurrentTimeSignal(num1)(arg2)

    if var1 < eventStartTimestamp then
        if eventStartTimestamp - var1 <= 14400 then
            return EventStatus.UpcomingImminent
        end

        return EventStatus.Upcoming
    end

    if eventEndTimestamp and eventEndTimestamp <= var1 then
        return EventStatus.Elapsed
    end

    if eventEndTimestamp and eventEndTimestamp - var1 <= 14400 then
        return EventStatus.ElapsedImminent
    end

    return EventStatus.Ongoing
end

local function deriveIsActive(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = deriveEventStatus(arg1, arg2)
    return var1 == EventStatus.Ongoing or var1 == EventStatus.ElapsedImminent
end

local function deriveShareUrl(arg1)
    local id = arg1.id
    if not id then
        return nil
    end
    return UrlBuilder.virtualevents.appsflyer({ eventId = tostring(id) })
end

return {
    enrichWithTimestamps = function(arg1)
        local var1 = parseIsoDateTime(arg1.eventStart)
        local var2 = parseIsoDateTime(arg1.eventEnd)
        arg1.eventStartTimestamp = if var1 then var1.UnixTimestamp else nil
        arg1.eventEndTimestamp = if var2 then var2.UnixTimestamp else nil
        return arg1
    end,
    calculateDerivedField = function(str1: string, arg1, arg2, arg3)
        if not arg1 then
            return nil
        elseif str1 == "formattedStartDate" then
            return deriveFormattedStartDate(arg1, arg3)
        elseif str1 == "eventStatus" then
            return (deriveEventStatus(arg1, arg2))
        elseif str1 == "isActive" then
            return (deriveIsActive(arg1, arg2))
        elseif str1 == "formattedRelativeTime" then
            return deriveFormattedRelativeTime(arg1, arg2, arg3)
        elseif str1 == "shareUrl" then
            return deriveShareUrl(arg1)
        end
        return nil
    end
}

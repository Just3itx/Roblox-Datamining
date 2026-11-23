-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)
local Cryo = require(AppChatParent.Cryo)

local tbl1 = { "addSessionInfo", "addOSInfo" }

local function defaultFormatCounter(_, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        placement = arg1.placement,
        entryPoint = arg1.entryPoint,
        hasActiveParty = arg1.currentSquadId ~= nil
    }
end

local function namedCounterConfigurationAndFormat(overrideName: string, func1: (...any) -> (...any))
    return {
        type = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends.RobloxTelemetryCounter,
        overrideName = function()
            return overrideName
        end,
        format = function(arg1, arg2)
            return Cryo.Dictionary.join(defaultFormatCounter(nil, arg2), func1(arg1, arg2))
        end,
        throttlingThousandths = nil
    }
end

local function defaultFormatStat(_, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        placement = arg1.placement,
        entryPoint = arg1.entryPoint,
        hasActiveParty = arg1.currentSquadId ~= nil
    }
end

local function defaultEventIngestFormat<T>(_, arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

local function eventIngestWithFormatFunction(func1: (...any) -> (...any))
    return {
        type = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends.EventIngest,
        standardizedFields = tbl1,
        format = function(arg1, arg2)
            return Cryo.Dictionary.join(arg2, func1(arg1, arg2))
        end,
        overrideName = nil,
        throttlingThousandths = nil
    }
end

return {
    namedCounterConfigurationAndFormat = namedCounterConfigurationAndFormat,
    namedCounterConfigurationNoEmittedInfo = function(str1: string)
        return (namedCounterConfigurationAndFormat(str1, function(_, _)
            return {}
        end))
    end,
    namedStatConfigurationAndFormat = function(overrideName: string, func1: (...any) -> (...any))
        return {
            type = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends.RobloxTelemetryStat,
            overrideName = function()
                return overrideName
            end,
            format = function(arg1, arg2)
                return Cryo.Dictionary.join(defaultFormatStat(nil, arg2), func1(arg1, arg2))
            end,
            throttlingThousandths = nil
        }
    end,
    eventIngestWithFormatFunction = eventIngestWithFormatFunction,
    EVENT_INGEST_NO_EMITTED_INFO = eventIngestWithFormatFunction(function(_, _)
        return {}
    end),
    STANDARDIZED_FIELDS = tbl1
}

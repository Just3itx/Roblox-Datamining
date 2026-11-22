-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local LoggingProtocol = require(MomentsCommonParent.LoggingProtocol)

local tbl1 = {
    eventName = "MomentsAnalyticsSkip",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 9, 2 },
    description = "Counts schema-targeted moment-scoped analytics events skipped because the raw feedItemId was absent. Dimensioned by surface/reason/entry."
}

local function defaultEmit(arg1, num1: number, tbl2)
    LoggingProtocol.default:logRobloxTelemetryCounter(arg1, num1, tbl2)
end

local function reportMomentSkip(surface: string, reason: string, tbl2, func1: ((...any) -> (...any))?)
    local tbl3 = { surface = surface, reason = reason }

    if tbl2 then
        if tbl2.entry ~= nil then
            tbl3.entry = tbl2.entry
        end
        if tbl2.action ~= nil then
            tbl3.action = tbl2.action
        end
        if tbl2.parentEntity ~= nil then
            tbl3.parentEntity = tbl2.parentEntity
        end
    end

    (func1 or defaultEmit)(tbl1, 1, tbl3)
end

return reportMomentSkip

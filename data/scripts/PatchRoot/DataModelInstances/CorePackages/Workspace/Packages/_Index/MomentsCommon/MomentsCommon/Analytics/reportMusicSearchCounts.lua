-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local LoggingProtocol = require(MomentsCommonParent.LoggingProtocol)

local FFlagMomentsCreationMusicSearchCountTelemetry = require(MomentsCommon.Flags.FFlagMomentsCreationMusicSearchCountTelemetry)

local tbl1 = {
    eventName = "MomentsCreationMusicSearchRawCount",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2026, 8, 27 },
    links = "",
    description = "Music-search result count BEFORE the creation-flow ISRC/RecordingCode filter (post creator-filter). Aggregated to p50/p95/p99; compare against MomentsCreationMusicSearchFilteredCount to see the filter drop. Dimensioned by queryPresent."
}

local tbl2 = {
    eventName = "MomentsCreationMusicSearchFilteredCount",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2026, 8, 27 },
    links = "",
    description = "Music-search result count AFTER the creation-flow ISRC/RecordingCode filter (tracks shown to the user). Aggregated to p50/p95/p99; compare against MomentsCreationMusicSearchRawCount to see the filter drop. Dimensioned by queryPresent."
}

local function defaultEmit(arg1, num1: number, tbl3)
    LoggingProtocol.default:logRobloxTelemetryStat(arg1, num1, tbl3)
end

local function reportMusicSearchCounts(num1: number, num2: number, tbl3, func1: ((...any) -> (...any))?)
    if not FFlagMomentsCreationMusicSearchCountTelemetry then
        return
    end

    local tbl4 = {
        queryPresent = tostring(tbl3.queryPresent)
    }

    local var1 = func1 or defaultEmit
    pcall(var1, tbl1, num1, tbl4)
    pcall(var1, tbl2, num2, tbl4)
end

return reportMusicSearchCounts

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local EventIngestService = game:GetService("EventIngestService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local EventIngest = require(GenericAbuseReportingParent.Analytics).AnalyticsReporters.EventIngest
local var1 = require(GenericAbuseReportingParent.Analytics).Analytics.new(RbxAnalyticsService)
local Cryo = require(GenericAbuseReportingParent.Cryo)

local _AnalyticsReducer = require(script.Parent.AnalyticsReducer)

local var2 = require(GenericAbuseReporting.Logger):new("AbuseReport Analytics")

local tbl1 = {
    ReportTimeSpent = game:DefineFastString("GenericAbuseReportingTimeSpentStat", "TimeSpent"),
    SubmittedAbuseType = game:DefineFastString("GenericAbuseReportingSubmittedAbuseTypeStat", "SubmittedAbuseType")
}

local tbl2 = { "Unspecified", "Submit", "Abandon" }

local function submitAnalytics(arg1, str1: string)
    local diag = var1.Diag

    diag:reportStats(arg1.context .. "_" .. tbl1.ReportTimeSpent, arg1.accumulated_time_ms)

    local var3 = arg1.context .. "_" .. tbl1.SubmittedAbuseType .. "_" .. arg1.reason_selection
    diag:reportCounter(var3, 1)

    local accumulatedTimeMs = math.floor(workspace:GetServerTimeNow() * 1000 - arg1.accumulated_time_ms)

    local var4 = Cryo.Dictionary.union(
        arg1,
        {
            accumulated_time_ms = accumulatedTimeMs,
            interaction_type = (table.find(tbl2, str1) or 1) - 1
        }
    )
    EventIngest.new(EventIngestService):sendEventDeferred(arg1.context, arg1.event_type, var4)

    var2:info(
        "Submitted. context: {} interaction_type: {} abuseTypeCategory: {} timeSpent (ms): {}",
        arg1.context,
        str1,
        var3,
        accumulatedTimeMs
    )
end

return submitAnalytics

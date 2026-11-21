-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local EventIngestService = game:GetService("EventIngestService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local ChatLineReportingParent = ChatLineReporting.Parent

local EventIngest = require(ChatLineReportingParent.Analytics).AnalyticsReporters.EventIngest
local var1 = require(ChatLineReportingParent.Analytics).Analytics.new(RbxAnalyticsService)
local Cryo = require(ChatLineReportingParent.Cryo)

local _Types = require(ChatLineReporting.Common.Types)

local tbl1 = {
    ReportTimeSpent = game:DefineFastString("ChatLineReportingTimeSpentStat", "TimeSpent"),
    SubmittedAbuseType = game:DefineFastString("ChatLineReportingSubmittedAbuseTypeStat", "SubmittedAbuseType")
}

function submitAnalytics(arg1, interactionType: number, muteButtonClicked: boolean)
    local eventIngest = EventIngest.new(EventIngestService)
    local diag = var1.Diag

    local accumulatedTimeMs = math.floor(workspace:GetServerTimeNow() * 1000 - arg1.accumulated_time_ms)
    local var2 = Cryo.Dictionary.join(
        arg1,
        {
            accumulated_time_ms = accumulatedTimeMs,
            interaction_type = interactionType,
            mute_button_clicked = muteButtonClicked
        }
    )
    local var3 = arg1.context .. "_" .. tbl1.ReportTimeSpent
    local var4 = arg1.context .. "_" .. tbl1.SubmittedAbuseType .. "_" .. arg1.reason_selection

    diag:reportStats(var3, accumulatedTimeMs)
    diag:reportCounter(var4, 1)
    eventIngest:sendEventDeferred(arg1.context, arg1.event_type, var2)
end

return submitAnalytics

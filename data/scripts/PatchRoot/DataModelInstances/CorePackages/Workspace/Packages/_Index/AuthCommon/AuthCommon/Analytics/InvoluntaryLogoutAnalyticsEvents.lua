-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local dependencies = require(AuthCommon.dependencies)
local EventIngestService = game:GetService("EventIngestService")
local eventIngest = dependencies.Analytics.AnalyticsReporters.EventIngest.new(EventIngestService)
local EventStreamConstants = require(AuthCommonParent.AuthAnalytics).EventStreamConstants

return {
    sendImmediatelyPageLoadEvent = function(origin: string, state: string?)
        local tbl1 = {
            origin = origin,
            state = state or ""
        }
        local osClock = EventStreamConstants.EventTimingKeys.OsClock
        tbl1[osClock] = tostring(os.clock())
        local osTime = EventStreamConstants.EventTimingKeys.OsTime
        tbl1[osTime] = tostring(os.time())

        eventIngest:sendEventImmediately(
            EventStreamConstants.Context.InvoluntaryLogout,
            EventStreamConstants.AuthEventName.AuthPageLoad,
            tbl1
        )
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppLaunchTrackerParent = script:FindFirstAncestor("AppLaunchTracker").Parent
local LoggingProtocol = require(AppLaunchTrackerParent.LoggingProtocol)
local _AppLaunchTrackerTypes = require(script.Parent.AppLaunchTrackerTypes)

local throttlingPercentage = game:DefineFastInt("DiscoveryAppLaunchMilestonesHundredthsPercent", 0)
local num1 = game:DefineFastInt("DiscoveryAppLaunchErrorHundredthsPercent", 0)

local tbl1 = {
    eventName = "DiscoveryAppLaunch_Milestones",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 24, 11, 4 },
    description = "App launch rodux actions",
    links = ""
}

local tbl2 = {
    eventName = "DiscoveryAppLaunch_Error",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = num1,
    lastUpdated = { 24, 11, 4 },
    description = "Error related to discovery app launch metric tracking"
}

return {
    reportStatsforMilestone = function(arg1, milestone: string, str1: string, durationMs: number, arg2, numTilesInit: number, numTileRenders: number, numFeedItems: number, numFeedRenders: number, totalSduiDurationMs: number)
        assert(arg1, "LoggingProtocol must exist")

        if not (throttlingPercentage > 0) then
            return
        end

        local tbl3 = ({})
        tbl3.milestone = milestone
        tbl3.milestoneSpan = `{str1}-{milestone}`
        tbl3.durationMs = durationMs
        tbl3.numTilesInit = numTilesInit
        tbl3.numTileRenders = numTileRenders
        tbl3.numFeedItems = numFeedItems
        tbl3.numFeedRenders = numFeedRenders
        tbl3.totalSduiDurationMs = totalSduiDurationMs

        for value, value2 in arg2 do
            tbl3[value] = value2
        end

        arg1:logRobloxTelemetryEvent(tbl1, { arg1.StandardizedFields.addOsInfo }, tbl3)
    end,
    reportError = function(arg1, errorTag: string)
        arg1:logRobloxTelemetryCounter(tbl2, 1, { errorTag = errorTag })
    end
}

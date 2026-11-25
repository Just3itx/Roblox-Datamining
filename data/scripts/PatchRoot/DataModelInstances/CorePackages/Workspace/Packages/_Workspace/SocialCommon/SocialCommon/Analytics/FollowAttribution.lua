-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createFollowAttributionReporter = require(script.Parent.createFollowAttributionReporter)

local TelemetryService = game:GetService("TelemetryService")
return {
    Surface = { Profile = "Profile", Moments = "Moments" },
    Source = { MomentsFeed = "MomentsFeed" },
    reportFollowSuccess = createFollowAttributionReporter(function(config, arg1) -- name: logEvent
        TelemetryService:LogEvent(config, arg1)
    end)
}

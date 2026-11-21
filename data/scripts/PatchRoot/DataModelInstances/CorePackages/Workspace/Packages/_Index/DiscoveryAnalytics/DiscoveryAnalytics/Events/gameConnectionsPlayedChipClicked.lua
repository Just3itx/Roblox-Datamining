-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("GameConnectionsPlayedChipClickedThrottleHundredthsPercent", 10000)

local var1 = t.strictInterface({ universeId = t.string, placeId = t.string, uid = t.string, totalConnections = t.number })

return function(customFields, eventContext: string)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameConnectionsPlayedChipClickedInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        {
            eventName = "gameConnectionsPlayedChipClicked",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 26, 2, 10 },
            description = "User has clicked the connections played chip to open the user list"
        },
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end

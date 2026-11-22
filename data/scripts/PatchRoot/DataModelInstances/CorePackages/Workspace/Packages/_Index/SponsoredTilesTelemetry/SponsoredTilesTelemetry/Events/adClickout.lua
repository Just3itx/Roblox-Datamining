-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local SponsoredTilesTelemetryParent = script:FindFirstAncestor("SponsoredTilesTelemetry").Parent

local getPlatformTarget = require(SponsoredTilesTelemetryParent.Analytics).getPlatformTarget
local t = require(SponsoredTilesTelemetryParent.t)
local DiscoveryEventErrorLogger = require(SponsoredTilesTelemetryParent.DiscoveryUtils).DiscoveryEventErrorLogger

local config = {
    eventName = "adClickout",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("LuaAppAdClickoutEventThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 10, 19 },
    description = "Fires when the user activates a sponsored ad clickout CTA",
    links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/ads/ads_clickout_event.proto"
}

local var1 = t.strictInterface({ encryptedTrackingData = t.string, tileType = t.string, clickoutUrl = t.string })

return function(encryptedTrackingData: string, tileType: string, clickoutUrl: string)
    local customFields = {
        encryptedTrackingData = encryptedTrackingData,
        tileType = tileType,
        clickoutUrl = clickoutUrl
    }

    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("AdClickoutInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields,
        legacyOverrideTargetForEventIngest = getPlatformTarget()
    })
end

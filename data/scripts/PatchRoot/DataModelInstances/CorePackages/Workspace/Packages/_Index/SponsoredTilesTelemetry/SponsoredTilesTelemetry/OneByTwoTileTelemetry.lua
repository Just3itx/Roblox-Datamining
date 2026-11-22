-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local SponsoredTilesTelemetryParent = script:FindFirstAncestor("SponsoredTilesTelemetry").Parent

local FFlagLuaAppEnableOneByTwoTileFunnelTelemetry = require(SponsoredTilesTelemetryParent.SharedFlags).FFlagLuaAppEnableOneByTwoTileFunnelTelemetry

local CtaType = { GameJoin = "GameJoin", Clickout = "Clickout" }

local standardizedFields = FFlagLuaAppEnableOneByTwoTileFunnelTelemetry and { "addOSInfo", "addSessionInfo", "addSessionId" } or nil

local var2 = FFlagLuaAppEnableOneByTwoTileFunnelTelemetry and {} or nil

local config = {
    eventName = "OneByTwoTileActivated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 8, 5 },
    description = "Counter for OneByTwoTileActivated events."
}

local config2 = {
    eventName = "OneByTwoTileCtaActivated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 8, 5 },
    description = "Counter for OneByTwoTileCtaActivated events."
}

local config3 = {
    eventName = "OneByTwoTileGameJoinInitiated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 8, 5 },
    description = "Counter for OneByTwoTileGameJoinInitiated events."
}

local config4 = {
    eventName = "OneByTwoTileVideoLoaded",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppOneByTwoTileVideoLoadedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 8, 26 },
    description = "Fired when OneByTwoTile VideoDisplay LoadAsync succeeds."
}

local function makeFunnelConfig(eventName: string, description: string)
    return {
        eventName = eventName,
        backends = { "EventIngest", "Points" },
        throttlingPercentage = 10000,
        lastUpdated = { 26, 9, 21 },
        description = description,
        links = "https://roblox.atlassian.net/browse/ADS-11511"
    }
end

local funnelConfig = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then makeFunnelConfig("OneByTwoTileResponseReceived", "Fired when an omni-recommendations response contains a OneByTwoTile.") else nil
local funnelConfig2 = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then makeFunnelConfig("OneByTwoTilePlaced", "Fired when a OneByTwoTile is placed into a grid.") else nil
local funnelConfig3 = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then makeFunnelConfig("OneByTwoTileSkipped", "Fired when a OneByTwoTile cannot be placed into any grid.") else nil
local funnelConfig4 = if FFlagLuaAppEnableOneByTwoTileFunnelTelemetry then makeFunnelConfig("OneByTwoTileRendered", "Fired when a OneByTwoTile component mounts.") else nil

local function logFunnelEvent(config5: {backends: {string}, description: string, eventName: string, lastUpdated: {number}, links: string, throttlingPercentage: number}?, customFields) -- Luacid: Inlined by compiler; 4 call sites recovered
    local str1 = `{config5.eventName}:{customFields.oneByTwoTileFlowId}`
    if var2[str1] then
        return
    end
    var2[str1] = true
    TelemetryService:LogEvent(config5, { standardizedFields = standardizedFields, customFields = customFields })
end

local module = { CtaType = CtaType }

function module.logOneByTwoTileActivated()
    TelemetryService:LogCounter(config, {}, 1)
end

function module.logOneByTwoTileCtaActivated(ctaType: string)
    TelemetryService:LogCounter(config2, { customFields = { CtaType = ctaType } }, 1)
end

function module.logOneByTwoTileGameJoinInitiated()
    TelemetryService:LogCounter(config3, {}, 1)
end

function module.logOneByTwoTileVideoLoaded(videoLengthSec: number, loadDurationSec: number, nativeAdData: string?)
    TelemetryService:LogEvent(config4, {
        standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" },
        customFields = {
            videoLengthSec = videoLengthSec,
            loadDurationSec = loadDurationSec,
            nativeAdData = nativeAdData
        }
    })
end

function module.logOneByTwoTileResponseReceived(customFields)
    logFunnelEvent(funnelConfig, customFields)
end

function module.logOneByTwoTilePlaced(customFields)
    logFunnelEvent(funnelConfig2, customFields)
end

function module.logOneByTwoTileSkipped(customFields)
    logFunnelEvent(funnelConfig3, customFields)
end

function module.logOneByTwoTileRendered(customFields)
    logFunnelEvent(funnelConfig4, customFields)
end

return module

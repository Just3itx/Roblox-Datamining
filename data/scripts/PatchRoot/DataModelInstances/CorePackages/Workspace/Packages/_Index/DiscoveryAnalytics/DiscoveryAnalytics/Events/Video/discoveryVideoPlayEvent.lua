-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local LoggingProtocol = require(DiscoveryAnalyticsParent.LoggingProtocol)

local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger
local t = require(DiscoveryAnalyticsParent.t)
local getVideoEventParamsValidator = require(script.Parent.getVideoEventParamsValidator)
local VideoEventInterfaceKey = require(script.Parent.VideoEventInterfaceKey)

local throttlingPercentage = game:DefineFastInt("DiscoveryVideoPlayEventHundredthsPercent", 0)
local FFlagLuaAppEnableNxMRoduxApportioning = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local var1 = t.strictInterface({
    videoAssetId = t.string,
    videoPlaybackSessionId = t.string,
    universeId = t.string,
    rootPlaceId = t.string,
    gameSetTypeId = t.optional(t.string),
    sortPos = t.optional(t.number),
    nativeAdData = t.optional(t.string),
    tileType = t.optional(t.string),
    contentType = t.optional(t.string),
    isMoment = if FFlagLuaAppDiscoveryMomentVideoTelemetry then t.optional(t.boolean) else nil
})
local var2

if FFlagLuaAppEnableNxMRoduxApportioning then
    var2 = t.strictInterface({
        videoAssetId = t.string,
        videoPlaybackSessionId = t.string,
        gameSetTypeId = t.optional(t.string),
        sortPos = t.optional(t.number),
        nativeAdData = t.string,
        tileType = t.string,
        contentType = t.optional(t.string)
    })
else
    var2 = nil
end

local var3

if FFlagLuaAppEnableNxMRoduxApportioning then
    var3 = t.strictInterface({
        videoAssetId = t.string,
        videoPlaybackSessionId = t.string,
        universeId = t.string,
        rootPlaceId = t.string,
        gameSetTypeId = t.optional(t.string),
        sortPos = t.optional(t.number),
        nativeAdData = t.string,
        tileType = t.string,
        contentType = t.optional(t.string)
    })
else
    var3 = nil
end

local tbl1 = {
    [VideoEventInterfaceKey.DefaultGameTile] = var1
}
local OneByTwoTileAdLink = VideoEventInterfaceKey.OneByTwoTileAdLink

if not FFlagLuaAppEnableNxMRoduxApportioning then
    var2 = nil
end

tbl1[OneByTwoTileAdLink] = var2

local OneByTwoTileGame = VideoEventInterfaceKey.OneByTwoTileGame

if not FFlagLuaAppEnableNxMRoduxApportioning then
    var3 = nil
end

tbl1[OneByTwoTileGame] = var3

local tbl2 = {
    eventName = "discoveryVideoPlay",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 4, 23 },
    description = "Fire when discovery video playback session starts",
    links = ""
}

local function discoveryVideoPlayEvent(arg1, tbl3)
    local interfaceKey = getVideoEventParamsValidator(tbl3)
    local var4 = tbl1[interfaceKey]
    if var4 == nil then
        DiscoveryEventErrorLogger.reportError(
            "DiscoveryVideoPlayEventMissingInterface",
            "No validator registered for video event interface key",
            { interfaceKey = interfaceKey }
        )
    else
        local var5, var6 = var4(tbl3)
        if not var5 then
            DiscoveryEventErrorLogger.reportError("DiscoveryVideoPlayEventInvalidInterface", var6)
        end
    end

    LoggingProtocol.default:logRobloxTelemetryEvent(
        tbl2,
        { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo },
        tbl3,
        arg1
    )
end

return discoveryVideoPlayEvent

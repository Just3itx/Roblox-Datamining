-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("GameTileOverflowMenuActionThrottleHundrethsPercent", 0)

local SharedFlags = require(DiscoveryAnalyticsParent.SharedFlags)
local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppGameTileDirectActionTelemetry = SharedFlags.FFlagLuaAppGameTileDirectActionTelemetry
local FFlagSduiGameTileDirectAction = SharedFlags.FFlagSduiGameTileDirectAction

local var1 = t.strictInterface({
    universeId = t.string,
    sortId = t.optional(t.string),
    actionType = t.string,
    menuItem = t.optional(t.string),
    availableMenuItems = t.optional(t.string),
    contentType = if FFlagLuaAppEnableNxMRoduxApportioning then t.optional(t.string) else nil,
    isDirectAction = if FFlagLuaAppGameTileDirectActionTelemetry or FFlagSduiGameTileDirectAction then t.optional(t.boolean) else nil
})

return function(customFields, eventContext: string)
    if not eventContext then
        DiscoveryEventErrorLogger.reportError("GameTileOverflowMenuActionInvalidInterface", "event is missing context")
    end

    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameTileOverflowMenuActionInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        {
            eventName = "gameTileOverflowMenuAction",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 26, 9, 23 },
            description = "User has taken an action with the Game Tile Overflow Menu"
        },
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end

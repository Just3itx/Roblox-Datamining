-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue
local gameDetailsSubpage = DiscoveryAnalytics.Events.gameDetailsSubpage

local FFlagLuaAppAddUniverseIdToGameDetailsEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddUniverseIdToGameDetailsEvents

return function(arg1, arg2, arg3)
    local subpage = getActionTelemetryFieldValue(arg1, arg2, "subpage")
    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "universeId")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "placeId")
    local actionTelemetryFieldValue4 = getActionTelemetryFieldValue(arg1, arg2, "eventContext") or "GameInfoRow"

    local ctx = getActionTelemetryFieldValue(arg1, arg2, "ctx") or actionTelemetryFieldValue4
    local action = getActionTelemetryFieldValue(arg1, arg2, "action")

    if typeof(subpage) ~= "string" or subpage == "" then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SduiGameDetailsSubpageTelemetryHandler",
            message = "Missing or non-string `subpage` (server must set this on analyticsData or actionParams)",
            propName = "subpage"
        }, arg3.appPage)
        return
    end

    local str1 = typeof(actionTelemetryFieldValue3)
    if str1 ~= "string" and str1 ~= "number" or actionTelemetryFieldValue3 == "" then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SduiGameDetailsSubpageTelemetryHandler",
            message = `Invalid placeId (expected string or number, got {str1})`,
            propName = "placeId"
        }, arg3.appPage)
        return
    end

    if FFlagLuaAppAddUniverseIdToGameDetailsEvents then
        local str2 = typeof(actionTelemetryFieldValue2)
        if str2 ~= "string" and str2 ~= "number" or actionTelemetryFieldValue2 == "" then
            arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
                name = "SduiGameDetailsSubpageTelemetryHandler",
                message = `Invalid universeId (expected string or number, got {str2})`,
                propName = "universeId"
            }, arg3.appPage)
            return
        end
    end

    gameDetailsSubpage({
        uid = tostring(if Players.LocalPlayer then Players.LocalPlayer.UserId else ""),
        placeId = tostring(actionTelemetryFieldValue3),
        subpage = subpage,
        universeId = if FFlagLuaAppAddUniverseIdToGameDetailsEvents then tostring(actionTelemetryFieldValue2) else "",
        action = action,
        ctx = ctx
    }, actionTelemetryFieldValue4)
end

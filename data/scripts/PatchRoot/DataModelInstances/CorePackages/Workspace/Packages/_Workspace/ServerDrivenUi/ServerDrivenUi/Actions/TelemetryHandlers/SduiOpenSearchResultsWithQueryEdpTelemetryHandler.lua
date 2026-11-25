-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local gameDetailsSubpage = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.gameDetailsSubpage

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local FFlagLuaAppAddUniverseIdToGameDetailsEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddUniverseIdToGameDetailsEvents

local openSearchResultsWithQueryParams = require(ServerDrivenUi.Actions.openSearchResultsWithQueryParams)

local SduiOpenSearchResultsWithQueryTelemetryHandler = require(ServerDrivenUi.Actions.TelemetryHandlers.SduiOpenSearchResultsWithQueryTelemetryHandler)

return function(arg1, arg2, arg3)
    local action = openSearchResultsWithQueryParams.resolveSearchQuery(arg1)
    local var2 = openSearchResultsWithQueryParams.resolveSearchType(arg1)
    if action == nil or var2 == nil then
        return
    end

    local subpage = getActionTelemetryFieldValue(arg1, arg2, "subpage")
    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "universeId")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "placeId")
    local actionTelemetryFieldValue4 = getActionTelemetryFieldValue(arg1, arg2, "eventContext")

    if typeof(actionTelemetryFieldValue4) ~= "string" or actionTelemetryFieldValue4 == "" then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SduiOpenSearchResultsWithQueryEdpTelemetryHandler",
            message = "Missing or non-string `eventContext` (set on analyticsData for EDP subpage taps)",
            propName = "eventContext"
        }, arg3.appPage)
        actionTelemetryFieldValue4 = ""
    end

    if typeof(subpage) ~= "string" or subpage == "" then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SduiOpenSearchResultsWithQueryEdpTelemetryHandler",
            message = "Missing or non-string `subpage` (set on analyticsData for EDP subpage taps)",
            propName = "subpage"
        }, arg3.appPage)
        return
    end

    if typeof(actionTelemetryFieldValue3) ~= "string" and typeof(actionTelemetryFieldValue3) ~= "number"
        or actionTelemetryFieldValue3 == ""
    then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SduiOpenSearchResultsWithQueryEdpTelemetryHandler",
            message = `Invalid placeId (expected string or number, got {typeof(actionTelemetryFieldValue3)})`,
            propName = "placeId"
        }, arg3.appPage)
        actionTelemetryFieldValue3 = ""
    end

    if FFlagLuaAppAddUniverseIdToGameDetailsEvents
        and (typeof(actionTelemetryFieldValue2) ~= "string" and typeof(actionTelemetryFieldValue2) ~= "number"
            or actionTelemetryFieldValue2 == "")
    then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SduiOpenSearchResultsWithQueryEdpTelemetryHandler",
            message = `Invalid universeId (expected string or number, got {typeof(actionTelemetryFieldValue2)})`,
            propName = "universeId"
        }, arg3.appPage)
        actionTelemetryFieldValue2 = ""
    end

    SduiOpenSearchResultsWithQueryTelemetryHandler(arg1, arg2, arg3)

    gameDetailsSubpage({
        uid = tostring(if Players.LocalPlayer then Players.LocalPlayer.UserId else ""),
        placeId = tostring(actionTelemetryFieldValue3),
        subpage = subpage,
        universeId = if FFlagLuaAppAddUniverseIdToGameDetailsEvents then tostring(actionTelemetryFieldValue2) else "",
        action = action,
        ctx = "OpenSearchResultsWithQuery"
    }, actionTelemetryFieldValue4)
end

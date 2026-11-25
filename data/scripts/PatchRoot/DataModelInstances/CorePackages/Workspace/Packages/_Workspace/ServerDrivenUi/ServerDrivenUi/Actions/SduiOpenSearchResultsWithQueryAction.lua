-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local OpenSearchResultsWithQueryBridge = require(ServerDrivenUiParent.ServerDrivenUi).OpenSearchResultsWithQueryBridge
local openSearchResultsWithQueryParams = require(ServerDrivenUi.Actions.openSearchResultsWithQueryParams)
local FFlagLuaAppSduiSearchAutocomplete = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiSearchAutocomplete
local isAutocompleteSelectionFresh = require(ServerDrivenUi.Actions.isAutocompleteSelectionFresh)
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local function reportInvalidParam(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.OpenSearchResultsWithQuery,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

local function SduiOpenSearchResultsWithQueryAction(arg1, arg2, arg3, _)
    local var1 = openSearchResultsWithQueryParams.resolveSearchQuery(arg1)
    if var1 == nil then
        reportInvalidParam(arg3, "Invalid or missing searchQuery", "searchQuery")
        return
    end

    local var2 = openSearchResultsWithQueryParams.resolveSearchType(arg1)
    if var2 == nil then
        reportInvalidParam(arg3, "Invalid, unknown, or unsupported searchType", "searchType")
        return
    end

    if not FFlagLuaAppSduiSearchAutocomplete or not openSearchResultsWithQueryParams.resolveIsAutocompleteSuggestion(arg1) then
        OpenSearchResultsWithQueryBridge.run(var1, var2)
        return
    end

    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "prefix")
    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "position")

    if typeof(actionTelemetryFieldValue) ~= "string"
        or typeof(actionTelemetryFieldValue2) ~= "number"
        or not isAutocompleteSelectionFresh(arg3.configKey, actionTelemetryFieldValue, actionTelemetryFieldValue2, var1)
    then
        return
    end
    OpenSearchResultsWithQueryBridge.run(var1, var2, true, arg3.configKey)
end

return SduiOpenSearchResultsWithQueryAction

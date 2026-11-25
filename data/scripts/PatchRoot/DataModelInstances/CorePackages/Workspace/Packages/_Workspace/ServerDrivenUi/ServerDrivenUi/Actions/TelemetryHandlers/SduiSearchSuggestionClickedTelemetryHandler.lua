-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue
local isAutocompleteSelectionFresh = require(ServerDrivenUi.Actions.isAutocompleteSelectionFresh)
local OpenSearchResultsWithQueryBridge = require(ServerDrivenUi.System.OpenSearchResultsWithQueryBridge)

local function SduiSearchSuggestionClickedTelemetryHandler(arg1, arg2, arg3)
    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "prefix")
    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "searchQuery")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "position")

    if typeof(arg3.configKey) ~= "string"
        or typeof(actionTelemetryFieldValue) ~= "string"
        or typeof(actionTelemetryFieldValue2) ~= "string"
        or typeof(actionTelemetryFieldValue3) ~= "number"
    then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SearchSuggestionClickedTelemetryHandler",
            message = "Expected string configKey, prefix and searchQuery and numeric position"
        }, arg3.appPage)
    elseif isAutocompleteSelectionFresh(
        arg3.configKey,
        actionTelemetryFieldValue,
        actionTelemetryFieldValue3,
        actionTelemetryFieldValue2
    ) then
        OpenSearchResultsWithQueryBridge.runSuggestionClicked(
            arg3.configKey,
            actionTelemetryFieldValue,
            actionTelemetryFieldValue2,
            actionTelemetryFieldValue3
        )
    end
end

return SduiSearchSuggestionClickedTelemetryHandler

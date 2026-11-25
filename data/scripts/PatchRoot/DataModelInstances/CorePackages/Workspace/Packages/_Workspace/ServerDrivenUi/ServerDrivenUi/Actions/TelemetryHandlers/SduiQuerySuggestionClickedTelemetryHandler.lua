-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local querySuggestionClicked = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.querySuggestionClicked

local getActionTelemetryFieldValue = require(ServerDrivenUiParent.SduiCoreSystem).getActionTelemetryFieldValue

local openSearchResultsWithQueryParams = require(ServerDrivenUi.Actions.openSearchResultsWithQueryParams)

return function(arg1, arg2, arg3)
    local queryText = getActionTelemetryFieldValue(arg1, arg2, "queryText") or openSearchResultsWithQueryParams.resolveSearchQuery(arg1)
    if typeof(queryText) ~= "string" or queryText == "" then
        return
    end

    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "itemPosition")
    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "collectionPosition")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "collectionId")

    local var2 = querySuggestionClicked
    local appPage = arg3.appPage
    local tbl1 = { pos = 0, sortPos = 0, sortId = 0, queryText = 0, componentType = "Pill" }
    if typeof(actionTelemetryFieldValue) ~= "number" then
        actionTelemetryFieldValue = nil
    end

    tbl1.pos = actionTelemetryFieldValue
    tbl1.sortPos = tonumber(actionTelemetryFieldValue2)
    tbl1.sortId = if actionTelemetryFieldValue3 == nil then nil else tostring(actionTelemetryFieldValue3)
    tbl1.queryText = queryText
    var2(appPage, tbl1)
end

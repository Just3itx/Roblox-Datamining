-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local SearchTypes = require(ServerDrivenUiParent.RobloxAppEnums).SearchTypes

local SearchSourceEvent = require(ServerDrivenUiParent.DiscoveryTypes).SearchSourceEvent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local SearchPageTabSwitchBridge = require(ServerDrivenUi.System.SearchPageTabSwitchBridge)

local function reportInvalidParam(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.OpenSearchResultsTab,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

local function SduiOpenSearchResultsTabAction(arg1, _, arg2, _)
    local actionParams = if arg1 then arg1.actionParams else nil

    if actionParams == nil then
        reportInvalidParam(arg2, "Missing actionParams", nil)
        return
    end

    local searchType = actionParams.searchType
    if typeof(searchType) ~= "string" or searchType == "" then
        reportInvalidParam(arg2, `Invalid or missing searchType: {tostring(searchType)}`, "searchType")
        return
    end

    if SearchTypes[searchType] == nil then
        reportInvalidParam(arg2, `Unknown searchType: {searchType}`, "searchType")
        return
    end

    local sourceEvent = actionParams.sourceEvent
    local seeAll

    if sourceEvent == nil then
        seeAll = SearchSourceEvent.SeeAll
    else
        if typeof(sourceEvent) ~= "string" or SearchSourceEvent[sourceEvent] == nil then
            reportInvalidParam(arg2, `Unknown sourceEvent: {tostring(sourceEvent)}`, "sourceEvent")
            return
        end

        seeAll = SearchSourceEvent[sourceEvent]
    end

    SearchPageTabSwitchBridge.switchTab(searchType, seeAll)
end

return SduiOpenSearchResultsTabAction

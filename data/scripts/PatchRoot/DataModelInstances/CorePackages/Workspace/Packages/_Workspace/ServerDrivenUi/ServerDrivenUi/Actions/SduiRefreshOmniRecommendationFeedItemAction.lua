-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local refreshOmniRecommendationFeedItem = require(ServerDrivenUi.Actions.refreshOmniRecommendationFeedItem)
local refreshHomePageFeedItem = require(ServerDrivenUiParent.Home.refreshHomePageFeedItem)

local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local FFlagSduiRefreshFeedItemIsOmissionExpected = SharedFlags.FFlagSduiRefreshFeedItemIsOmissionExpected

local function reportInvalidActionParams(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 6 call sites recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.RefreshOmniRecommendationFeedItem,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

return function(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        reportInvalidActionParams(arg2, "Missing actionParams", nil)
        return
    end
    assert(actionParams, "actionParams must exist")

    local topicId = actionParams.topicId
    if typeof(topicId) ~= "string" or topicId == "" then
        reportInvalidActionParams(arg2, `Invalid or missing topicId: {topicId}`, "topicId")
        return
    end

    local feedItemKey = actionParams.feedItemKey
    if typeof(feedItemKey) ~= "string" or feedItemKey == "" then
        reportInvalidActionParams(arg2, `Invalid or missing feedItemKey: {feedItemKey}`, "feedItemKey")
        return
    end

    local requestIntent = actionParams.requestIntent
    if typeof(requestIntent) ~= "string" or requestIntent == "" then
        reportInvalidActionParams(arg2, `Invalid requestIntent: {requestIntent}`, "requestIntent")
    end

    local var1 = nil

    local selectedOption = actionParams.selectedOption
    if selectedOption ~= nil then
        if typeof(selectedOption) == "string" and selectedOption ~= "" then
            var1 = { selected_option = selectedOption }
        else
            reportInvalidActionParams(arg2, `Invalid selectedOption: {selectedOption}`, "selectedOption")
        end
    end

    local var2 = nil
    if FFlagSduiRefreshFeedItemIsOmissionExpected then
        local isOmissionExpected = actionParams.isOmissionExpected
        if isOmissionExpected == nil or typeof(isOmissionExpected) == "boolean" then
            var2 = isOmissionExpected
        else
            reportInvalidActionParams(arg2, `Invalid isOmissionExpected: {isOmissionExpected}`, "isOmissionExpected")
        end
    end

    if not FFlagLuaAppEnableSduiHomePage then
        return refreshOmniRecommendationFeedItem(
            arg2.dependencies.networking,
            arg2.appPage,
            topicId,
            feedItemKey,
            requestIntent,
            function(arg3, arg4)
                arg2.dependencies.logger.reportError(arg3, arg4, arg2.appPage)
            end,
            { contextFeatures = var1 }
        )
    end

    local var3 = refreshHomePageFeedItem

    local function func1(arg3, arg4)
        arg2.dependencies.logger.reportError(arg3, arg4, arg2.appPage)
    end

    local tbl1 = { contextFeatures = var1, isOmissionExpected = 0 }
    if not FFlagSduiRefreshFeedItemIsOmissionExpected then
        var2 = nil
    end

    tbl1.isOmissionExpected = var2
    return var3(topicId, feedItemKey, requestIntent, func1, tbl1)
end

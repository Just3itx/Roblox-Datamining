-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local CentralOverlay = require(ServerDrivenUiParent.CentralOverlay)
local DiscoveryAnalytics = require(ServerDrivenUiParent.DiscoveryAnalytics)
local Foundation = require(ServerDrivenUiParent.Foundation)
local RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local UserSignals = require(ServerDrivenUiParent.UserSignals)

local ButtonVariant = Foundation.Enums.ButtonVariant
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors

local PostSendUserSignal = UserSignals.PostSendUserSignal
local UserSignalTypes = UserSignals.UserSignalTypes

local aiOverviewSentiment = DiscoveryAnalytics.Events.aiOverviewSentiment
local aiOverviewExplicitFeedback = DiscoveryAnalytics.Events.aiOverviewExplicitFeedback

local AiOverviewSentiment = DiscoveryAnalytics.Constants.AiOverviewSentiment

local tbl1 = {
    [AiOverviewSentiment.ThumbsUp] = true,
    [AiOverviewSentiment.ThumbsDown] = true
}

local function reportInvalidParam(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.AiOverviewFeedback,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

local function sendUserSignal(arg1, networking, id: string, productSurface: string, arg2, input)
    local success, result = pcall(function()
        PostSendUserSignal(
            networking,
            {
                stringValue = HttpService:JSONEncode(input)
            },
            {
                id = id,
                assetType = UserSignalTypes.AssetType.PowerSearch,
                signalOrigin = {
                    productSurface = productSurface,
                    topicId = "PowerSearch",
                    subIds = { "PowerSearch" }
                }
            },
            UserSignalTypes.SignalValueType.String,
            arg2
        ):catch(
            function(arg3)
                arg1.dependencies.logger.reportError(
                    SduiErrorType.ActionNetworkRequestFailed,
                    {
                        name = SduiActionType.AiOverviewFeedback,
                        message = tostring(arg3)
                    },
                    arg1.appPage
                )
            end
        )
    end)

    if not success then
        arg1.dependencies.logger.reportError(
            SduiErrorType.ActionNetworkRequestFailed,
            {
                name = SduiActionType.AiOverviewFeedback,
                message = tostring(result)
            },
            arg1.appPage
        )
    end
end

local function SduiAiOverviewFeedbackAction(arg1, arg2, arg3, _)
    local actionParams = if arg1 then arg1.actionParams else nil

    if actionParams == nil then
        reportInvalidParam(arg3, "Missing actionParams", nil)
        return
    end

    local sentiment = actionParams.sentiment
    if typeof(sentiment) ~= "string" or not tbl1[sentiment] then
        reportInvalidParam(arg3, `Invalid or missing sentiment: {tostring(sentiment)}`, "sentiment")
        return
    end

    local productSurface = actionParams.productSurface
    local productSurface2 = if typeof(productSurface) ~= "string" then "Unknown" elseif productSurface == "" then "Unknown" else productSurface

    local searchSessionId = findAnalyticsFieldInAncestors("searchSessionId", arg2) or ""
    local query = findAnalyticsFieldInAncestors("searchQuery", arg2) or ""
    local analyticsFieldInAncestors3 = findAnalyticsFieldInAncestors("universeIds", arg2)
    local appPage = arg3.appPage
    local networking = arg3.dependencies.networking

    sendUserSignal(
        arg3,
        networking,
        searchSessionId,
        productSurface2,
        UserSignalTypes.SignalType.AiOverviewSentiment,
        { sentiment = sentiment, query = query, universe_ids = analyticsFieldInAncestors3 }
    )

    arg3.dependencies.dispatch(
        SetCentralOverlay(CentralOverlayType.TextFeedbackFormModal, {
            dialogTitle = actionParams.dialogTitle or "",
            dialogText = actionParams.dialogText,
            placeholderText = actionParams.placeholderText,
            buttonVariant = ButtonVariant.Emphasis,
            showTermsOfUseDisclaimer = true,
            onSubmit = function(feedbackText: string)
                sendUserSignal(
                    arg3,
                    networking,
                    searchSessionId,
                    productSurface2,
                    UserSignalTypes.SignalType.AiOverviewExplicitFeedback,
                    { sentiment = sentiment, feedback_text = feedbackText, query = query }
                )

                aiOverviewExplicitFeedback({
                    sentiment = sentiment,
                    searchSessionId = searchSessionId,
                    query = query,
                    didSubmit = true,
                    feedbackText = feedbackText
                }, appPage)
            end,
            onClose = function(bool1: boolean?)
                if bool1 then
                    return
                end

                sendUserSignal(
                    arg3,
                    networking,
                    searchSessionId,
                    productSurface2,
                    UserSignalTypes.SignalType.AiOverviewExplicitFeedback,
                    { sentiment = sentiment, feedback_text = "", query = query }
                )

                aiOverviewExplicitFeedback(
                    {
                        sentiment = sentiment,
                        searchSessionId = searchSessionId,
                        query = query,
                        didSubmit = false
                    },
                    appPage
                )
            end
        })
    )

    aiOverviewSentiment(
        {
            sentiment = sentiment,
            searchSessionId = searchSessionId,
            query = query,
            universeIds = analyticsFieldInAncestors3
        },
        appPage
    )
end

return SduiAiOverviewFeedbackAction

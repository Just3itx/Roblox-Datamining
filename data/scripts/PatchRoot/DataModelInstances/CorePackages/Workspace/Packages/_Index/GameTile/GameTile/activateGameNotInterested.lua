-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local CentralOverlay = require(GameTileParent.CentralOverlay)
local Foundation = require(GameTileParent.Foundation)
local Loggers = require(GameTileParent.Loggers)
local LoggingProtocol = require(GameTileParent.LoggingProtocol)
local RobloxAppEnums = require(GameTileParent.RobloxAppEnums)
local RobloxAppToastsRodux = require(GameTileParent.RobloxAppToastsRodux)
local SharedFlags = require(GameTileParent.SharedFlags)
local UserSignals = require(GameTileParent.UserSignals)

local AbuseVector = require(GameTileParent.GenericAbuseReporting.AbuseVector)
local CircleMinus = Foundation.Enums.IconName.CircleMinus
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local default = LoggingProtocol.default
local OpenDynamicAbuseReport = require(GameTileParent.GenericAbuseReporting.OpenDynamicAbuseReport)
local PostSendUserSignal = UserSignals.PostSendUserSignal
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local SetNetworkingErrorToast = RobloxAppToastsRodux.Thunks.SetNetworkingErrorToast
local UserSignalTypes = UserSignals.UserSignalTypes
local flaggedMutedError = Loggers.flaggedMutedError
local mutedError = Loggers.mutedError

local NotInterestedUserSignalTelemetryEventConfigs = require(GameTile.NotInterestedUserSignalTelemetryEventConfigs)
local sendNotInterestedFeedbackFormAnalytics = require(GameTile.sendNotInterestedFeedbackFormAnalytics)

local FFlagLuaAppMakeDisclaimerOptInForFeedbackForm = SharedFlags.FFlagLuaAppMakeDisclaimerOptInForFeedbackForm
local FFlagLuaAppNotInterestedFeedbackFormTelemetry = SharedFlags.FFlagLuaAppNotInterestedFeedbackFormTelemetry

local function sendFeedbackFormAnalytics(str1: string, universeId: string, sortId: string, actionType: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    if not FFlagLuaAppNotInterestedFeedbackFormTelemetry then
        return
    end
    sendNotInterestedFeedbackFormAnalytics({ universeId = universeId, sortId = sortId, actionType = actionType }, str1)
end

local function onFeedbackFormClosed(bool1: boolean?, appPage: string, universeId: string, collectionId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        return
    end

    sendFeedbackFormAnalytics(appPage, universeId, collectionId, "NotInterestedFeedbackFormClosedWithoutSubmit")
end

local function onFeedbackFormSubmitted(tbl1, textResponse: string, tbl2, productSurface: string, topicId: string, callback: (...any) -> (...any), networking, targetId: string?, isSponsored: boolean?, id: string)
    local assetType = if isSponsored then UserSignalTypes.AssetType.SponsoredGame else UserSignalTypes.AssetType.Game
    local items = {}
    local bool1 = false
    for _, value in tbl2 do
        local selected = tbl1[value.id] or false
        table.insert(items, { id = value.id, selected = selected })

        if value.id == UserSignalTypes.NotInterestedFeedbackItem.InappropriateContent and selected then
            bool1 = true
        end
    end

    if bool1 then
        if targetId == nil or targetId == "" then
            flaggedMutedError("NotInterestedReportPlaceIdMissing", "Place report opened without a place id")
        else
            callback(OpenDynamicAbuseReport({
                abuseVector = AbuseVector.Place,
                targetId = targetId,
                onClose = function()
                    callback(CloseCentralOverlay())
                end
            }))
        end
    end

    local success, result = pcall(function()
        PostSendUserSignal(
            networking,
            {
                stringValue = HttpService:JSONEncode({
                    formId = UserSignalTypes.NotInterestedFeedbackFormId.NotInterestedFeedback1,
                    titleId = UserSignalTypes.NotInterestedFeedbackFormTitleId.WhyHideExperience,
                    textResponse = textResponse,
                    items = items
                })
            },
            {
                id = id,
                assetType = assetType,
                signalOrigin = {
                    productSurface = productSurface,
                    topicId = topicId,
                    subIds = { topicId }
                }
            },
            UserSignalTypes.SignalValueType.String,
            UserSignalTypes.SignalType.NotInterestedFeedback
        ):catch(
            function(arg1)
                callback(SetNetworkingErrorToast(arg1))
                default:logRobloxTelemetryCounter(NotInterestedUserSignalTelemetryEventConfigs.NotInterestedUserSignalFailed, 1)
            end
        )
    end)

    if not success then
        mutedError(result)
    end

    sendFeedbackFormAnalytics(productSurface, id, topicId, "NotInterestedFeedbackFormSubmitted")
end

local function activateGameNotInterested(tbl1): boolean
    local appPage = tbl1.appPage
    if not appPage then
        default:logRobloxTelemetryCounter(NotInterestedUserSignalTelemetryEventConfigs.NotInterestedMissingAppPage, 1)

        tbl1.dispatch(SetNetworkingErrorToast())
        return false
    end

    local collectionId = tbl1.collectionId
    local dispatch = tbl1.dispatch
    local networking = tbl1.networking
    local placeId = tbl1.placeId
    local universeId = tbl1.universeId
    local assetType = if tbl1.isSponsored then UserSignalTypes.AssetType.SponsoredGame else UserSignalTypes.AssetType.Game
    local localizedStrings = tbl1.localizedStrings
    local checkboxItems = {
        {
            id = UserSignalTypes.NotInterestedFeedbackItem.TooRepetitive,
            text = localizedStrings.tooRepetitive
        },
        {
            id = UserSignalTypes.NotInterestedFeedbackItem.DontLikeGame,
            text = localizedStrings.dontLikeGame
        },
        {
            id = UserSignalTypes.NotInterestedFeedbackItem.DontLikeImage,
            text = localizedStrings.dontLikeImage
        },
        {
            id = UserSignalTypes.NotInterestedFeedbackItem.InappropriateContent,
            text = localizedStrings.inappropriateContent
        },
        {
            id = UserSignalTypes.NotInterestedFeedbackItem.SomethingElse,
            text = localizedStrings.somethingElse,
            triggersOtherTextbox = true
        }
    }

    tbl1.setGameHidden(universeId, true)
    local var2 = SetCentralOverlay
    local provideFeedbackToast = CentralOverlayType.ProvideFeedbackToast

    local tbl3 = {
        feedbackFormProps = {
            dialogTitle = localizedStrings.dialogTitle,
            dialogText = localizedStrings.dialogText,
            checkboxListTitle = localizedStrings.checkboxListTitle,
            checkboxItems = checkboxItems,
            onSubmit = function(arg1, textResponse)
                onFeedbackFormSubmitted(
                    arg1,
                    textResponse,
                    checkboxItems,
                    appPage,
                    collectionId,
                    dispatch,
                    networking,
                    placeId,
                    tbl1.isSponsored,
                    universeId
                )
            end,
            onClose = FFlagLuaAppNotInterestedFeedbackFormTelemetry and function(arg1)
                onFeedbackFormClosed(arg1, appPage, universeId, collectionId)
            end or nil,
            showTermsOfUseDisclaimer = not FFlagLuaAppMakeDisclaimerOptInForFeedbackForm and nil
        },
        toastIcon = CircleMinus,
        onToastActivated = FFlagLuaAppNotInterestedFeedbackFormTelemetry and function()
            sendFeedbackFormAnalytics(appPage, universeId, collectionId, "NotInterestedFeedbackFormOpened")
        end or nil
    }

    dispatch(var2(provideFeedbackToast, tbl3))

    local success, result = pcall(function()
        PostSendUserSignal(
            networking,
            { boolValue = true },
            {
                id = universeId,
                assetType = assetType,
                signalOrigin = {
                    productSurface = appPage,
                    topicId = collectionId,
                    subIds = { collectionId }
                }
            },
            UserSignalTypes.SignalValueType.Bool,
            UserSignalTypes.SignalType.NotInterested
        ):catch(
            function(arg1)
                tbl1.setGameHidden(universeId, false)
                dispatch(SetNetworkingErrorToast(arg1))
                default:logRobloxTelemetryCounter(NotInterestedUserSignalTelemetryEventConfigs.NotInterestedUserSignalFailed, 1)
            end
        )
    end)

    if not success then
        tbl1.setGameHidden(universeId, false)
        mutedError(result)
    end

    return true
end

return activateGameNotInterested

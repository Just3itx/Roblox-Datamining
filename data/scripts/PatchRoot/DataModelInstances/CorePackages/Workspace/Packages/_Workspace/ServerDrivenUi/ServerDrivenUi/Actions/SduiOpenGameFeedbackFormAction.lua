-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local CentralOverlay = require(ServerDrivenUiParent.CentralOverlay)
local DataHydration = require(ServerDrivenUiParent.DataHydration)
local PlayerFeedback = require(ServerDrivenUiParent.PlayerFeedback)
local RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)

local Game = DataHydration.Game
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local PlayerFeedbackEvents = PlayerFeedback.Analytics.Events.PlayerFeedbackEvents

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope

local tbl1 = { [true] = "Upvote", [false] = "Downvote" }

local function SduiOpenGameFeedbackFormAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenGameFeedbackForm,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if typeof(universeId) ~= "string" or universeId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenGameFeedbackForm,
            message = `Invalid or missing universeId: {tostring(universeId)}`,
            propName = "universeId"
        }, arg2.appPage)
        return
    end

    local rootPlaceId = actionParams.rootPlaceId
    if typeof(rootPlaceId) ~= "string" or rootPlaceId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenGameFeedbackForm,
            message = `Invalid or missing rootPlaceId: {tostring(rootPlaceId)}`,
            propName = "rootPlaceId"
        }, arg2.appPage)
        return
    end

    local var1 = Game.getUserVoteFeedbackMetadataStore(false).getUserVoteFeedbackMetadata(rootPlaceId).data(false)

    local var2 = Game.getVotesStore(false).getAndFetchUserVote(universeId).data(false)

    if not var1 or not var1.canSubmitReview or not var2 or var2.userVote ~= true and var2.userVote ~= false then
        local reportError = arg2.dependencies.logger.reportError
        local failedToExecuteAction = SduiErrorType.FailedToExecuteAction
        local tbl2 = {
            name = SduiActionType.OpenGameFeedbackForm,
            message = 0
        }
        local str1 = tostring(var1 ~= nil)
        local str2 = tostring(var1 and var1.canSubmitReview)
        local str3 = tostring(var2 ~= nil)
        local userVote = var2 and var2.userVote
        tbl2.message = `Missing or invalid feedback hydration: hasMetadata={str1}, canSubmitReview={str2}, hasUserVoteData={str3}, userVote={tostring(userVote)}`
        reportError(failedToExecuteAction, tbl2, arg2.appPage)
        return
    end

    local categoryType = tbl1[var2.userVote]
    local var4 = nil
    for _, value in var1.categories do
        if value.type == categoryType then
            var4 = value
            break
        end
    end

    if var4 == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.FailedToExecuteAction, {
            name = SduiActionType.OpenGameFeedbackForm,
            message = `No matching vote category found for type: {tostring(categoryType)}`
        }, arg2.appPage)
        return
    end

    PlayerFeedbackEvents.ClickPlayerFeedbackPromptCta(arg2.dependencies.eventIngest, rootPlaceId)

    local playerFeedbackMetadata = {
        rootPlaceId = var1.rootPlaceId,
        canSubmitReview = var1.canSubmitReview,
        canSubmitComment = var1.canSubmitComment,
        categoryType = categoryType,
        category = var4,
        comment = var1.comment,
        metadata = var1.metadata
    }

    local configKey = arg2.configKey
    arg2.dependencies.dispatch(
        SetCentralOverlay(CentralOverlayType.GamePlayerFeedbackForm, {
            universeId = universeId,
            playerFeedbackMetadata = playerFeedbackMetadata,
            onSubmitted = function()
                Game.getUserVoteFeedbackMetadataStore(false).clearItem(rootPlaceId)
                if configKey then
                    getSduiClientPageScope(configKey).set("showPlayerFeedback", false)
                end
            end
        })
    )
end
return SduiOpenGameFeedbackFormAction

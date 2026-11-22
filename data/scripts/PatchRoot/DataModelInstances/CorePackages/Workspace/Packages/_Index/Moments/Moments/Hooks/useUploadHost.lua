-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)

local useLocalization = Localization.Hooks.useLocalization

local MomentsCreation = require(MomentsParent.MomentsCreation)
local SharedFlags = require(MomentsParent.SharedFlags)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)
local publishMomentWithUpload = MomentsCreation.publishMomentWithUpload
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration
local GetFFlagMomentsUseUploadPostAsync = MomentsCommon.Flags.GetFFlagMomentsUseUploadPostAsync
local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = MomentsCommon.Analytics.fireAnalyticsEvent
local logMomentsLayerExposure = MomentsCommon.Utils.logMomentsLayerExposure
local generateMomentText = require(Moments.generateMomentText)
local momentGeneratedTextFeedback = require(Moments.Feedback.momentGeneratedTextFeedback)
local refreshOwnMomentsAfterPublish = require(Moments.Upload.refreshOwnMomentsAfterPublish)
local setPublishedMomentOnUploadStore = require(Moments.Upload.setPublishedMomentOnUploadStore)
local postLifecycleSubscription = require(Moments.Upload.postLifecycleSubscription)
local createPublishedPostResolver = require(Moments.Upload.createPublishedPostResolver)
local FFlagMomentsHydratePublishedFeedItem = require(Moments.Flags.FFlagMomentsHydratePublishedFeedItem)
local FFlagMomentsPostFeedbackIxpEnabled = require(Moments.Flags.FFlagMomentsPostFeedbackIxpEnabled)
local FStringMomentsPostFeedbackIxpLayer = require(Moments.Flags.FStringMomentsPostFeedbackIxpLayer)
local makePostFeedbackEventFields = require(Moments.Analytics.makePostFeedbackEventFields)
local FFlagMomentsPostFeedback = SharedFlags.FFlagMomentsPostFeedback

local FFlagMomentsRefreshOwnMomentsAfterPublish = SharedFlags.FFlagMomentsRefreshOwnMomentsAfterPublish
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsRefreshProfileOnPostStatus = SharedFlags.FFlagMomentsRefreshProfileOnPostStatus
local FFlagMomentsResolvePublishedPostFeedItem = SharedFlags.FFlagMomentsResolvePublishedPostFeedItem
local FFlagMomentsHidePostStatusToast = SharedFlags.FFlagMomentsHidePostStatusToast

game:DefineFastInt("MomentsPendingMomentTtlSeconds", 300)

local GetUploadStore = require(Moments.Stores.GetUploadStore)
local GetPostStatusCardStore = require(Moments.Stores.GetPostStatusCardStore)
local _createPostStatusCardStore = require(Moments.Stores.GetPostStatusCardStore.createPostStatusCardStore)
local GetToastStore = require(Moments.Stores.GetToastStore)
local _createToastStore = require(Moments.Stores.GetToastStore.createToastStore)

local isStudio = require(MomentsParent.MomentsCommon.isStudio)
local getLocalUserId = require(Moments.Utils.getLocalUserId)
local usePostFeedbackStrings = require(Moments.Components.PostFeedback.usePostFeedbackStrings)

local var1 = require(MomentsParent.Loggers).Logger:new("Moments.Upload")

local tbl1 = {
    publishingTitle = "Feature.Moments.Label.RodeoPublishingTitle",
    publishingBody = "Feature.Moments.Label.PublishingRodeoBody",
    publishedTitle = "Feature.Moments.Label.MomentPublishedTitle",
    publishedBody = "Feature.Moments.Label.MomentPublishedBody",
    failedTitle = "Feature.Moments.Label.MomentFailedToPostTitle",
    failedBody = "Feature.Moments.Label.MomentFailedToPostBody",
    removedTitle = "Feature.Moments.Title.MomentRemoved",
    removedBody = "Feature.Moments.Label.PostRemovedBody",
    uploadQuotaReachedBody = "Feature.Moments.Description.TooManyUploads",
    generateInProgressTitle = "Feature.Moments.Label.TextGenerateInProgressTitle",
    generateInProgressBody = "Feature.Moments.Label.TextGenerateInProgressBody",
    generatedTitle = "Feature.Moments.Label.TextGeneratedTitle",
    generatedBody = "Feature.Moments.Label.TextGeneratedBody",
    generateFailedTitle = "Feature.Moments.Label.TextGenerationFailedTitle",
    generateFailedBody = "Feature.Moments.Label.TextGenerationFailedBody",
    generateFilteredTitle = "Feature.Moments.Label.TextGenerationFilteredTitle",
    generateFilteredBody = "Feature.Moments.Label.TextGenerationFilteredBody",
    generateOverrideTitle = "Feature.Moments.Label.TextGenerateOverrideTitle",
    generateOverrideBody = "Feature.Moments.Label.TextGenerateOverrideBody"
}

local var2 = isStudio()
local MomentStatus = MomentsTypes.Enums.MomentStatus

local function makeUploadedMomentItem(assetId: number, arg1, edits, description: string, num1: number?)
    local momentId = tostring(assetId)
    local localPlayer = Players.LocalPlayer
    local tbl2 = {
        assetId = assetId,
        creatorId = if localPlayer == nil then 0 else localPlayer.UserId,
        metadata = 0,
        momentId = 0,
        recommendationMetadata = 0,
        status = 0
    }
    local metadata = {
        assetTotalDuration = 0,
        captureType = 0,
        description = 0,
        edits = 0,
        placeId = 0,
        universeId = 0
    }

    if arg1.CaptureType == Enum.CaptureType.Screenshot then
        num1 = MomentsCreation.Constants.ScreenshotMusicDuration
    elseif num1 == nil or not (num1 > 0) then
        num1 = arg1.TimeLength
    end

    metadata.assetTotalDuration = num1

    metadata.captureType = arg1.CaptureType
    metadata.description = description
    metadata.edits = edits
    metadata.placeId = arg1.SourcePlaceId
    metadata.universeId = arg1.SourceUniverseId
    tbl2.metadata = metadata

    tbl2.momentId = momentId

    tbl2.recommendationMetadata = {}
    tbl2.status = MomentStatus.Public
    return tbl2
end

local function makePendingMomentItem(arg1, edits, description: string, resolvedTimeLength: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    local uploadedMomentItem = makeUploadedMomentItem(0, arg1, edits, description, resolvedTimeLength)
    uploadedMomentItem.momentId = HttpService:GenerateGUID(false)
    uploadedMomentItem.status = MomentStatus.Pending

    local success, result = pcall(Content.fromObject, arg1)
    if success then
        uploadedMomentItem.localContent = result
    end
    return uploadedMomentItem
end

local function isPendingMomentModerated(num1: number, momentId: string)
    local var3 = MomentsGetMomentsUserStore(false).getPendingUserMoments(false)[num1]
    if var3 == nil then
        return false
    end
    for _, value in var3 do
        if value.moment.momentId == momentId then
            return value.status == "Moderated"
        end
    end
    return false
end

local function isModerationFailure(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == "Moderated" or arg1 == tostring(Enum.UploadCaptureResult.CaptureModerated)
end

local function setPublishedPostOnUploadStore(arg1, arg2, str1: string?, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local var3 = arg1.resolve(str1)

    if callback ~= nil and var3 ~= nil then
        callback(var3)
    end
    if callback2 ~= nil and var3 == nil then
        callback2()
    end

    if not arg1.isCurrent() then
        return
    end

    if FFlagMomentsOptimisticProfilePending and str1 ~= nil then
        arg2.reset()
        return
    end

    if var3 ~= nil then
        arg2.setSuccess(var3)
    else
        arg2.reset()
    end
end

local function makeUploadStore(arg1, arg2, edits, description: string, resolvedTimeLength: number?, creationSessionId: string?, bool1: boolean?, bool2: boolean?)
    local publishedPostResolver = if FFlagMomentsResolvePublishedPostFeedItem and GetFFlagMomentsUseUploadPostAsync() then createPublishedPostResolver(
        {
            captureType = arg2.CaptureType,
            description = description,
            edits = edits,
            placeId = arg2.SourcePlaceId
        }
    ) else nil
    local momentId = nil
    local var3 = nil
    local localContent = nil
    local num1 = 0
    local var4 = nil

    local function makePostStatusCard(id: string, cardType, publishedMoment) -- Luacid: Inlined by compiler; 4 call sites recovered
        local tbl2 = {
            id = id,
            cardType = cardType,
            localContent = localContent,
            publishedMoment = publishedMoment,
            captureType = arg2.CaptureType,
            creationSessionId = creationSessionId,
            localId = if arg2.LocalId == nil then nil else tostring(arg2.LocalId),
            startedAtClock = num1
        }
        return tbl2
    end

    local function dismissPostingSnackbar() -- Luacid: Inlined by compiler; 4 call sites recovered
        if var4 ~= nil then
            GetToastStore(false).dismissToast(var4)
            var4 = nil
        end
    end

    local function addPostStatusCard(cardType, publishedMoment) -- Luacid: unused: defined but never referenced
        if momentId == nil then
            return
        end
        GetPostStatusCardStore(false).add((makePostStatusCard(momentId, cardType, publishedMoment)))
        dismissPostingSnackbar()
    end

    local function stopAwaitingLiveCard()
        if momentId == nil then
            return
        end

        local bool3 = not (var3 == nil) and isPendingMomentModerated(var3, momentId)
        local postStatusCardStore = GetPostStatusCardStore(false)
        postStatusCardStore.stopAwaitingLiveCard(momentId, if bool3 then nil else makePostStatusCard(momentId, "Live", nil))

        if postStatusCardStore.hasHadLiveCard(momentId) then
            dismissPostingSnackbar()
        end
    end

    return {
        setUploading = (FFlagMomentsRefreshProfileOnPostStatus or publishedPostResolver ~= nil) and function()
            if FFlagMomentsRefreshProfileOnPostStatus or FFlagMomentsOptimisticProfilePending and publishedPostResolver ~= nil then
                postLifecycleSubscription.subscribe()
            end
            if publishedPostResolver ~= nil then
                publishedPostResolver.captureSnapshot()
            end
            arg1.setUploading()

            if not FFlagMomentsOptimisticProfilePending or publishedPostResolver == nil or momentId ~= nil then
                return
            end

            local localUserId = getLocalUserId()
            if localUserId == nil then
                return
            end

            local pendingMomentItem = makePendingMomentItem(arg2, edits, description, resolvedTimeLength)
            momentId = pendingMomentItem.momentId
            var3 = localUserId

            if FFlagMomentsPostFeedbackIxpEnabled and bool2 then
                logMomentsLayerExposure(FStringMomentsPostFeedbackIxpLayer)
            end

            local var5 = if FFlagMomentsPostFeedback then os.clock() else nil
            MomentsGetMomentsUserStore(false).prependPendingUserMoment(localUserId, pendingMomentItem, var5)

            if FFlagMomentsPostFeedback then
                var1:debug("event=pending_moment_added momentId={}", pendingMomentItem.momentId)
                localContent = pendingMomentItem.localContent
                num1 = var5 or os.clock()
            end
            if FFlagMomentsHidePostStatusToast and bool1 then
                GetPostStatusCardStore(false).markUploading(pendingMomentItem.momentId)
            end
        end or arg1.setUploading,
        setFailed = FFlagMomentsOptimisticProfilePending and publishedPostResolver ~= nil and function(arg3)
            if var3 ~= nil and momentId ~= nil then
                MomentsGetMomentsUserStore(false).removePendingUserMoment(var3, momentId)
            end

            if FFlagMomentsPostFeedback and bool1 and not isModerationFailure(arg3) and momentId ~= nil then
                GetPostStatusCardStore(false).add((makePostStatusCard(momentId, "UploadFailed", nil)))
                dismissPostingSnackbar()
            end

            if FFlagMomentsHidePostStatusToast and bool1 and momentId ~= nil then
                GetPostStatusCardStore(false).stopAwaitingLiveCard(momentId, nil)
            end
            if publishedPostResolver.isCurrent() then
                arg1.setFailed(arg3)
            end
        end or arg1.setFailed,
        setSuccess = function(assetId)
            if type(assetId) ~= "number" then
                if FFlagMomentsHidePostStatusToast and bool1 and momentId ~= nil then
                    GetPostStatusCardStore(false).stopAwaitingLiveCard(momentId, nil)
                end
                arg1.setSuccess(assetId)
                return
            end

            if FFlagMomentsOptimisticProfilePending and var3 ~= nil and momentId ~= nil then
                local var5 = var3
                local var6 = momentId

                if FFlagMomentsHidePostStatusToast and bool1 then
                    GetPostStatusCardStore(false).awaitLiveCard(var6)
                end

                task.delay(game:GetFastInt("MomentsPendingMomentTtlSeconds"), function()
                    if FFlagMomentsPostFeedback and isPendingMomentModerated(var5, var6) then
                        var1:debug("event=pending_moment_ttl_skipped momentId={} reason=moderated", var6)
                        return
                    end
                    if FFlagMomentsPostFeedback then
                        var1:debug("event=pending_moment_ttl_expired momentId={}", var6)
                    end

                    if FFlagMomentsHidePostStatusToast and bool1 then
                        stopAwaitingLiveCard()
                    end
                    local var7 = MomentsGetMomentsUserStore(false)
                    var7.removePendingUserMoment(var5, var6)
                    var7.invalidateUser(var5)
                end)
            end

            if publishedPostResolver ~= nil then
                task.spawn(
                    setPublishedPostOnUploadStore,
                    publishedPostResolver,
                    arg1,
                    momentId,
                    if FFlagMomentsPostFeedback then bool1 and function(publishedMoment)
                        if momentId == nil then
                            return
                        end
                        GetPostStatusCardStore(false).add((makePostStatusCard(momentId, "Live", publishedMoment)))
                        dismissPostingSnackbar()
                    end or nil else nil,
                    if FFlagMomentsHidePostStatusToast and bool1 then stopAwaitingLiveCard else nil
                )
            elseif FFlagMomentsHydratePublishedFeedItem then
                task.spawn(setPublishedMomentOnUploadStore, assetId, arg1)
            else
                arg1.setSuccess((makeUploadedMomentItem(assetId, arg2, edits, description, resolvedTimeLength)))

                if FFlagMomentsRefreshOwnMomentsAfterPublish then
                    task.spawn(refreshOwnMomentsAfterPublish, assetId)
                end
            end
        end,
        hasPendingRecord = function(): boolean
            return momentId ~= nil
        end,
        setPostingSnackbarId = function(num2: number)
            var4 = num2
        end
    }
end

local function makePostFeedbackToastStore(arg1, hasPendingRecord: (...any) -> (...any), callback: (...any) -> (...any), title: string, title2: string, text: string, title3: string, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var3 = table.clone(arg1)
    function var3.triggerToast(arg3)
        if arg3.title == title and hasPendingRecord() then
            local var4 = arg1.triggerToast({ title = title3, text = "", variant = "snackbar", placement = "bottom" })

            callback(var4)
            fireAnalyticsEvent(EventNames.MomentPostSnackbarShown, arg2)
            return var4
        elseif arg3.title == title2 and arg3.text == text and hasPendingRecord() then
            return 0
        else
            return arg1.triggerToast(arg3)
        end
    end

    return var3
end

local function useUploadHost(tbl2)
    local onExit = tbl2.onExit
    local captureSource = tbl2.captureSource
    local bool1 = if FFlagMomentsPostFeedback then tbl2.postFeedback == true else nil
    local bool2 = if FFlagMomentsPostFeedbackIxpEnabled then tbl2.logsPostFeedbackExposure == true else nil
    local localizations = useLocalization(tbl1)
    local postingSnackbar = if FFlagMomentsPostFeedback then usePostFeedbackStrings().postingSnackbar else nil
    local var4 = if GetFFlagEnableMomentTextGeneration() then React.useRef({}) else nil

    return (React.useMemo(function()
        local uploadStore = GetUploadStore(false)
        local toastStore = GetToastStore(false)

        local fFlagEnableMomentTextGeneration = GetFFlagEnableMomentTextGeneration()

        local function triggerGenerationToast(tbl3: {text: any, title: any}) -- Luacid: Inlined by compiler; 5 call sites recovered
            local var5 = toastStore.triggerToast(tbl3)
            if var4 ~= nil then
                table.insert(var4.current, var5)
            end
        end

        return {
            exitCreationFlow = onExit,
            captureSource = captureSource,
            generateMomentText = if fFlagEnableMomentTextGeneration then generateMomentText else nil,
            momentGeneratedTextFeedback = if fFlagEnableMomentTextGeneration then momentGeneratedTextFeedback else nil,
            onGenerateTextManualEditBlocked = fFlagEnableMomentTextGeneration and function()
                triggerGenerationToast({ title = localizations.generateInProgressTitle, text = localizations.generateInProgressBody })
            end or nil,
            onGenerateTextSuccess = fFlagEnableMomentTextGeneration and function()
                triggerGenerationToast({ title = localizations.generatedTitle, text = localizations.generatedBody })
            end or nil,
            onGenerateTextFailure = fFlagEnableMomentTextGeneration and function()
                triggerGenerationToast({ title = localizations.generateFailedTitle, text = localizations.generateFailedBody })
            end or nil,
            onGenerateTextFiltered = fFlagEnableMomentTextGeneration and function()
                triggerGenerationToast({ title = localizations.generateFilteredTitle, text = localizations.generateFilteredBody })
            end or nil,
            onGenerateTextWillReplaceInput = fFlagEnableMomentTextGeneration and function()
                triggerGenerationToast({ title = localizations.generateOverrideTitle, text = localizations.generateOverrideBody })
            end or nil,
            dismissGenerationToasts = fFlagEnableMomentTextGeneration and function()
                if var4 == nil then
                    return
                end

                for _, value in var4.current do
                    toastStore.dismissToast(value)
                end
                var4.current = {}
            end or nil,
            isTextFiltered = MomentsCreation.isTextFiltered,
            createMoment = var2 and function(_, _, str1: string, _: string?, _: number?)
                print(`[moments-creation] dev publish (not uploaded): "{str1}"`)
            end or function(arg1, edits, description: string, creationSessionId: string?, resolvedTimeLength: number?, commentsEnabled: boolean?)
                local uploadStore2 = makeUploadStore(
                    uploadStore,
                    arg1,
                    edits,
                    description,
                    resolvedTimeLength,
                    creationSessionId,
                    if FFlagMomentsPostFeedback then bool1 else nil,
                    if FFlagMomentsPostFeedbackIxpEnabled then bool2 else nil
                )

                local var5 = publishMomentWithUpload
                local tbl3 = {
                    localizations = localizations,
                    uploadStore = uploadStore2,
                    toastStore = 0,
                    creationSessionId = 0,
                    resolvedTimeLength = 0,
                    commentsEnabled = 0
                }
                local postFeedbackToastStore

                if bool1 and postingSnackbar ~= nil then
                    local var6 = toastStore
                    local hasPendingRecord = uploadStore2.hasPendingRecord
                    local setPostingSnackbarId = uploadStore2.setPostingSnackbarId
                    local publishingTitle = localizations.publishingTitle
                    local failedTitle = localizations.failedTitle
                    local failedBody = localizations.failedBody
                    local var7 = postingSnackbar
                    local var8 = makePostFeedbackEventFields
                    local tbl4 = {
                        creationSessionId = creationSessionId,
                        localId = if arg1.LocalId == nil then nil else tostring(arg1.LocalId),
                        captureType = arg1.CaptureType
                    }
                    postFeedbackToastStore = makePostFeedbackToastStore(
                        var6,
                        hasPendingRecord,
                        setPostingSnackbarId,
                        publishingTitle,
                        failedTitle,
                        failedBody,
                        var7,
                        (var8(tbl4))
                    )
                else
                    postFeedbackToastStore = toastStore
                end

                tbl3.toastStore = postFeedbackToastStore

                tbl3.creationSessionId = creationSessionId
                tbl3.resolvedTimeLength = resolvedTimeLength
                tbl3.commentsEnabled = commentsEnabled
                var5(arg1, edits, description, tbl3)
            end
        }
    end, {
        onExit,
        captureSource,
        localizations,
        postingSnackbar,
        bool1,
        bool2
    }))
end
return useUploadHost

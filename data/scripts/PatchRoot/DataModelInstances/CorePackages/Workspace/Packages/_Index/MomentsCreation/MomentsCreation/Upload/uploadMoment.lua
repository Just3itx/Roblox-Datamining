-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local normalizeMomentMetadata = require(MomentsCreation.Utils.normalizeMomentMetadata)
local completeMomentUpload = require(MomentsCreation.Upload.completeMomentUpload)
local Logger = require(MomentsCreation.Logger)
local FFlagMomentsTextOverlayV2Redesign = require(MomentsCreationParent.MomentsCommon).Flags.FFlagMomentsTextOverlayV2Redesign
local GetFFlagMomentsUseUploadPostAsync = MomentsCommon.Flags.GetFFlagMomentsUseUploadPostAsync
local bool1 = game:DefineFastFlag("MomentsPostUploadFailureReasons", false)
local GetFFlagMomentsUseMomentsServiceForUpload = MomentsCommon.Flags.GetFFlagMomentsUseMomentsServiceForUpload
local makePostMetadata = require(MomentsCreation.Utils.makePostMetadata)
local FFlagMomentsCreationSessionId = require(MomentsCreation.Flags.FFlagMomentsCreationSessionId)

local enumName = makeCreationEventFields.enumName

local game2 = game

local engineFeature = game:GetEngineFeature("CaptureServiceUploadUniverseIdOverride")

local engineFeature2 = game:GetEngineFeature("CaptureServiceStartUploadCoreScriptBypass")

game:DefineFastString("MomentsUploadUniverseId", "8357232245")
game:DefineFastInt("MomentsUploadPollIntervalSeconds", 5)
game:DefineFastInt("MomentsUploadMaxPollAttempts", 120)

local function logValue(arg1) -- Luacid: Inlined by compiler; 22 call sites recovered
    local var1 = enumName(arg1) or "nil"
    local var2 = string.gsub(var1, "\r", "\\r")
    return (string.gsub(var2, "\n", "\\n"))
end

local function injectUniverseIdOverride(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local gameId = game2.GameId
    if gameId ~= nil and gameId > 0 then
        return arg1
    end
    local var1 = table.clone(arg1)
    var1.universeIdOverride = tonumber(game:GetFastString("MomentsUploadUniverseId"))
    return var1
end

local function uploadMoment(arg1, arg2, arg3, localizations, uploadStore, toastStore, feedStore, myCreationsStore, creationSessionId: string?, arg4, arg5)
    local var1 = arg4 or CaptureService
    if engineFeature then
        arg2 = injectUniverseIdOverride(arg2)
    end

    local var2 = normalizeMomentMetadata(arg2)

    Logger:debug(
        "event=upload_start CaptureServiceStartUploadCoreScriptBypass={} MomentsUseBackendPostStatusNotification={} localId={} captureType={} sourcePlaceId={} sourceUniverseId={}",
        logValue(engineFeature2),
        logValue(true),
        logValue(arg1.LocalId),
        logValue(arg1.CaptureType),
        logValue(arg1.SourcePlaceId),
        (logValue(arg1.SourceUniverseId))
    )

    uploadStore.setUploading()

    toastStore.triggerToast({ title = localizations.publishingTitle, text = localizations.publishingBody })

    local function publishFields(tbl1) -- Luacid: unused: defined but never referenced
        tbl1.creationSessionId = creationSessionId
        return tbl1
    end

    local function fireUploadFailed(tbl1, str1: string?) -- Luacid: Inlined by compiler; 9 call sites recovered
        MomentsCommon.Analytics.reportMomentsCreationStep("upload", "failed", str1)
        tbl1.localId = tostring(arg1.LocalId)
        tbl1.creationSessionId = creationSessionId
        fireAnalyticsEvent(EventNames.UploadCaptureFailed, tbl1)
    end

    task.spawn(function()
        if GetFFlagMomentsUseUploadPostAsync() then
            Logger:debug("event=path_selected path=post_upload localId={}", (logValue(arg1.LocalId)))

            local postMetadata = makePostMetadata(
                if FFlagMomentsTextOverlayV2Redesign then arg2 else var2,
                if GetFFlagMomentsUseMomentsServiceForUpload() then arg1 else nil,
                creationSessionId
            )

            local var3 = fireAnalyticsEvent
            local editingFlowMomentPublished = EventNames.EditingFlowMomentPublished
            local captureDescriptorFields = makeCreationEventFields.makeCaptureDescriptorFields(arg1)
            captureDescriptorFields.creationSessionId = creationSessionId

            var3(editingFlowMomentPublished, captureDescriptorFields)

            local success, result = pcall(function()
                if GetFFlagMomentsUseMomentsServiceForUpload() then
                    return (arg5 or game:GetService("MomentsService")):CreatePostAsync(postMetadata)
                end
                return var1:UploadPostAsync(arg1, postMetadata)
            end)

            if success then
                Logger:debug("event=post_upload_success localId={} assetId={}", logValue(arg1.LocalId), (logValue(result.assetId)))

                completeMomentUpload(result.assetId, {
                    uploadStore = uploadStore,
                    toastStore = toastStore,
                    feedStore = feedStore,
                    myCreationsStore = myCreationsStore,
                    localizations = localizations,
                    onPostedToFeed = function()
                        local tbl1 = {
                            assetId = tostring(result.assetId),
                            localId = tostring(arg1.LocalId),
                            captureType = enumName(arg1.CaptureType)
                        }
                        if FFlagMomentsCreationSessionId and result.operationId ~= nil and result.operationId ~= "" then
                            tbl1.correlationId = result.operationId
                        end
                        local var4 = fireAnalyticsEvent
                        local editingFlowMomentPostedToFeed = EventNames.EditingFlowMomentPostedToFeed
                        tbl1.creationSessionId = creationSessionId

                        var4(editingFlowMomentPostedToFeed, tbl1)
                    end
                })

                return
            end

            Logger:debug("event=post_upload_failed localId={} error={}", logValue(arg1.LocalId), (logValue(result)))

            uploadStore.setFailed("GenericFailure")
            toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })

            fireUploadFailed(
                {
                    status = "GenericFailure",
                    error = tostring(result),
                    captureType = enumName(arg1.CaptureType)
                },
                if bool1 then require(MomentsCreation.Upload.classifyPostUploadError)(result) else "GenericFailure"
            )
            return
        end

        if not engineFeature2 then
            Logger:debug("event=path_selected path=fallback localId={}", (logValue(arg1.LocalId)))

            local success, result = pcall(function()
                var1:UploadCaptureAndPostMoment(arg1, var2, arg3)
            end)

            if success then
                local var3 = fireAnalyticsEvent
                local editingFlowMomentPublished = EventNames.EditingFlowMomentPublished
                local captureDescriptorFields = makeCreationEventFields.makeCaptureDescriptorFields(arg1)
                captureDescriptorFields.creationSessionId = creationSessionId

                var3(editingFlowMomentPublished, captureDescriptorFields)
            end

            if not success then
                uploadStore.setFailed("GenericFailure")
                toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })
                local tbl1 = {
                    error = tostring(result),
                    captureType = enumName(arg1.CaptureType)
                }
                tbl1.status = "GenericFailure"
                fireUploadFailed(tbl1, "GenericFailure")
                return
            end

            MomentsCommon.Analytics.reportMomentsCreationStep("upload", "success")
            return
        end

        Logger:debug("event=path_selected path=two_phase localId={}", (logValue(arg1.LocalId)))

        local success, result, result2 = pcall(function()
            return var1:StartUploadCaptureAsync(arg1)
        end)

        if success then
            Logger:debug("event=start_upload localId={} pcallSuccess=true status={}", logValue(arg1.LocalId), (logValue(result)))
        else
            Logger:debug(
                "event=start_upload localId={} pcallSuccess=false status=pcall_error errorClass={}",
                logValue(arg1.LocalId),
                typeof(result)
            )
        end

        if not success then
            uploadStore.setFailed("StartUploadFailed")
            toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })

            local tbl1 = {
                status = enumName(result),
                captureType = enumName(arg1.CaptureType)
            }
            tbl1.status = "StartUploadFailed"
            tbl1.error = tostring(result)
            fireUploadFailed(tbl1, "StartUploadFailed")
            return
        end

        if result ~= Enum.UploadCaptureResult.Success then
            if result == Enum.UploadCaptureResult.CaptureModerated then
                toastStore.triggerToast({ title = localizations.removedTitle, text = localizations.removedBody })
            elseif result == Enum.UploadCaptureResult.UploadQuotaReached then
                toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.uploadQuotaReachedBody })
            else
                toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })
            end
            uploadStore.setFailed(tostring(result))
            fireUploadFailed({ status = enumName(result), captureType = enumName(arg1.CaptureType) }, (enumName(result)))
            return
        end

        local success2, result3 = pcall(function()
            var1:UploadCaptureAndPostMoment(arg1, var2, arg3)
        end)

        Logger:debug(
            "event=registration localId={} pcallSuccess={} errorClass={}",
            logValue(arg1.LocalId),
            tostring(success2),
            if success2 then "none" else typeof(result3)
        )

        if not success2 then
            uploadStore.setFailed("RegistrationFailed")
            toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })
            fireUploadFailed(
                {
                    status = "RegistrationFailed",
                    error = tostring(result3),
                    captureType = enumName(arg1.CaptureType)
                },
                "RegistrationFailed"
            )
            return
        end

        local var3 = fireAnalyticsEvent
        local editingFlowMomentPublished = EventNames.EditingFlowMomentPublished
        local captureDescriptorFields = makeCreationEventFields.makeCaptureDescriptorFields(arg1)
        captureDescriptorFields.creationSessionId = creationSessionId

        var3(editingFlowMomentPublished, captureDescriptorFields)

        local bool2 = false
        local var4 = nil

        local fastInt = game:GetFastInt("MomentsUploadPollIntervalSeconds")
        local fastInt2 = game:GetFastInt("MomentsUploadMaxPollAttempts")
        for i = 1, fastInt2 do
            task.wait(fastInt)

            local success3, result4, result2_2 = pcall(function()
                return var1:CheckUploadCaptureStatusAsync(result2)
            end)

            local bool3 = not bool2 or success3 and result4 ~= var4
            local bool4 = not success3 or result4 ~= Enum.UploadCaptureResult.UploadPending
            local bool5 = i % 6 == 0

            if success3 then
                var4 = result4
                bool2 = true
            end

            if i == 1 or bool3 or bool4 or bool5 then
                if success3 then
                    Logger:debug(
                        "event=poll localId={} attempt={} pcallSuccess=true status={} assetId={} heartbeat={}",
                        logValue(arg1.LocalId),
                        tostring(i),
                        logValue(result4),
                        logValue(result2_2),
                        tostring(bool5 and not bool3)
                    )
                else
                    Logger:debug(
                        "event=poll localId={} attempt={} pcallSuccess=false status=pcall_error errorClass={}",
                        logValue(arg1.LocalId),
                        tostring(i),
                        typeof(result4)
                    )
                end
            end

            if not success3 then
                uploadStore.setFailed("PollError")
                toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })

                fireUploadFailed(
                    {
                        status = "PollError",
                        error = tostring(result4),
                        captureType = enumName(arg1.CaptureType)
                    },
                    "PollError"
                )
                return
            end

            if result4 == Enum.UploadCaptureResult.Success then
                completeMomentUpload(result2_2, {
                    uploadStore = uploadStore,
                    toastStore = toastStore,
                    feedStore = feedStore,
                    myCreationsStore = myCreationsStore,
                    localizations = localizations,
                    onPostedToFeed = function()
                        local var5 = fireAnalyticsEvent
                        local editingFlowMomentPostedToFeed = EventNames.EditingFlowMomentPostedToFeed
                        local tbl1 = {
                            assetId = tostring(result2_2),
                            localId = tostring(arg1.LocalId),
                            captureType = enumName(arg1.CaptureType)
                        }
                        tbl1.creationSessionId = creationSessionId

                        var5(editingFlowMomentPostedToFeed, tbl1)
                    end
                })

                return
            end

            if result4 == Enum.UploadCaptureResult.UploadPending then
                continue
            end
            if result4 == Enum.UploadCaptureResult.CaptureModerated then
                uploadStore.setFailed("Moderated")
                toastStore.triggerToast({ title = localizations.removedTitle, text = localizations.removedBody })
                fireUploadFailed({ status = enumName(result4), captureType = enumName(arg1.CaptureType) }, (enumName(result4)))
                return
            end
            uploadStore.setFailed(tostring(result4))
            toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })
            fireUploadFailed({ status = enumName(result4), captureType = enumName(arg1.CaptureType) }, (enumName(result4)))
            return
        end

        Logger:debug("event=poll_timeout localId={} attempts={}", logValue(arg1.LocalId), tostring(fastInt2))

        uploadStore.setFailed("Timeout")
        toastStore.triggerToast({ title = localizations.failedTitle, text = localizations.failedBody })
        fireUploadFailed({ status = "Timeout", captureType = enumName(arg1.CaptureType) }, "Timeout")
    end)
end

return uploadMoment

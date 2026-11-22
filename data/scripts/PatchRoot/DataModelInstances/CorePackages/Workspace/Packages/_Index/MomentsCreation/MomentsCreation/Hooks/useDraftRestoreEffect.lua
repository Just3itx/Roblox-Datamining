-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Cryo = require(MomentsCreationParent.Cryo)
local React = require(MomentsCreationParent.React)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local GetCreationFlowStore = require(MomentsCreation.Stores.GetCreationFlowStore)
local MomentsDraftStorage = require(MomentsCreation.Storage.MomentsDraftStorage)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local FailureReason = require(MomentsCreation.Enums.FailureReason)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local FFlagMomentsCommentsCreatorControl = require(MomentsCreation.Flags.FFlagMomentsCommentsCreatorControl)
local FFlagMomentsTTSDraftRestore = require(MomentsCreation.Flags.FFlagMomentsTTSDraftRestore)
local FFlagMomentsTTSVoiceSelector = require(MomentsCreation.Flags.FFlagMomentsTTSVoiceSelector)
local defaultCreationTools = require(MomentsCreation.Tools.defaultCreationTools)
local voiceTool = require(MomentsCreation.Tools.voiceTool)
local voiceCatalog = require(MomentsCreation.Components.Voice.voiceCatalog)

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames

local function withCreationSession(tbl1)
    local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
    return Cryo.Dictionary.join(tbl1, makeCreationEventFields.makeCreationBaseFields(sessionId))
end

local function withAvailableVoice(voice) -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagMomentsTTSVoiceSelector and voiceCatalog.getVoiceById(voice.voiceId) ~= nil then
        return voice
    end
    local var1 = table.clone(voice)
    var1.voiceId = voiceCatalog.getDefaultVoiceId()
    return var1
end

local function useDraftRestoreEffect(bool1: boolean?, bool2: boolean?)
    local creationFlowStore = GetCreationFlowStore(false)

    React.useEffect(function()
        if bool2 then
            return
        end

        if creationFlowStore.getSelectedCapture(false) ~= nil or next(creationFlowStore.getEditsMap(false)) ~= nil then
            return
        end

        if bool1 == nil then
            return
        end

        local var1, reason = MomentsDraftStorage.load()
        if reason ~= nil then
            fireAnalyticsEvent(EventNames.DraftRestoreFailedEvent, { reason = reason })
            return
        end

        if var1 == nil then
            return
        end

        local var3 = nil
        for _, value in bool1.getCaptures(false) do
            if value.LocalId == var1.captureRef.localId then
                var3 = value
                break
            end
        end

        if var3 == nil then
            MomentsDraftStorage.clear()
            fireAnalyticsEvent(EventNames.DraftRestoreFailedEvent, { reason = FailureReason.CaptureDeleted })
            return
        end

        creationFlowStore.onSelectedCaptureUpdated(var3)
        creationFlowStore.updateDescription(var1.description or "")
        if FFlagMomentsCommentsCreatorControl then
            creationFlowStore.updateCommentsEnabled(var1.commentsEnabled ~= false)
        end
        for k, edit in pairs(var1.edits) do
            if not FFlagMomentsTTSDraftRestore or k ~= "voice" then
                creationFlowStore.setCommittedEdit(k, edit)
            end
        end

        if FFlagMomentsTTSDraftRestore and var1.edits.voice ~= nil and table.find(defaultCreationTools, voiceTool) ~= nil then
            local var4 = withAvailableVoice(var1.edits.voice)
            creationFlowStore.setCommittedEdit("voice", var4)
            creationFlowStore.setPendingRestoredVoice(var4)
        end
        creationFlowStore.updateCurrentState(CreationFlowState.Preview)

        fireAnalyticsEvent(EventNames.DraftRestoreSucceededEvent, withCreationSession({}))
    end, { creationFlowStore, bool1, bool2 })
end

return useDraftRestoreEffect

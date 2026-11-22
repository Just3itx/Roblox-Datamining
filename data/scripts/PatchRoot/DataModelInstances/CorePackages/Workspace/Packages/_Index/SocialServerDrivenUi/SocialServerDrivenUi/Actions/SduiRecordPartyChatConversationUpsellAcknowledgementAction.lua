-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local RecordModalSequenceResponse = require(SocialServerDrivenUiParent.AppChatNetworking).http.RecordModalSequenceResponse
local getSduiApiStore = require(SocialServerDrivenUiParent.SduiSharedUtilities).getSduiApiStore
local recordedModalActions = require(SocialServerDrivenUi.Common.recordedModalActions)

local function orNil(arg1): string? -- Luacid: Inlined by compiler; 4 call sites recovered
    return if typeof(arg1) == "string" and arg1 ~= "" then arg1 else nil
end

local function SduiRecordPartyChatConversationUpsellAcknowledgementAction(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RecordPartyChatConversationUpsellAcknowledgement,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local modalAction = actionParams.modalAction
    local actionType = recordedModalActions.toRecordedModalAction(modalAction)
    if actionType == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.RecordPartyChatConversationUpsellAcknowledgement,
            message = `Invalid or missing modalAction: {tostring(modalAction)}`,
            propName = "modalAction"
        }, arg2.appPage)
        return
    end

    local modalSequence = orNil(actionParams.modalSequence)
    if modalSequence == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.RecordPartyChatConversationUpsellAcknowledgement,
            message = "Missing actionParam: modalSequence",
            propName = "modalSequence"
        }, arg2.appPage)
        return
    end

    local modalVariant = orNil(actionParams.modalVariant)
    local conversationId = orNil(actionParams.conversationId)
    local var5 = orNil(actionParams.friendId)
    if conversationId == nil and var5 == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.RecordPartyChatConversationUpsellAcknowledgement,
            message = "Missing actionParam: one of conversationId or friendId is required",
            propName = "conversationId"
        }, arg2.appPage)
        return
    end

    if conversationId ~= nil then
        var5 = nil
    end
    RecordModalSequenceResponse(nil, {
        actionType = actionType,
        modalSequence = modalSequence,
        modalVariant = modalVariant,
        conversationId = conversationId,
        friendId = var5
    }):catch(
        function(arg3)
            arg2.dependencies.logger.reportError(SduiErrorType.ActionNetworkRequestFailed, {
                name = SduiActionType.RecordPartyChatConversationUpsellAcknowledgement,
                message = `RecordModalSequenceResponse failed: {tostring(arg3)}`
            }, arg2.appPage)
        end
    )

    if modalAction ~= recordedModalActions.ModalAction.Close or arg2.configKey == nil then
        return
    end

    local clearConfigEntries = getSduiApiStore().clearConfigEntries
    if clearConfigEntries then
        clearConfigEntries(arg2.configKey)
    end
end

return SduiRecordPartyChatConversationUpsellAcknowledgementAction

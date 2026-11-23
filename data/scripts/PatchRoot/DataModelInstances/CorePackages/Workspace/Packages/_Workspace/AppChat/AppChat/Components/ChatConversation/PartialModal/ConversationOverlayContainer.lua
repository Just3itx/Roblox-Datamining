-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local _types = require(AppChat.types)

local var1 = require(AppChat.Logger):new(script.Name)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local React = require(AppChatParent.React)
local ConversationOverlay = AppChatNetworking.Constants.ConversationOverlay
local ModalSequence = AppChatNetworking.Constants.ModalSequence
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useShouldShowConversationOverlay = require(AppChat.Hooks.useShouldShowConversationOverlay)
local useRecordModalSeenWithDelay = require(AppChat.Hooks.useRecordModalSeenWithDelay)
local ModalConfiguration = require(AppChat.Models.ModalConfiguration)
local TrustedFriendsUpsellContainer = require(AppChat.Components.TrustedFriendsUpsell.TrustedFriendsUpsellContainer)
local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)

local useRecordModalSequenceResponseForConversation = require(AppChat.Hooks.useRecordModalSequenceResponseForConversation)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local DismissedChatModal = require(AppChat.Conversations.Actions.DismissedChatModal)

local FIntAppChatModalSeenImpressionDelayMs = require(AppChat.Flags.FIntAppChatModalSeenImpressionDelayMs)

local tbl1 = {
    [ConversationOverlay.TrustedConnectionCreated] = true,
    [ConversationOverlay.AddTrustedConnectionU18] = true,
    [ConversationOverlay.TrustedConnectionRequestU18] = true
}

return React.memo(function(tbl2)
    local var2 = useSelector(function(arg1)
        return getDeepValue2(arg1, `ChatAppReducer.Modals.conversationOverlays.{tbl2.conversationId}`)
            or ModalConfiguration.default
    end)

    var2 = React.useMemo(function()
        return var2
    end, { tbl2.conversationId })
    local modalLayout = var2.modal_layout
    local canRecordAction = useShouldShowConversationOverlay(tbl2.conversationId) and tbl1[var2.modal_variant] == true
    local var4 = useRecordModalSequenceResponseForConversation(tbl2.conversationId)
    local var5 = useDispatch()
    local userId = useGetOneToOneFriendIdFromConversationId(tbl2.conversationId)

    useRecordModalSeenWithDelay({
        modalSequence = ModalSequence.ConversationOverlay,
        modalId = modalLayout.id,
        modalVariant = var2.modal_variant,
        actionToRecord = modalLayout.seen_record_action,
        delayMs = FIntAppChatModalSeenImpressionDelayMs,
        canRecordAction = canRecordAction,
        conversationId = tbl2.conversationId
    })

    React.useEffect(function()
        if not canRecordAction then
            tbl2.dismissModal()
        end
    end, { canRecordAction })

    local dismissModal = React.useCallback(function()
        var4(
            var2.modal_layout.dismissed_record_action,
            AppChatNetworking.Constants.ModalSequence.ConversationOverlay,
            var2.modal_layout.id,
            var2.modal_variant
        ):catch(
            function(arg1)
                var1:warning(
                    `Error in ConversationOverlayContainer {var2.modal_layout.id} -> RecordModalSequenceResponse: {tostring(arg1)}`
                )
            end
        )

        tbl2.dismissModal()
        var5(DismissedChatModal(AppChatNetworking.Constants.ModalSequence.ConversationOverlay, tbl2.conversationId))
    end, {
        tbl2.conversationId,
        var2.modal_layout.dismissed_record_action,
        var2.modal_layout.id,
        var2.modal_variant,
        var4,
        var5,
        tbl2.dismissModal
    })

    if not (canRecordAction and userId) then
        return nil
    end

    return React.createElement(TrustedFriendsUpsellContainer, {
        userId = userId,
        conversationId = tbl2.conversationId,
        analyticsModalVariant = var2.modal_variant,
        dismissModal = dismissModal
    })
end)

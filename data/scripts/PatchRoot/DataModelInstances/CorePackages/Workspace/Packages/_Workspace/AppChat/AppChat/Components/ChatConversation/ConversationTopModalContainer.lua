-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local var1 = require(AppChat.Logger):new(script.Name)

local Foundation = require(AppChatParent.Foundation)
local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ConversationTopModal = AppChatNetworking.Constants.ConversationTopModal
local ModalConfiguration = require(AppChat.Models.ModalConfiguration)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local useRecordModalSeenWithDelay = require(AppChat.Hooks.useRecordModalSeenWithDelay)
local ModalSequence = AppChatNetworking.Constants.ModalSequence

local useRecordModalSequenceResponseForConversation = require(AppChat.Hooks.useRecordModalSequenceResponseForConversation)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local DismissedChatModal = require(AppChat.Conversations.Actions.DismissedChatModal)
local useIsGuiInChatVisible = require(AppChat.Hooks.useIsGuiInChatVisible)

local ConversationBannerContainer = require(script.Parent.ConversationBanner.ConversationBannerContainer)

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(AppChatParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner

local SduiConstants = require(AppChat.Sdui.SduiConstants)
local SduiSharedUtilities = if FFlagAppChatConversationTrustedFriendUpsellBanner then require(AppChatParent.SduiSharedUtilities) else nil
local SduiFeatureEntryPoint = if FFlagAppChatConversationTrustedFriendUpsellBanner then SduiSharedUtilities.SduiFeatureEntryPoint else nil
local useComponentConfig = if FFlagAppChatConversationTrustedFriendUpsellBanner then SduiSharedUtilities.useComponentConfig else nil
local FIntAppChatModalSeenImpressionDelayMs = require(AppChat.Flags.FIntAppChatModalSeenImpressionDelayMs)

local tbl1 = {
    setModalHeight = function(_) end
}

local tbl2 = {
    [ConversationTopModal.AddTrustedConnection] = ConversationBannerContainer,
    [ConversationTopModal.TrustedConnectionRequest] = ConversationBannerContainer
}

return React.memo(function(tbl3) -- name: ConversationTopModalContainer
    local var2 = Cryo.Dictionary.union(tbl1, tbl3)
    local var3 = useSelector(function(arg1)
        return getDeepValue2(arg1, `ChatAppReducer.Modals.conversationTopModals.{var2.conversationId}`)
            or ModalConfiguration.default
    end)

    local modalLayout = var3.modal_layout
    local var4 = tbl2[var3.modal_variant]
    local var5 = useDispatch()
    local var6 = useRecordModalSequenceResponseForConversation(var2.conversationId)

    local var7 = React.useRef(nil)
    local var8 = useIsGuiInChatVisible(var7, { var7.current, var4 })
    local configKey = if FFlagAppChatConversationTrustedFriendUpsellBanner then SduiConstants.getConversationTopModalConfigKey(var2.conversationId) else nil
    local var9 = if FFlagAppChatConversationTrustedFriendUpsellBanner then useComponentConfig(configKey, SduiConstants.ConversationTopModalIdentifier) else nil
    local var10 = FFlagAppChatConversationTrustedFriendUpsellBanner

    if var10 then
        if var4 == nil then
            var10 = var9 ~= nil
        else
            var10 = false
        end
    end

    useRecordModalSeenWithDelay({
        modalSequence = ModalSequence.ConversationTopModal,
        modalVariant = var3.modal_variant,
        actionToRecord = modalLayout.seen_record_action,
        delayMs = FIntAppChatModalSeenImpressionDelayMs,
        canRecordAction = var8 and var4 ~= nil,
        conversationId = var2.conversationId
    })

    local onDismissed = React.useCallback(function()
        var6(var3.modal_layout.dismissed_record_action, ModalSequence.ConversationTopModal, nil, var3.modal_variant):catch(
            function(arg1)
                var1:warning(
                    `Error in ConversationOverlayContainer {var3.modal_layout.id} -> RecordModalSequenceResponse: {tostring(arg1)}`
                )
            end
        )

        var5(DismissedChatModal(AppChatNetworking.Constants.ModalSequence.ConversationTopModal, var2.conversationId))
    end, {
        var2.conversationId,
        var3.modal_layout.dismissed_record_action,
        var3.modal_variant,
        var6,
        var5
    })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2.setModalHeight(arg1.AbsoluteSize.Y)
    end, { var2.setModalHeight })

    local element = nil
    if var4 then
        element = React.createElement(var4, {
            conversationId = var2.conversationId,
            modalVariant = var3.modal_variant,
            onDismissed = onDismissed,
            bodyText = modalLayout.body and modalLayout.body.text,
            actionText = modalLayout.buttons and modalLayout.buttons[1] and modalLayout.buttons[1].text
        })
    elseif var10 then
        element = React.createElement(SduiFeatureEntryPoint, {
            configKey = configKey,
            identifier = SduiConstants.ConversationTopModalIdentifier,
            appPage = SduiConstants.SurfaceKey,
            shouldDisplayLoading = false,
            shouldDisplayError = false
        })
    elseif var3.modal_variant ~= nil and var3.modal_variant ~= ConversationTopModal.None then
        var1:warning(`Unsupported ConversationTopModal variant: {var3.modal_variant}`)
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl4 = {
        LayoutOrder = var2.layoutOrder,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        ref = 0,
        tag = "gui-objects-default auto-y size-full-0"
    }

    if var10 then
        var7 = nil
    end

    tbl4.ref = var7
    return createElement(view, tbl4, { conversationTopModal = element })
end)

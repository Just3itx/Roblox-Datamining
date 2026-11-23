-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local _types = require(AppChat.types)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local React = require(AppChatParent.React)
local TrustedContacts = require(AppChatParent.TrustedContacts)
local AppTabBarRodux = require(AppChatParent.AppTabBarRodux)
local _ConversationOverlay = AppChatNetworking.Constants.ConversationOverlay
local useIsAppChatVerticallyConstrained = require(AppChat.App.Hooks.useIsAppChatVerticallyConstrained)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch

local refreshConversationUnfilteredThreadsDetails = require(AppChat.Conversations.Thunks.refreshConversationUnfilteredThreadsDetails)
local Promise = require(AppChatParent.Promise)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local SetTabBarVisibleFromChat = AppTabBarRodux.Thunks.SetTabBarVisibleFromChat

local ConversationOverlayTelemetry = require(AppChat.Components.ChatConversation.PartialModal.ConversationOverlayTelemetry)
local ModalTelemetry = require(AppChat.Components.ModalTelemetry)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local AppTelemetryLayer = require(AppChat.Telemetry.Layers.AppTelemetryLayer)

local TrustedFriendsModalEntry = TrustedContacts.TrustedFriendsModalEntry

local FIntUnfilteredThreadsPvDelayMs = require(AppChat.Flags.FIntUnfilteredThreadsPvDelayMs)

return function(tbl1)
    local isVerticallyConstrained = useIsAppChatVerticallyConstrained()
    local var2 = useDispatch()
    local var3 = useIsInExperience()
    local analyticsModalVariant = tbl1.analyticsModalVariant
    local conversationId = tbl1.conversationId

    local var4 = useTelemetry(AppTelemetryLayer.Context)
    React.useEffect(function()
        if analyticsModalVariant == nil then
            return
        end
        var4.emit(ConversationOverlayTelemetry.Events.ModalRendered, { modalVariant = analyticsModalVariant })
    end, { analyticsModalVariant })

    React.useEffect(function()
        var2(SetTabBarVisibleFromChat(false))
        return function()
            var2(SetTabBarVisibleFromChat(true))
        end
    end, { var2 })

    local var5 = React.useCallback(function()
        tbl1.dismissModal()
        if conversationId ~= nil then
            Promise.delay(FIntUnfilteredThreadsPvDelayMs / 1000):andThen(function()
                var2(refreshConversationUnfilteredThreadsDetails(conversationId, var3))
            end)
        end
    end, {
        conversationId,
        var2,
        tbl1.dismissModal,
        var3
    })

    local onClosed = React.useCallback(function()
        if analyticsModalVariant ~= nil then
            var4.emit(
                ConversationOverlayTelemetry.Events.ModalAction,
                {
                    modalVariant = analyticsModalVariant,
                    action = ModalTelemetry.Enums.ModalActions.Dismiss
                }
            )
        end

        var5()
    end, { var5, var4, analyticsModalVariant })
    local onAcknowledged = React.useCallback(function()
        if analyticsModalVariant ~= nil then
            var4.emit(
                ConversationOverlayTelemetry.Events.ModalAction,
                {
                    modalVariant = analyticsModalVariant,
                    action = ModalTelemetry.Enums.ModalActions.PrimaryCta
                }
            )
        end

        if tbl1.onAcknowledged ~= nil then
            tbl1.onAcknowledged()
        end
    end, { var4, analyticsModalVariant, tbl1.onAcknowledged })

    return React.createElement(TrustedFriendsModalEntry, {
        userId = tbl1.userId,
        source = tbl1.source,
        isVerticallyConstrained = isVerticallyConstrained,
        modalVariantOverride = tbl1.modalVariantOverride,
        onRequestSent = tbl1.onRequestSent,
        onRequestAccepted = tbl1.onRequestAccepted,
        onAcknowledged = onAcknowledged,
        onClosed = onClosed
    })
end

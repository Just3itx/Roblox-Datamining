-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local _types = require(AppChat.types)
local ConversationTopModal = AppChatNetworking.Constants.ConversationTopModal
local ConversationOverlay = AppChatNetworking.Constants.ConversationOverlay
local EnumScreens = require(AppChat.EnumScreens)
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local ConversationTopModalTelemetry = require(script.Parent.Parent.ConversationTopModalTelemetry)
local ModalTelemetry = require(AppChat.Components.ModalTelemetry)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)

local ConversationBanner = require(script.Parent.ConversationBanner)

local tbl1 = {
    [ConversationTopModal.AddTrustedConnection] = {
        onActivatedOverlayVariant = ConversationOverlay.AddTrustedConnectionU18
    },
    [ConversationTopModal.TrustedConnectionRequest] = {
        onActivatedOverlayVariant = ConversationOverlay.TrustedConnectionRequestU18
    }
}

local tbl2 = {
    actionText = "PLACEHOLDER Action",
    bodyText = "PLACEHOLDER Body",
    onDismissed = function() end
}

return React.memo(function(tbl3) -- name: ConversationBannerContainer
    local var1 = Cryo.Dictionary.union(tbl2, tbl3)
    local var2 = useNavigation()
    local var3 = tbl1[var1.modalVariant]
    local var4 = nil
    local var5 = useTelemetry(ChatConversationTelemetryLayer.Context)
    local var6 = useGetConversationFromId(var1.conversationId)
    if var6 and var6.participants then
        var4 = table.concat(var6.participants, ",")
    end
    local userId = useGetOneToOneFriendIdFromConversationId(var1.conversationId)
    React.useEffect(function()
        var5.emit(ConversationTopModalTelemetry.Events.ModalRendered, { modalVariant = var1.modalVariant, modalContext = var4 })
    end, { var1.modalVariant })

    local onDismissed = React.useCallback(function()
        var1.onDismissed()
        var5.emit(
            ConversationTopModalTelemetry.Events.ModalAction,
            {
                modalVariant = var1.modalVariant,
                action = ModalTelemetry.Enums.ModalActions.Dismiss,
                modalContext = var4
            }
        )
    end, { var1.onDismissed })

    local onActivated = React.useCallback(function()
        if var3 then
            var2.navigate(EnumScreens.TrustedConnectionsUpsell, {
                userId = userId,
                modalVariant = var3.onActivatedOverlayVariant,
                conversationId = var1.conversationId,
                isOverlay = true
            })
        end

        var5.emit(
            ConversationTopModalTelemetry.Events.ModalAction,
            {
                modalVariant = var1.modalVariant,
                action = ModalTelemetry.Enums.ModalActions.PrimaryCta,
                modalContext = var4
            }
        )
    end, { var2, var3, userId })

    if not var3 then
        return nil
    end

    return React.createElement(ConversationBanner, {
        actionText = var1.actionText,
        bodyText = var1.bodyText,
        onDismissed = onDismissed,
        onActivated = onActivated,
        layoutOrder = var1.layoutOrder
    })
end)

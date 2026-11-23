-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local var1 = require(AppChat.Logger):new(script.Name)

local EnumScreens = require(AppChat.EnumScreens)
local useNavigation = require(AppChatParent.Navigation).useNavigation

local TrustedFriendsUpsellContainer = require(script.Parent.TrustedFriendsUpsellContainer)

return function(_)
    local var2 = useNavigation()
    local userId = var2 and var2.getParam("userId", nil)
    local conversationId = var2 and var2.getParam("conversationId", nil)
    local param3 = var2 and var2.getParam("modalVariant", nil)
    local source = var2 and var2.getParam("source", nil)
    local modalVariantOverride = var2 and var2.getParam("modalVariantOverride", nil)
    local onRequestSent = var2 and var2.getParam("onRequestSent", nil)
    local onRequestAccepted = var2 and var2.getParam("onRequestAccepted", nil)
    local onAcknowledged = var2 and var2.getParam("onAcknowledged", nil)

    local dismissModal = React.useCallback(function()
        if var2 and var2.state.routeName == EnumScreens.TrustedConnectionsUpsell then
            var2.goBack(var2.state.key)
        end
    end, { var2 })

    if not userId then
        var1:error(
            "TrustedFriendsUpsellScreen: Missing required userId param",
            { conversationId = conversationId, modalVariant = param3 }
        )
        if var2 then
            var2.goBack()
        end
        return nil
    end

    return React.createElement(TrustedFriendsUpsellContainer, {
        userId = userId,
        dismissModal = dismissModal,
        source = source,
        conversationId = conversationId,
        analyticsModalVariant = param3,
        modalVariantOverride = modalVariantOverride,
        onRequestSent = onRequestSent,
        onRequestAccepted = onRequestAccepted,
        onAcknowledged = onAcknowledged
    })
end

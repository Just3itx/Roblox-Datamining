-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)

local EnumScreens = require(AppChat.EnumScreens)
local useNavigation = require(AppChatParent.Navigation).useNavigation

local ConversationOverlayContainer = require(script.Parent.ConversationOverlayContainer)

return function(_)
    local var1 = useNavigation()
    local conversationId = var1 and var1.getParam("conversationId", nil)
    local dismissModal = React.useCallback(function()
        if var1 and var1.state.routeName == EnumScreens.ConversationOverlay then
            var1.goBack(var1.state.key)
        end
    end, { var1 })

    return React.createElement(ConversationOverlayContainer, { conversationId = conversationId, dismissModal = dismissModal })
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactNavigation = require(AppChatParent.RoactNavigation)

local EnumScreens = require(AppChat.EnumScreens)

return function(arg1, conversationId: string, extraParams)
    arg1.reset({ RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatLanding }), RoactNavigation.Actions.navigate(
            {
                routeName = EnumScreens.ChatConversation,
                params = { conversationId = conversationId }
            }
        ), RoactNavigation.Actions.navigate(
            {
                routeName = EnumScreens.SquadLobby,
                params = { conversationId = conversationId, extraParams = extraParams }
            }
        ) }, 3)
end

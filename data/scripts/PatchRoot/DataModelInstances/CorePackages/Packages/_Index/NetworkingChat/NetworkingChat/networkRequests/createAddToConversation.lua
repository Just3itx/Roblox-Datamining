-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _networkingChatTypes = require(scriptParentParent.networkingChatTypes)
local CHAT_URL = require(scriptParentParent.CHAT_URL)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "AddToConversation" }, function(arg2, participantUserIds, conversationId)
        return arg2(CHAT_URL):path("v2"):path("add-to-conversation"):body(
            { participantUserIds = participantUserIds, conversationId = conversationId }
        ):setStatusIds(
            { conversationId }
        )
    end)
end

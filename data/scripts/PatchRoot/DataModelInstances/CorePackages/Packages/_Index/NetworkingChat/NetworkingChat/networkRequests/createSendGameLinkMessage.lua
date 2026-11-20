-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _networkingChatTypes = require(scriptParentParent.networkingChatTypes)
local CHAT_URL = require(scriptParentParent.CHAT_URL)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "SendGameLinkMessage" }, function(arg2, universeId, conversationId, decorators)
        return arg2(CHAT_URL):path("v2"):path("send-game-link-message"):body(
            { universeId = universeId, conversationId = conversationId, decorators = decorators }
        ):setStatusIds(
            { conversationId }
        )
    end)
end

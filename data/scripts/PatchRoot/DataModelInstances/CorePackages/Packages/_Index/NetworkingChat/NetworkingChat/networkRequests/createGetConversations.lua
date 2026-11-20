-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _networkingChatTypes = require(scriptParentParent.networkingChatTypes)
local CHAT_URL = require(scriptParentParent.CHAT_URL)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetConversations" }, function(arg2, arg3)
        return arg2(CHAT_URL):path("v2"):path("get-conversations"):expandedQueryArgsWithIds("conversationIds", arg3)
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParentParent = script.Parent.Parent.Parent
local Url = require(scriptParentParentParent.Network.Url)

return function(arg1, conversationId, universeId, decorators)
    assert(arg1, "requestImpl is required")
    assert(conversationId, "conversationId is required")
    assert(universeId, "universeId is required")

    local postBody = HttpService:JSONEncode({ conversationId = conversationId, universeId = universeId, decorators = decorators })

    return arg1(string.format("%s/send-game-link-message", Url.CHAT_URL), "POST", { postBody = postBody })
end

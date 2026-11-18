-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Http = script:FindFirstAncestor("Http")
local Url = require(Http.Url)
local _RequestTypes = require(Http.RequestTypes)

return function(arg1, conversationId, universeId, decorators, isExperienceInvite: boolean?, userId: number?, placeId: number?)
    assert(arg1, "requestImpl is required")
    assert(conversationId, "conversationId is required")
    assert(universeId, "universeId is required")

    local postBody = HttpService:JSONEncode({
        conversationId = conversationId,
        universeId = universeId,
        decorators = decorators,
        isExperienceInvite = isExperienceInvite,
        userId = userId,
        placeId = placeId
    })
    return arg1(string.format("%s/send-game-link-message", Url.CHAT_URL), "POST", { postBody = postBody })
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Http = script:FindFirstAncestor("Http")
local Url = require(Http.Url)
local _RequestTypes = require(Http.RequestTypes)

return function(arg1, conversationId, message, decorators, isExperienceInvite: boolean?, userId: number?)
    local postBody = HttpService:JSONEncode({
        conversationId = conversationId,
        message = message,
        decorators = decorators,
        isExperienceInvite = isExperienceInvite,
        userId = userId
    })

    return arg1(string.format("%s/send-message", Url.CHAT_URL), "POST", { postBody = postBody })
end

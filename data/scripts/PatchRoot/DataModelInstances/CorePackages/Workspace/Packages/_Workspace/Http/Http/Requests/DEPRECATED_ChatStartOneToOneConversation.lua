-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Url = require(script.Parent.Parent.Url)

return function(arg1, participantuserId, _)
    local postBody = HttpService:JSONEncode({ participantuserId = participantuserId })

    return arg1(string.format("%s/start-one-to-one-conversation", Url.CHAT_URL), "POST", { postBody = postBody })
end

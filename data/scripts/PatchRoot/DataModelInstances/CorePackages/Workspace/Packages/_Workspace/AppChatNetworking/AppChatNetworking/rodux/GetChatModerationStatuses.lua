-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

return (require(script.Parent.RoduxNetworking).POST(script.Name, function(arg1, ids)
    local var1 = arg1(CHAT_PLATFORM_BASE_URL):path("v1"):path("get-chat-moderation-statuses"):body({ ids = ids or {} })

    if ids and #ids > 0 then
        var1 = var1:setStatusIds(ids)
    end
    return var1
end))

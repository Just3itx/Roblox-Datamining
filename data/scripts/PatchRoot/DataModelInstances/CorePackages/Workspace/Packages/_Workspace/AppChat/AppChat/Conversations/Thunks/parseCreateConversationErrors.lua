-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function parseCreateConversationErrors(arg1)
    if arg1.StatusCode == 403 then
        local success, result = pcall(function()
            return HttpService:JSONDecode(arg1.Body)
        end)

        if success and result and result.reason_code == "participant_chat_disabled" then
            return "participant_chat_disabled"
        end
    end

    return "unknown"
end

return parseCreateConversationErrors

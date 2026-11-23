-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local var1 = require(AppChat.Logger):new(script.Name)

local seedConversationTopModalSduiPayload = require(script.Parent.seedConversationTopModalSduiPayload)

local function seedConversationTopModalFromRequest(arg1, str1: string)
    return arg1:andThen(function(arg2)
        local responseBody = arg2 and arg2.responseBody

        local success, result = pcall(seedConversationTopModalSduiPayload, responseBody and responseBody.sdui, str1)
        if not success then
            var1:warning(`Error seeding conversationTopModal SDUI payload: {tostring(result)}`)
        end
        return arg2
    end)
end

return seedConversationTopModalFromRequest

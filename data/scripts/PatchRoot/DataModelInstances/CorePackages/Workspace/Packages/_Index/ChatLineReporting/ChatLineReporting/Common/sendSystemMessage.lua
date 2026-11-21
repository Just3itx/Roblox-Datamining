-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local TextChatService = game:GetService("TextChatService")

local Constants = require(ChatLineReporting.Common.Constants)

local function findTextChannel(name: string): Instance?
    local var1 = TextChatService:FindFirstChild(name, true)
    while not var1 do
        wait()
        var1 = TextChatService:FindFirstChild(name, true)
    end
    return var1
end

function sendSystemMessage(systemMessage: string)
    if systemMessage then
        findTextChannel(Constants.ChannelTypes.System):DisplaySystemMessage(systemMessage)
    end
end

return sendSystemMessage

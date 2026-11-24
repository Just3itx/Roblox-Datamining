-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
local List = require(ExpChatSharedParent.llama).List

local function getNumberOfParticipants(arg1)
    return List.count(arg1:GetChildren(), function(arg2)
        return arg2:IsA("TextSource")
    end)
end

return getNumberOfParticipants

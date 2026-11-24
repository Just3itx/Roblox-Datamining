-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local List = require(ExpChatParent.llama).List

return function(arg1)
    return List.sort(arg1)
end

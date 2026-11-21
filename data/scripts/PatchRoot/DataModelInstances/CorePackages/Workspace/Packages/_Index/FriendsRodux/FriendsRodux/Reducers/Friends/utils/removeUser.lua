-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local llama = require(FriendsRoduxParent.llama)

return function(arg1, arg2)
    return llama.List.removeValue(arg1 or {}, arg2)
end

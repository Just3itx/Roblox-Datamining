-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
local llama = require(RoduxFriendsParent.llama)

return function(arg1, arg2)
    return llama.List.removeValue(arg1 or {}, arg2)
end

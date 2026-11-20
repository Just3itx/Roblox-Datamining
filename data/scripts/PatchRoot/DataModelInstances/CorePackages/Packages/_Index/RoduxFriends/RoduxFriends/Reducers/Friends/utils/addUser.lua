-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
local llama = require(RoduxFriendsParent.llama)

return function(arg1, arg2)
    if not arg1 then
        return { arg2 }
    elseif not llama.List.find(arg1, arg2) then
        return llama.List.join(arg1, { arg2 })
    end

    return arg1
end

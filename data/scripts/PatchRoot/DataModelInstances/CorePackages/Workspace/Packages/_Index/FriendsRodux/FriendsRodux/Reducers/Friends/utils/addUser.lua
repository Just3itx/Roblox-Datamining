-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local llama = require(FriendsRoduxParent.llama)

return function(arg1, arg2)
    if not arg1 then
        return { arg2 }
    elseif not llama.List.find(arg1, arg2) then
        return llama.List.join(arg1, { arg2 })
    end

    return arg1
end

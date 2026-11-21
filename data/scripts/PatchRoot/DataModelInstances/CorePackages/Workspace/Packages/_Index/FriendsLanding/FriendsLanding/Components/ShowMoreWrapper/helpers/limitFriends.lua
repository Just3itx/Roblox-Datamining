-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local llama = dependencies.llama
local t = dependencies.t

return function(arg1, arg2)
    assert(t.table(arg2))
    assert(t.number(arg1))

    return llama.List.filter(arg2, function(_, arg3): boolean
        return arg3 <= arg1
    end)
end

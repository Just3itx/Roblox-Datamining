-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local t = dependencies.t
local llama = dependencies.llama

local friendsPerLoadGroup = require(script.Parent.friendsPerLoadGroup)

local var1 = t.interface({ visibleRows = t.number, itemSize = t.number, filter = t.string })

local var2 = t.interface({ width = t.number, filterFriendCounts = t.table })

return function(arg1, arg2)
    assert(var2(arg1))
    assert(var1(arg2))

    local var3 = friendsPerLoadGroup(arg1, arg2)
    local var4 = arg1.filterFriendCounts[arg2.filter] + var3
    local tbl1 = {
        filterFriendCounts = llama.Dictionary.join(arg1.filterFriendCounts, { [arg2.filter] = var4 })
    }
    return tbl1
end

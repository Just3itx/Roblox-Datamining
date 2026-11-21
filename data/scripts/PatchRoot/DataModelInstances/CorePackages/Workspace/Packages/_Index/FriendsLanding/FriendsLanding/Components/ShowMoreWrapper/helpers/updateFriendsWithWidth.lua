-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local t = dependencies.t
local Dictionary = dependencies.llama.Dictionary

local friendsPerLoadGroup = require(script.Parent.friendsPerLoadGroup)

local var1 = t.interface({ visibleRows = t.number, itemSize = t.number, filter = t.string })

local var2 = t.interface({ filterFriendCounts = t.table })

return function(width)
    return function(arg1, arg2)
        assert(var1(arg2))
        assert(var2(arg1))

        local var3 = friendsPerLoadGroup({ width = width }, arg2)

        return {
            width = width,
            filterFriendCounts = Dictionary.join(arg1.filterFriendCounts, Dictionary.map(arg1.filterFriendCounts, function(arg3): number
                return math.max(var3, arg3)
            end))
        }
    end
end

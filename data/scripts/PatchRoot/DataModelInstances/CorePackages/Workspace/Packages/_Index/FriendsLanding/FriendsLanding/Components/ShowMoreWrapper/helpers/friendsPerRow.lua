-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local t = require(FriendsLanding.dependencies).t

local var1 = t.interface({ width = t.number, itemSize = t.number, minimumItemsPerRow = t.optional(t.number) })

return function(arg1): number
    assert(var1(arg1))

    return math.max(math.floor(arg1.width / arg1.itemSize), arg1.minimumItemsPerRow or 2)
end

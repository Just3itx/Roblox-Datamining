-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local llama = dependencies.llama
local t = dependencies.t
local friendsPerRow = require(script.Parent.friendsPerRow)

local var1 = t.interface({ width = t.number })

local var2 = t.interface({ visibleRows = t.number, itemSize = t.number, minimumItemsPerRow = t.optional(t.number) })

return function(arg1, arg2)
    assert(var1(arg1))
    assert(var2(arg2))
    return arg2.visibleRows * friendsPerRow(llama.Dictionary.join({ width = arg1.width }, arg2))
end

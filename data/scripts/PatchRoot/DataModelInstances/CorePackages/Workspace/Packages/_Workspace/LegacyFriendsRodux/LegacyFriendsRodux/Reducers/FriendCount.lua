-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegacyFriendsRodux = script:FindFirstAncestor("LegacyFriendsRodux")
local SetFriendCount = require(LegacyFriendsRodux.Actions).SetFriendCount

return function(arg1, arg2)
    return arg2.type ~= SetFriendCount.name and (arg1 or 0) or arg2.count
end

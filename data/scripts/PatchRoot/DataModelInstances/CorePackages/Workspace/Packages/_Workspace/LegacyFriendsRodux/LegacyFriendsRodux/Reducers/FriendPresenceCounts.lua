-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegacyFriendsRodux = script:FindFirstAncestor("LegacyFriendsRodux")
local LegacyFriendsRoduxParent = LegacyFriendsRodux.Parent

local Cryo = require(LegacyFriendsRoduxParent.Cryo)
local UpdateFriendPresenceCounts = require(LegacyFriendsRodux.Actions).UpdateFriendPresenceCounts

return function(arg1, arg2)
    return arg2.type ~= UpdateFriendPresenceCounts.name and (arg1 or {}) or Cryo.Dictionary.join({}, arg2.presenceCounts)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local PresenceType = require(FriendsLanding.dependencies).RoduxPresence.Enums.PresenceType

return function(tbl1): boolean
    if not tbl1 then
        return false
    end
    assert(tbl1, "user modal must be non-nil")
    return not not (tbl1.userPresenceType == PresenceType.InGame and tbl1.lastLocation and tbl1.lastLocation ~= "")
end

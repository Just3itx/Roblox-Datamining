-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent
local Cryo = require(UserProfilesParent.Cryo)

return function(arg1, arg2)
    local where = Cryo.List.findWhere(arg1.userProfiles, function(arg3, _): boolean
        return arg3.id == tostring(arg2)
    end)

    return arg1.userProfiles[where] or {}
end

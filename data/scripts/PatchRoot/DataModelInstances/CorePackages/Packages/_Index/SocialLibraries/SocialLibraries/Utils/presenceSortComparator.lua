-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local UserModel = require(SocialLibraries.dependencies).UserModel

local tbl1 = {
    [UserModel.PresenceType.IN_GAME] = 3,
    [UserModel.PresenceType.ONLINE] = 2,
    [UserModel.PresenceType.IN_STUDIO] = 1,
    [UserModel.PresenceType.OFFLINE] = 0
}

return function(arg1, arg2): boolean
    arg1 = arg1 or {}
    arg2 = arg2 or {}

    local presence = arg1.presence
    local presence2 = arg2.presence

    if presence and presence2 and tbl1[presence] ~= tbl1[presence2] then
        return tbl1[presence] > tbl1[presence2]
    end

    return arg1.displayName < arg2.displayName
end

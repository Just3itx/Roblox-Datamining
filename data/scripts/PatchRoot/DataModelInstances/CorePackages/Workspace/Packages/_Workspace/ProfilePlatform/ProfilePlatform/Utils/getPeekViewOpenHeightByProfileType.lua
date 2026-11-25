-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)

return function(community)
    return if community == Enums.ProfileTypes.Community then Constants.COMMUNITY_PEEK_VIEW_OPEN_HEIGHT else Constants.USER_PEEK_VIEW_OPEN_HEIGHT
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent

local VerifiedBadges = require(UserProfilesParent.VerifiedBadges)

return function(str1: string, tbl1): string
    if tbl1.hasVerifiedBadge then
        return `{str1}{VerifiedBadges.emoji.verified}`
    elseif tbl1.hasPremiumMembership then
        return `{str1}{VerifiedBadges.emoji.premium}`
    end

    return str1
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local SharedFlags = require(UserLibParent.SharedFlags)

local getFFlagOverridePlayerVerifiedBadge = SharedFlags.getFFlagOverridePlayerVerifiedBadge
local getFStringWhitelistVerifiedUserId = SharedFlags.getFStringWhitelistVerifiedUserId

local function isPlayerVerified(tbl1)
    if getFFlagOverridePlayerVerifiedBadge() then
        return true
    end

    return tostring(tbl1.UserId) == getFStringWhitelistVerifiedUserId()
        or not (tbl1.HasVerifiedBadge == nil) and tbl1.HasVerifiedBadge
end

return isPlayerVerified

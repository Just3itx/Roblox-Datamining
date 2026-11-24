-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local getFFlagOverridePlayerVerifiedBadge = require(ExpChat.Flags.getFFlagOverridePlayerVerifiedBadge)
local getFStringWhitelistVerifiedUserId = require(ExpChat.Flags.getFStringWhitelistVerifiedUserId)

local function isPlayerVerified(arg1)
    if getFFlagOverridePlayerVerifiedBadge() then
        return true
    end

    return tostring(arg1.UserId) == getFStringWhitelistVerifiedUserId() or arg1.HasVerifiedBadge
end

return isPlayerVerified

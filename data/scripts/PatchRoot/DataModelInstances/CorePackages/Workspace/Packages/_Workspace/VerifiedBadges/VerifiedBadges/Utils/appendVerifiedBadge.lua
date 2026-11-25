-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadges = script:FindFirstAncestor("VerifiedBadges")

local constants = require(VerifiedBadges.constants)

local function appendVerifiedBadge(str1: string)
    return str1 .. constants.VERIFIED_EMOJI
end

return appendVerifiedBadge

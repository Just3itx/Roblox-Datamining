-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("OverridePlayerVerifiedBadge", false)

local function getFFlagOverridePlayerVerifiedBadge(): boolean
    return game:GetFastFlag("OverridePlayerVerifiedBadge")
end

return getFFlagOverridePlayerVerifiedBadge

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnablePartyVoiceOnlyForEligibleUsers", false)

return function(): boolean
    return game:GetFastFlag("EnablePartyVoiceOnlyForEligibleUsers")
end

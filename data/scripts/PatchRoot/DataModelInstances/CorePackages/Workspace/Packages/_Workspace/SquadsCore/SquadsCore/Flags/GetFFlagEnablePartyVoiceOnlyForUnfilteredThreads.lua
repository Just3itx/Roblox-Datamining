-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnablePartyVoiceOnlyForUnfilteredThreads", false)

return function(): boolean
    return game:GetFastFlag("EnablePartyVoiceOnlyForUnfilteredThreads")
end

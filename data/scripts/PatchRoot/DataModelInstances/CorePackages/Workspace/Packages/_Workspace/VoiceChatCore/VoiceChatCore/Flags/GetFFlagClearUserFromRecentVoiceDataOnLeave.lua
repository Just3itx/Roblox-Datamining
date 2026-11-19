-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:21:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("ClearUserFromRecentVoiceDataOnLeave", false)

return function(): boolean
    return game:GetFastFlag("ClearUserFromRecentVoiceDataOnLeave")
end

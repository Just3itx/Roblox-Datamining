-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableAutoLoginAfterRecovery", false)

return function(): boolean
    return game:GetFastFlag("EnableAutoLoginAfterRecovery")
end

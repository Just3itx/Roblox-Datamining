-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("AdConsentSkipOptOutAuthPublish", false)

return function(): boolean
    return game:GetFastFlag("AdConsentSkipOptOutAuthPublish")
end

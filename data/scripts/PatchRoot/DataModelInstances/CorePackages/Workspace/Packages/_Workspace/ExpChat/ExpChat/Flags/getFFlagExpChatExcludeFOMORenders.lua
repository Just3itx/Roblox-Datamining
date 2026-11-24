-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("ExpChatExcludeFOMORenders", false)

return function(): boolean
    return game:GetFastFlag("ExpChatExcludeFOMORenders")
end

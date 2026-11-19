-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:10:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("DebugUnfilteredThreads", false)

return function(): boolean
    return game:GetFastFlag("DebugUnfilteredThreads")
end

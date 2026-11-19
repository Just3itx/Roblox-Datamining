-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:21:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableReadAloudInUA2", false)

return function(): boolean
    return game:GetEngineFeature("EnableReadAloudSetting") and game:GetFastFlag("EnableReadAloudInUA2")
end

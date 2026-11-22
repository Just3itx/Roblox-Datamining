-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("MomentsCreationSaveDraft", false)

return function(): boolean
    return game:GetFastFlag("MomentsCreationSaveDraft") and game:GetEngineFeature("MomentsDraftStorageKey")
end

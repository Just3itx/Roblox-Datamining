-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("MomentsUseUploadPostAsync", false)

return function(): boolean
    return game:GetFastFlag("MomentsUseUploadPostAsync") and game:GetEngineFeature("PostUploadFormat")
end

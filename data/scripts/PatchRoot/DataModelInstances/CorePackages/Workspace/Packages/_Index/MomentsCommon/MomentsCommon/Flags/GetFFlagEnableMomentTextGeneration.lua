-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableMomentTextGeneration3", false)

return function(): boolean
    return game:GetFastFlag("EnableMomentTextGeneration3") and game:GetEngineFeature("CaptureServiceGenerateMomentText")
end

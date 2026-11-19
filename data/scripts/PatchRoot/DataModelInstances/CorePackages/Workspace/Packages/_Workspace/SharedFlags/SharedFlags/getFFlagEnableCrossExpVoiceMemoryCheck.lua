-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableCrossExpVoiceMemoryCheck", false)

return function(): boolean
    return game:GetEngineFeature("PerformanceControlService") and game:GetFastFlag("EnableCrossExpVoiceMemoryCheck")
end

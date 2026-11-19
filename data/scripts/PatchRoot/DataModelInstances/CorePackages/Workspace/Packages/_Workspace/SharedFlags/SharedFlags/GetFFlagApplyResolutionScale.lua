-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("ApplyResolutionScale", false)

return function(): boolean
    return game:GetFastFlag("ApplyResolutionScale") and game:GetEngineFeature("CanvasGroupCustomResolutionScale")
end

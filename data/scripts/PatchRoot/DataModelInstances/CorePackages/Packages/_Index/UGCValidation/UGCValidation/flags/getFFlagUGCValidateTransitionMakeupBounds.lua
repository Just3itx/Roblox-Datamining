-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("UGCValidateTransitionMakeupBounds", false)

return function(): boolean
    return game:GetEngineFeature("EngineUGCValidationUseFIntsInUVMinMaxBounds")
        and game:GetFastFlag("UGCValidateTransitionMakeupBounds")
end

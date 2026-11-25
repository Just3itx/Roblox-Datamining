-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableCreatorStorePurchasingCutover", false)

return function(): boolean
    return game:GetFastFlag("EnableCreatorStorePurchasingCutover") and game:GetEngineFeature("EnableCreatorStorePurchasing")
end

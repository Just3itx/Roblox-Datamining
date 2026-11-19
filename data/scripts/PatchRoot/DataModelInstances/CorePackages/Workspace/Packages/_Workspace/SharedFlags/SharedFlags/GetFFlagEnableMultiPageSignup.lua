-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:21:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableMultiPageSignup5", false)

return function(): boolean
    return game:GetFastFlag("EnableMultiPageSignup5") and game:GetEngineFeature("MultipageSignupMetadataMapKeyAvailable")
end

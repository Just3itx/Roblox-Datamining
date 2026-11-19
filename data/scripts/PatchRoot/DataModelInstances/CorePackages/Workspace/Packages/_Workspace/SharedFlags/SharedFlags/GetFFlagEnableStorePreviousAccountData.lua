-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableStorePreviousAccountData", false)

return function(): boolean
    return game:GetFastFlag("EnableStorePreviousAccountData") and game:GetEngineFeature("PreviousAccountsListAvailable")
end

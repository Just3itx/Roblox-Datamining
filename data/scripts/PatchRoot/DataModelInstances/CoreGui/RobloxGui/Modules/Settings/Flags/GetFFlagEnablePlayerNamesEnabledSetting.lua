-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnablePlayerNamesEnabledSetting", false)

return function(): boolean
    return game:GetEngineFeature("EnablePlayerNamesEnabledSettingEngineFeature")
        and game:GetFastFlag("EnablePlayerNamesEnabledSetting")
end

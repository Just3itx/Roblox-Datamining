-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:41:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LuaAppEnableOpenTypeSupport4", false)

return function(): boolean
    return game:GetEngineFeature("SupportOpenTypeFeatures") and game:GetFastFlag("LuaAppEnableOpenTypeSupport4")
end

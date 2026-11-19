-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LuaAppEnableOpenTypeSupport4", false)

return function(): boolean
    return game:GetEngineFeature("SupportOpenTypeFeatures") and game:GetFastFlag("LuaAppEnableOpenTypeSupport4")
end

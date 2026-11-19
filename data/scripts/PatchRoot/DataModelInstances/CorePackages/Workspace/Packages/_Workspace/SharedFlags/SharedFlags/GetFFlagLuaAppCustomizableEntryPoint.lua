-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LuaAppCustomizableEntryPoint2", false)

return function(): boolean
    return game:GetEngineFeature("CustomAppEntryPointAutoJoin") and game:GetFastFlag("LuaAppCustomizableEntryPoint2")
end

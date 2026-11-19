-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:41:20Z
-- Luau bytecode version: 9 | Luau type version: 3
local GetFFlagLuaAppEnableOpenTypeSupport = require(script.Parent.GetFFlagLuaAppEnableOpenTypeSupport)

return game:DefineFastFlag("FFlagEnableFontStylisticAlternativesOnSocialScreens", false)
    and GetFFlagLuaAppEnableOpenTypeSupport()

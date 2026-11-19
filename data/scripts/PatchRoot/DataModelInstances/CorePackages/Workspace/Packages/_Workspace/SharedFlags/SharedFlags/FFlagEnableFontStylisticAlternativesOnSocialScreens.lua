-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
local GetFFlagLuaAppEnableOpenTypeSupport = require(script.Parent.GetFFlagLuaAppEnableOpenTypeSupport)

return game:DefineFastFlag("FFlagEnableFontStylisticAlternativesOnSocialScreens", false)
    and GetFFlagLuaAppEnableOpenTypeSupport()

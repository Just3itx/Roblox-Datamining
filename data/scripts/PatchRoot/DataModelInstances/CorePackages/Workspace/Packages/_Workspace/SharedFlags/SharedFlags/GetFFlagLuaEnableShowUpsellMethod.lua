-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetFFlagLuaAppEnableAndroidPushUpsell = require(script.Parent.GetFFlagLuaAppEnableAndroidPushUpsell)

game:DefineFastFlag("LuaEnableShowUpsellMethod2", false)

return function(): boolean
    if GetFFlagLuaAppEnableAndroidPushUpsell() then
        return game:GetFastFlag("LuaEnableShowUpsellMethod2")
    end
    return game:GetFastFlag("LuaEnableShowUpsellMethod2")
        and game:GetEngineFeature("PermissionsProtocolShouldShowUpsellIOSEnabled")
end

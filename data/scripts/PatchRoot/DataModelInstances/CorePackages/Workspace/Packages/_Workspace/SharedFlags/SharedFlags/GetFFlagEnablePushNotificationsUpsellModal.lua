-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:21:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local GetFFlagLuaEnableShowUpsellMethod = require(script.Parent.GetFFlagLuaEnableShowUpsellMethod)
local GetFFlagLuaAppPushSystemUpsellDevOverride = require(script.Parent.GetFFlagLuaAppPushSystemUpsellDevOverride)

game:DefineFastFlag("EnablePushNotificationsUpsellModal6", false)
return function()
    return GetFFlagLuaEnableShowUpsellMethod() and game:GetFastFlag("EnablePushNotificationsUpsellModal6")
        or GetFFlagLuaAppPushSystemUpsellDevOverride()
end

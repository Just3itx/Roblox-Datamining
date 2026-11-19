-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:50:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local GetFFlagPackagifySettingsShowSignal = require(script.Parent.GetFFlagPackagifySettingsShowSignal)

game:DefineFastFlag("NotificationModalSetMenuIsOpen", false)

return function()
    return GetFFlagPackagifySettingsShowSignal() and game:GetFastFlag("NotificationModalSetMenuIsOpen")
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("EnableChatNewMessage", false)
local GetFFlagEnableAppChatInExperience = require(script.Parent.GetFFlagEnableAppChatInExperience)

return function()
    return bool1 and GetFFlagEnableAppChatInExperience()
end

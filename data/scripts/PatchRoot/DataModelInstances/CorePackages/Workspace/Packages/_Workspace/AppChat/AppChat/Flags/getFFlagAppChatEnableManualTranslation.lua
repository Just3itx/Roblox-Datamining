-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagAppChatEnableAutotranslation = require(script.Parent.FFlagAppChatEnableAutotranslation)

game:DefineFastFlag("AppChatEnableManualTranslation", false)

return function()
    return game:GetFastFlag("AppChatEnableManualTranslation") and FFlagAppChatEnableAutotranslation
end

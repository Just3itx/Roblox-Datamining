-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local GetFFlagEnableAppChatInExperience = require(script.Parent.GetFFlagEnableAppChatInExperience)

return game:DefineFastFlag("ExpChatCanShowFriendsTabRC1", false) and GetFFlagEnableAppChatInExperience()

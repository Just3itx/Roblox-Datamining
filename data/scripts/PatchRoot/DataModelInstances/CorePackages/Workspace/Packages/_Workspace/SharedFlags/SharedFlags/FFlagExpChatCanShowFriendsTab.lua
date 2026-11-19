-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:11:14Z
-- Luau bytecode version: 9 | Luau type version: 3
local GetFFlagEnableAppChatInExperience = require(script.Parent.GetFFlagEnableAppChatInExperience)
local FFlagExpChatEnableFriendsTab = require(script.Parent.FFlagExpChatEnableFriendsTab)

return game:DefineFastFlag("ExpChatCanShowFriendsTabRC1", false)
    and GetFFlagEnableAppChatInExperience()
    and FFlagExpChatEnableFriendsTab

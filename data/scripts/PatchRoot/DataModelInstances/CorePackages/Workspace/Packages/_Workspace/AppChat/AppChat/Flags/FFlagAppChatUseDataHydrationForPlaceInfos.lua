-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local FFlagShareTargetGameCleanup = require(AppChatParent.SharedFlags).FFlagShareTargetGameCleanup

return game:DefineFastFlag("AppChatUseDataHydrationForPlaceInfos", false) and FFlagShareTargetGameCleanup

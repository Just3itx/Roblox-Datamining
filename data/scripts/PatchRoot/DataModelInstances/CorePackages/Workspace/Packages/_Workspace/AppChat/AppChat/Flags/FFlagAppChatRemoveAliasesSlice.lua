-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local FFlagShareTargetGameCleanup = require(AppChatParent.SharedFlags).FFlagShareTargetGameCleanup

return game:DefineFastFlag("AppChatRemoveAliasesSlice", false) and FFlagShareTargetGameCleanup

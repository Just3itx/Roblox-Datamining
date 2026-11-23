-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

return require(AppChatParent.LuaSocialLibrariesDeps).RoduxPresence.config({ keyPath = "ChatAppReducer.Presence" })

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")

return game:DefineFastFlag("AppChatWideAlwaysVisibleSearchBoxV1", false)
    and require(AppChat.Flags.FFlagAppChatFoundationSearchInput)

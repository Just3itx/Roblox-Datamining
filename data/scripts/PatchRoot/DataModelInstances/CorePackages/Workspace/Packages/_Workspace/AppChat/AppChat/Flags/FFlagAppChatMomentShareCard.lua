-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")

local FFlagAppChatResolveShareLinkV2 = require(AppChat.Flags.FFlagAppChatResolveShareLinkV2)

return game:DefineFastFlag("AppChatMomentShareCard", false) and FFlagAppChatResolveShareLinkV2

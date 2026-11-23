-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local Signals = require(AppChatParent.Signals)

local createReplyingToStore = require(script.createReplyingToStore)

return Signals.createComputed(createReplyingToStore)

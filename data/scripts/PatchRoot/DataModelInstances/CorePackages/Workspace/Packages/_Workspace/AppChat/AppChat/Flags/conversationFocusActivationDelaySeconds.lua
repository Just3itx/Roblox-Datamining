-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAppChatDebounceConversationFocusActivation = require(script.Parent.FFlagAppChatDebounceConversationFocusActivation)

local FIntAppChatConversationFocusActivationDelayMs = require(script.Parent.FIntAppChatConversationFocusActivationDelayMs)

return if FFlagAppChatDebounceConversationFocusActivation then FIntAppChatConversationFocusActivationDelayMs / 1000 else nil

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)

local Constants = require(script.Parent.Constants)
local _PlatformChatConversationTypes = require(script.Parent.PlatformChatConversationTypes)

local function useRealtimePlatformChatConversation(func1: (...any) -> (...any), tbl1)
    RealtimeDelivery.useRealtimeNamespace(Constants.PlatformChatConversation.Namespace, func1, tbl1)
end

return useRealtimePlatformChatConversation

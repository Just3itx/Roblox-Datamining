-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)
local _serializeChatTimeoutRange = require(AppChat.Utils.serializeChatTimeoutRange)

local function toTimeoutEntry(arg1)
    if arg1 == nil or arg1.status ~= "active" then
        return nil
    end

    return {
        endTimestamp = arg1.endTimestamp,
        decisionEventId = arg1.decisionEventId,
        duration = arg1.duration,
        requiresAcknowledgement = arg1.requiresAcknowledgement
    }
end

return toTimeoutEntry

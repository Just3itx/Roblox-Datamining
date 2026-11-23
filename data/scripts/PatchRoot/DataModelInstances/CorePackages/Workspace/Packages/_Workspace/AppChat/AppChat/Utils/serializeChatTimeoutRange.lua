-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local function serializeChatTimeoutRange(arg1, num1: number?)
    local dateTime = DateTime.now()
    local unixTimestamp = (DateTime.fromIsoDate(arg1.start_time) or dateTime).UnixTimestamp
    local unixTimestamp2 = (DateTime.fromIsoDate(arg1.end_time) or dateTime).UnixTimestamp

    return {
        endTimestamp = math.clamp((num1 or dateTime.UnixTimestamp) + arg1.time_remaining, -17987443200, 253402300799),
        decisionEventId = arg1.decision_event_id,
        duration = math.clamp(unixTimestamp2 - unixTimestamp, 0, 253402300799),
        requiresAcknowledgement = if FFlagAppChatReactiveFeatureRestrictions then arg1.requires_acknowledgement == true else nil
    }
end

return serializeChatTimeoutRange

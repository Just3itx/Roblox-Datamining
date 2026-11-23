-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ConversationChannels = require(AppChat.Models.ConversationChannels)
local _serializeChatTimeoutRange = require(script.Parent.serializeChatTimeoutRange)

local FFlagAppChatEnforceTimeoutsOnUnfilteredChat = require(AppChat.Flags.FFlagAppChatEnforceTimeoutsOnUnfilteredChat)
local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local function getEffectiveChatTimeoutDetails(arg1, arg2, trustedComms, num1: number?)
    local num2 = num1 or DateTime.now().UnixTimestamp
    local var1 = if arg1 and arg1.endTimestamp then arg1.endTimestamp else 0
    local var2 = if arg2 and arg2.endTimestamp then arg2.endTimestamp else 0

    local bool1 = FFlagAppChatReactiveFeatureRestrictions

    if bool1 then
        if arg1 == nil then
            bool1 = false
        else
            bool1 = arg1.requiresAcknowledgement == true
        end
    end

    local bool2 = FFlagAppChatReactiveFeatureRestrictions

    if bool2 then
        if arg2 == nil then
            bool2 = false
        else
            bool2 = arg2.requiresAcknowledgement == true
        end
    end

    local var3 = bool1 or bool2
    if not (var1 < var2) then
        arg2 = arg1
    end

    local timeoutEndTimestamp = math.max(var1, var2)

    local bool3 = num2 < timeoutEndTimestamp or var3
    if not FFlagAppChatEnforceTimeoutsOnUnfilteredChat and bool3 then
        bool3 = trustedComms ~= ConversationChannels.ModerationType.TrustedComms
    end
    local tbl1 = {
        isTimedOut = bool3,
        timeoutEndTimestamp = timeoutEndTimestamp,
        decisionEventId = if arg2 then arg2.decisionEventId else nil,
        duration = if arg2 then arg2.duration else nil,
        requiresAcknowledgement = 0
    }

    if not FFlagAppChatReactiveFeatureRestrictions then
        var3 = nil
    end

    tbl1.requiresAcknowledgement = var3
    return tbl1
end

return getEffectiveChatTimeoutDetails

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local _Signals = require(AppChatParent.Signals)

local GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)
local getEffectiveChatTimeoutDetails = require(AppChat.Utils.getEffectiveChatTimeoutDetails)
local toTimeoutEntry = require(AppChat.Utils.toTimeoutEntry)

local function getUserSendEligibilityStatus(tbl1): string
    if not tbl1.isAvailable then
        return "ineligible"
    end

    local var1 = GetChatModerationStatusDataHydration().getUserStatus()
    local var2 = var1.status(tbl1.scope)

    if var2 == DataHydration.DataStatus.NotReady then
        return "loading"
    end

    if var2 == DataHydration.DataStatus.Failed
        or not getEffectiveChatTimeoutDetails(toTimeoutEntry(var1.data(tbl1.scope)), nil, nil, tbl1.currentTimestamp).isTimedOut
    then
        return "eligible"
    end

    return "ineligible"
end

return getUserSendEligibilityStatus

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local Enums = require(AppChat.MessageData.Enums)
local _Types = require(AppChat.AppChatData.Types)

local MessageStatus = Enums.MessageStatus
local MessageVisibility = Enums.MessageVisibility

local function getMessageState(tbl1)
    if tbl1.status == MessageStatus.Pending then
        return { deliveryState = "Pending", visibility = "Visible" }
    end

    if tbl1.status == MessageStatus.Failed then
        return { deliveryState = "Failed", visibility = "Visible" }
    end

    if tbl1.status == MessageStatus.Moderated then
        return { deliveryState = "Rejected", visibility = "Moderated" }
    end

    if tbl1.status == MessageStatus.Hidden or tbl1.visibility == MessageVisibility.Hidden then
        return { deliveryState = "Sent", visibility = "Hidden" }
    end

    return { deliveryState = "Sent", visibility = "Visible" }
end

return getMessageState

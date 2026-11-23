-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")

local _Types = require(UserList.Common.Types)
local telemetryEmitter = require(UserList.Analytics.telemetryEmitter)
local userListInteractionEvent = require(UserList.Analytics.userListInteractionEvent)

local function reportCtaActivated(arg1, buttonType, targetUserId: string, absolutePosition: number?)
    if arg1 == nil then
        return
    end

    local tbl1 = {
        eventContext = arg1.surface,
        eventName = "CtaActivated",
        subpage = arg1.subpage,
        buttonType = buttonType,
        targetUserId = targetUserId,
        absolutePosition = absolutePosition
    }

    pcall(telemetryEmitter.emit, userListInteractionEvent, tbl1)
end

return reportCtaActivated

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _TimeToInteractiveTracker = require(AppChatParent.TimeToInteractiveTracker)
local AppChatPerfEventInfo = require(AppChat.Telemetry.AppChatPerfEventInfo)
local AppChatTTITracker = require(AppChat.Telemetry.AppChatTTITracker)
local AppChatIntervalTracker = require(AppChat.Telemetry.AppChatIntervalTracker)

local module = {
    Events = AppChatPerfEventInfo.Events,
    Milestone = AppChatTTITracker.Milestone,
    Hooks = AppChatTTITracker.Hooks
}

function module.setSharedContext(tbl1)
    AppChatTTITracker.setSharedContext(tbl1)
end

function module.isActive(arg1, arg2)
    local var1 = arg2 or {}

    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.isActive(arg1, var1)
    end

    return AppChatIntervalTracker.isActive(arg1)
end

function module.start(arg1, arg2, arg3)
    local var1 = arg2 or {}
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.start(arg1, var1)
    end
    return AppChatIntervalTracker.start(arg1, var1, arg3)
end

function module.finish(arg1, arg2)
    local var1 = arg2 or {}
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.finish(arg1, var1)
    end
    return AppChatIntervalTracker.finish(arg1)
end

function module.getEventName(arg1)
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.getEventName(arg1)
    end
    return nil
end

function module.trackMilestone(arg1, arg2, arg3)
    local var1 = arg3 or {}
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.trackMilestone(arg1, arg2, var1)
    end
    return false
end

function module.trackSubphase(arg1, arg2, arg3, arg4)
    local var1 = arg4 or {}
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.trackSubphase(arg1, arg2, arg3, var1)
    end
    return false
end

function module.trackRequest(arg1, arg2, str1: string, arg3)
    local var1 = arg3 or {}
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.trackRequest(arg1, arg2, str1, var1)
    end
    return false
end

function module.cancel(arg1, arg2)
    local var1 = arg2 or {}
    if AppChatPerfEventInfo.isTTIEvent(arg1) then
        return AppChatTTITracker.cancel(arg1, var1)
    end
    return AppChatIntervalTracker.cancel(arg1)
end

return module

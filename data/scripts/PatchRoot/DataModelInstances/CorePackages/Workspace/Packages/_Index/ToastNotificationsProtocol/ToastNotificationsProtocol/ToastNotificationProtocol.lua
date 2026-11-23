-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MessageBusService = game:GetService("MessageBusService")

local Players = game:GetService("Players")
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local _ToastNotificationProtocolTypes = require(scriptParent.ToastNotificationProtocolTypes)
local ToastNotificationProtocolConstants = require(scriptParent.ToastNotificationProtocolConstants)
local getPlatformTarget = require(scriptParentParent.Analytics).getPlatformTarget

local module = ({})
module.__index = module

game:DefineFastFlag("LuaAppInitializeToastNotificationEventParams2", false)

function module.new()
    return (setmetatable({}, module))
end

function module.setupNotifications(_, channels)
    if not (#channels > 0) then
        return
    end

    local platformTarget, var1

    if game:GetFastFlag("LuaAppInitializeToastNotificationEventParams2") then
        platformTarget = getPlatformTarget()
        if Players.LocalPlayer then
            var1 = tostring(Players.LocalPlayer.UserId)
        else
            var1 = ""
        end
    else
        var1 = nil
        platformTarget = nil
    end

    MessageBusService:Publish(
        ToastNotificationProtocolConstants.MESSAGE_INIT_TOAST_NOTIF,
        { channels = channels, userId = var1, platform = platformTarget }
    )
end

function module.updateNotification(_, notificationId: string, stateName: string)
    if notificationId and stateName then
        MessageBusService:Publish(
            ToastNotificationProtocolConstants.MESSAGE_UPDATE_TOAST_NOTIF,
            { notificationId = notificationId, stateName = stateName }
        )
    end
end

function module.voltronBroadcast(_, mid: string?, arg1)
    if mid then
        MessageBusService:Publish(mid, arg1)
    end
end

function module.dismissNotification(_, notificationId: string)
    if notificationId then
        MessageBusService:Publish(
            ToastNotificationProtocolConstants.MESSAGE_DISMISS_TOAST_NOTIF,
            { notificationId = notificationId }
        )
    end
end

function module.listenToDisplayNotification(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(ToastNotificationProtocolConstants.MESSAGE_DISPLAY_TOAST_NOTIF, callback, false, true)
end

function module.listenToDismissNotification(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(ToastNotificationProtocolConstants.MESSAGE_DISMISS_TOAST_NOTIF, callback, false, true)
end

module.default = module.new()

return module

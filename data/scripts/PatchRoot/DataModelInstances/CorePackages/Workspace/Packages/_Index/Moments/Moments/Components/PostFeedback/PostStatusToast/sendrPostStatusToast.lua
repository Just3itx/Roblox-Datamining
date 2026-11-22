-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local ToastNotificationsProtocol = require(MomentsParent.ToastNotificationsProtocol)

local Constants = require(Moments.Constants)

local default = ToastNotificationsProtocol.ToastNotificationProtocol.default

return {
    listen = function(callback: (...any) -> (...any))
        local var1 = default:listenToDisplayNotification(function(arg1)
            if type(arg1) ~= "table" then
                return
            end

            if arg1.notificationType == Constants.PostStatusToastNotificationType then
                callback(arg1)
            end
        end)
        return function()
            var1:Disconnect()
        end
    end,
    dismiss = function(tbl1)
        local notificationId = tbl1.notificationId
        if notificationId ~= nil then
            default:dismissNotification(notificationId)
        end
    end,
    isFailure = function(tbl1): boolean
        local content = tbl1.content
        local clientEventsPayload = if content ~= nil and content.clientEventsPayload ~= nil then content.clientEventsPayload else tbl1.clientEventsPayload
        return type(clientEventsPayload) == "table" and clientEventsPayload.status == "failure"
    end
}

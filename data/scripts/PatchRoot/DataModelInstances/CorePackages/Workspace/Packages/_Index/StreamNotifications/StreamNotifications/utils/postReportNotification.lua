-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local Promise = require(StreamNotificationsParent.Promise)

local HttpService = game:GetService("HttpService")
local Url = require(StreamNotificationsParent.Http).Url
local var1 = require(StreamNotificationsParent.UrlBuilder).UrlBuilder.new(
    {
        base = Url.APIS_URL,
        path = "notifications/v1/report-notification"
    }
)

return function(arg1, notificationId)
    if notificationId == nil or notificationId == "" then
        return Promise.reject()
    end

    return arg1(var1(), "POST", { postBody = HttpService:JSONEncode({ notificationId = notificationId }) }):andThen(function(arg2)
        if arg2.responseCode == 200 then
            return Promise.resolve()
        end
        return Promise.reject()
    end, function(_)
        return Promise.reject()
    end)
end

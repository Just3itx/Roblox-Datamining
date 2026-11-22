-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local Promise = require(StreamNotificationsParent.Promise)

local Url = require(StreamNotificationsParent.Http).Url
local var1 = require(StreamNotificationsParent.UrlBuilder).UrlBuilder.new(
    {
        base = Url.NOTIFICATION_URL,
        path = "v2/stream-notifications/action/{notificationId}/{actionPath}"
    }
)

return function(arg1, notificationId, actionPath)
    if notificationId == nil or notificationId == "" or actionPath == nil or actionPath == "" then
        return Promise.reject()
    end

    return arg1(var1({ notificationId = notificationId, actionPath = actionPath }), "POST", { postBody = "{}" }):andThen(
        function(arg2)
            if arg2.responseCode == 200 then
                return Promise.resolve()
            end
            return Promise.reject()
        end,
        function(_)
            return Promise.reject()
        end
    )
end

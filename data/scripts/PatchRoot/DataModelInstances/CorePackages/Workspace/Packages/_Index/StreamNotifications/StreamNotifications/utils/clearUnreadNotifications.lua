-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local Promise = require(StreamNotificationsParent.Promise)

local Url = require(StreamNotificationsParent.Http).Url
local var1 = require(StreamNotificationsParent.UrlBuilder).UrlBuilder.new(
    {
        base = Url.NOTIFICATION_URL,
        path = "v2/stream-notifications/clear-unread"
    }
)

return function(arg1)
    return arg1(var1(), "POST", { postBody = "{}" }):andThen(function(arg2)
        if arg2.responseCode == 200 then
            return Promise.resolve()
        end
        return Promise.reject()
    end, function(arg2)
        return Promise.reject(arg2)
    end)
end

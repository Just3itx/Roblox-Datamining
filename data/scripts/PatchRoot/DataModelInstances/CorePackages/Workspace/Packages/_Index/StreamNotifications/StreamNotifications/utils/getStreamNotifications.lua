-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local Promise = require(StreamNotificationsParent.Promise)

local Url = require(StreamNotificationsParent.Http).Url
local var1 = require(StreamNotificationsParent.UrlBuilder).UrlBuilder.new({
    base = Url.NOTIFICATION_URL,
    path = "v2/stream-notifications/get-recent",
    query = { maxRows = "{maxRows}", startIndex = "{startIndex}" }
})

return function(arg1, maxRows: number?, startIndex: number?)
    return arg1(var1({ maxRows = maxRows or 10, startIndex = startIndex or 0 }), "GET"):andThen(function(arg2)
        local responseBody = arg2.responseBody or nil
        if arg2.responseCode == 200 and responseBody ~= nil then
            return Promise.resolve(responseBody)
        end
        return Promise.reject()
    end, function(arg2)
        return Promise.reject(arg2)
    end)
end

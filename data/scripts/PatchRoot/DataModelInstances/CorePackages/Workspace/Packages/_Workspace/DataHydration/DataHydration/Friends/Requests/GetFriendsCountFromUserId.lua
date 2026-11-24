-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local Url = require(DataHydrationParent.Http).Url

local Friends = DataHydration.Friends
local myHttpRequest = require(Friends.Networking.myHttpRequest)

return function(arg1)
    if arg1 == nil or tostring(arg1) == "" then
        return Promise.reject("GetFriendsCountFromUserId called with nil userId")
    end

    local str1 = string.format("%s/users/%s/friends/count", Url.FRIEND_URL, tostring(arg1))

    return myHttpRequest(str1, "GET"):andThen(function(arg2)
        return if arg2 then arg2.responseBody else nil
    end)
end

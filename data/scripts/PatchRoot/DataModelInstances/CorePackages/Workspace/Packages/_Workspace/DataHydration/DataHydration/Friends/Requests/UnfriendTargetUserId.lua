-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local Friends = DataHydration.Friends
local myHttpRequest = require(Friends.Networking.myHttpRequest)
local normalizeFriendRequestError = require(Friends.Networking.normalizeFriendRequestError)

return function(arg1)
    local str1 = string.format("%s/users/%s/unfriend", Url.FRIEND_URL, tostring(arg1))
    return myHttpRequest(str1, "POST", { postBody = HttpService:JSONEncode({}) }):andThen(function()
        return nil
    end):catch(function(arg2)
        error(normalizeFriendRequestError(arg2))
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local Friends = DataHydration.Friends
local myHttpRequest = require(Friends.Networking.myHttpRequest)
local normalizeFriendRequestError = require(Friends.Networking.normalizeFriendRequestError)

local FFlagEnableFriendsStoreChallengeInterceptor = require(DataHydrationParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor

return function(arg1, arg2)
    return (FFlagEnableFriendsStoreChallengeInterceptor and arg2 or myHttpRequest)(
        string.format("%s/contacts/%s/request-friendship", Url.FRIEND_URL, tostring(arg1)),
        "POST",
        {
            postBody = HttpService:JSONEncode({})
        }
    ):andThen(
        function()
            return nil
        end
    ):catch(
        function(arg3)
            error(normalizeFriendRequestError(arg3))
        end
    )
end

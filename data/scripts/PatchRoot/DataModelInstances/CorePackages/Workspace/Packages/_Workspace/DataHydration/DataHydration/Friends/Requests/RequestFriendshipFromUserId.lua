-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local Friends = DataHydration.Friends
local myHttpRequest = require(Friends.Networking.myHttpRequest)

local FFlagEnableFriendsStoreChallengeInterceptor = require(DataHydrationParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor

return function(arg1, friendshipOriginSourceType: string?, arg2)
    return (FFlagEnableFriendsStoreChallengeInterceptor and arg2 or myHttpRequest)(
        string.format("%s/users/%s/request-friendship", Url.FRIEND_URL, tostring(arg1)),
        "POST",
        {
            postBody = HttpService:JSONEncode({ friendshipOriginSourceType = friendshipOriginSourceType })
        }
    ):andThen(
        function()
            return nil
        end
    ):catch(
        function(arg3)
            local statusCode = if type(arg3) == "table" then arg3.StatusCode else nil
            local code = nil
            local body = if type(arg3) == "table" then arg3.Body else nil

            if type(body) == "string" then
                local success, result = pcall(HttpService.JSONDecode, HttpService, body)
                if success and type(result) == "table" then
                    local errors = result.errors
                    if type(errors) == "table" and errors[1] then
                        code = errors[1].code
                    end
                end
            end
            error({ statusCode = statusCode, firstErrorCode = code })
        end
    )
end

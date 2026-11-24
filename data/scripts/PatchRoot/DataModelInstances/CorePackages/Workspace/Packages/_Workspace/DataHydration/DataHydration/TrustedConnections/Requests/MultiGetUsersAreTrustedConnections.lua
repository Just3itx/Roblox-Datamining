-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local TrustedConnections = DataHydration.TrustedConnections
local myHttpRequest = require(TrustedConnections.Networking.myHttpRequest)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

return function(arg1)
    local localPlayerUserId = getLocalPlayerUserId()
    local str1 = HttpService:UrlEncode(table.concat(arg1, ","))

    local str2 = string.format("%s/user/%s/multiget-are-trusted-friends?userids=%s", Url.FRIEND_URL, tostring(localPlayerUserId), str1)

    return myHttpRequest(str2, "GET"):andThen(function(arg2)
        return arg2 and arg2.responseBody and arg2.responseBody.trustedFriendsId
    end)
end

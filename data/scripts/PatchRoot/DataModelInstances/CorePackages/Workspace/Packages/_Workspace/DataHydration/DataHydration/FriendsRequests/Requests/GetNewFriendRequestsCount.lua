-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)

local _FriendsRequestsStoreTypes = require(script.Parent.Parent.FriendsRequestsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

return function()
    local var1 = fetch({
        method = "GET",
        url = `{Http.Url.FRIEND_URL}/my/new-friend-requests/count`,
        analyticsKey = "friends.get-new-friend-requests-count",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var1)
end

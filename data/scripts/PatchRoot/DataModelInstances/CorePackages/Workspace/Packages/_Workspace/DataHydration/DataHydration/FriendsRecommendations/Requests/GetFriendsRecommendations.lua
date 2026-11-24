-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)

local _FriendsRecommendationsStoreTypes = require(script.Parent.Parent.FriendsRecommendationsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

return function(str1: string, source: string?)
    local url = UrlBuilder.UrlBuilder.addQueryString(
        `{Http.Url.FRIEND_URL}/users/{str1}/friends/recommendations`,
        { source = source }
    )

    local var2 = fetch({
        method = "GET",
        url = url,
        analyticsKey = "friends.get-friend-recommendations",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

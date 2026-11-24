-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

return function(arg1, tbl1)
    if arg1 == nil or tostring(arg1) == "" then
        return Promise.reject("SearchFriendsByQuery called with nil userId")
    end

    local var1 = fetch({
        method = "GET",
        url = UrlBuilder.UrlBuilder.addQueryString(
            `{Http.Url.FRIEND_URL}/users/{arg1}/friends/search`,
            {
                query = tbl1.query,
                limit = tbl1.limit,
                cursor = tbl1.cursor
            }
        ),
        analyticsKey = "friends.search-friends",
        decode = function<T>(arg2: T): T
            return arg2
        end
    })
    return asPromise(var1)
end

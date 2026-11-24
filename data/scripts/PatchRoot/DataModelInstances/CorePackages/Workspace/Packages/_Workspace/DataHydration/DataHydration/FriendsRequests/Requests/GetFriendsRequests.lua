-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)

local _FriendsRequestsStoreTypes = require(script.Parent.Parent.FriendsRequestsStoreTypes)

local FFlagAddFriendsSessionId = require(DataHydrationParent.SharedFlags).FFlagAddFriendsSessionId
local FFlagFriendsRequestsRemoveRedundantParams = require(DataHydration.Flags.FFlagFriendsRequestsRemoveRedundantParams)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

return function(cursor: string?, limit: number?, sessionId: string?)
    local addQueryString = UrlBuilder.UrlBuilder.addQueryString
    local str2 = `{Http.Url.FRIEND_URL}/my/friends/requests`
    local tbl1 = {
        sortOrder = if FFlagFriendsRequestsRemoveRedundantParams then nil else "Desc",
        fetchMutualFriends = if FFlagFriendsRequestsRemoveRedundantParams then nil else "true",
        limit = limit,
        cursor = cursor,
        uprankUnseen = "true",
        sessionId = 0
    }
    if not FFlagAddFriendsSessionId then
        sessionId = nil
    end

    tbl1.sessionId = sessionId
    local url = addQueryString(str2, tbl1)

    local var2 = fetch({
        method = "GET",
        url = url,
        analyticsKey = "friends.get-friend-requests",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var2)
end

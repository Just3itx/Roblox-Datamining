-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)
local Url = require(DataHydrationParent.Http).Url
local FFlagFriendsSignalMigrationTelemetry = require(DataHydrationParent.SharedFlags).FFlagFriendsSignalMigrationTelemetry
local FFlagFriendsSkipInvalidUserIdFetches = require(DataHydration.Flags.FFlagFriendsSkipInvalidUserIdFetches)
local Friends = DataHydration.Friends
local isInvalidUserId = require(Friends.isInvalidUserId)
local myHttpRequest = require(Friends.Networking.myHttpRequest)
local FriendsRequestTelemetry = require(script.Parent.FriendsRequestTelemetry)

local function collectFriendIdsFromResponse(tbl1)
    local result = {}
    for _, value in tbl1 and tbl1.PageItems or {} do
        if value.id ~= nil then
            table.insert(result, tostring(value.id))
        end
    end
    return result
end

return function(arg1, tbl1)
    if FFlagFriendsSkipInvalidUserIdFetches then
        if isInvalidUserId(arg1) then
            return Promise.reject(`GetFindFriendsPage called with invalid userId: {arg1}`)
        end
    elseif arg1 == nil or tostring(arg1) == "" then
        return Promise.reject("GetFindFriendsPage called with nil userId")
    end

    local limit = tbl1.limit
    local str1 = string.format("%s/users/%s/friends/find?limit=%d", Url.FRIEND_URL, tostring(arg1), limit)

    local cursor = tbl1.cursor
    if cursor and cursor ~= "" then
        str1 = string.format("%s&cursor=%s", str1, HttpService:UrlEncode(cursor))
    end

    local sort = tbl1.sort
    if sort ~= nil then
        str1 = string.format("%s&userSort=%d", str1, sort)
    end

    local var1 = if FFlagFriendsSignalMigrationTelemetry then FriendsRequestTelemetry.generateRequestId() else nil
    local requestOptions = if FFlagFriendsSignalMigrationTelemetry then FriendsRequestTelemetry.getRequestOptions(var1) else nil

    return myHttpRequest(str1, "GET", requestOptions):andThen(function(arg2)
        local responseBody = if arg2 then arg2.responseBody else nil

        if FFlagFriendsSignalMigrationTelemetry and var1 and responseBody then
            FriendsRequestTelemetry.emitFindFriendsResponse(var1, (collectFriendIdsFromResponse(responseBody)))
        end
        return responseBody
    end)
end

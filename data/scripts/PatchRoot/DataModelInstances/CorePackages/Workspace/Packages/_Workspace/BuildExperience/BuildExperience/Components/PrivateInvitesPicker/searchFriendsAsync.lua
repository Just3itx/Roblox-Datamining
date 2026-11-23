-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local HttpClient = require(BuildExperienceParent.HttpClient)
local Promise = require(BuildExperienceParent.Promise)
local UrlBase = require(BuildExperienceParent.UrlBuilder).UrlBase

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function searchFriendsAsync(input: string, input2: string?, num1: number?, num2: number?)
    if num2 == nil then
        local localPlayer = Players.LocalPlayer
        if localPlayer == nil then
            return Promise.reject("searchFriendsAsync: no local player")
        end
        num2 = localPlayer.UserId
    end

    local str1 = string.format(
        "%s/users/%d/friends/search?query=%s&limit=%d",
        UrlBase.FRIENDS,
        num2,
        HttpService:UrlEncode(input),
        num1 or 20
    )
    if input2 ~= nil and input2 ~= "" then
        str1 = string.format("%s&cursor=%s", str1, HttpService:UrlEncode(input2))
    end

    local var1 = fetch({
        method = "GET",
        url = str1,
        analyticsKey = "build-experience.friends-search",
        decode = function<T>(arg1: T): T
            return arg1
        end
    })

    return asPromise(var1):andThen(function(tbl1)
        local ids = {}
        for _, value in not tbl1 and {} or tbl1.PageItems or {} do
            local var2 = if value.id == nil then nil else tonumber(value.id)

            if var2 ~= nil then
                table.insert(ids, var2)
            end
        end
        local nextCursor = tbl1 and tbl1.NextCursor
        if nextCursor == "" then
            nextCursor = nil
        end

        return { ids = ids, nextCursor = nextCursor }
    end)
end

return searchFriendsAsync

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local UrlBuilder = require(SquadsCoreParent.UrlBuilder)

local Logger = require(SquadsCore.Logger)
local serializeTable = require(SquadsCore.Utils.serializeTable)
local SquadLuckyRecommendationError = require(SquadsCore.Enums.SquadLuckyRecommendationError)
local _Types = require(SquadsCore.Types)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

return function(pickRequestId: string, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local url = UrlBuilder2.new(
        {
            base = UrlBase.APIS,
            path = "group-up/v1/get-lucky-recommendation",
            query = { pickRequestId = pickRequestId }
        }
    )()

    local var2 = HttpService:RequestInternal(
        {
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            Method = "GET",
            Url = url
        }
    )
    local bool1 = false

    var2:Start(function(_, arg1)
        if bool1 then
            return
        end

        if arg1 == nil or arg1.StatusCode ~= 200 then
            local statusCode = if arg1 == nil then nil else arg1.StatusCode

            if callback2 then
                callback2(
                    if statusCode == 404 then SquadLuckyRecommendationError.NoRecommendations else SquadLuckyRecommendationError.Failed
                )
            end

            Logger:error("Error getting lucky recommendation: {}", if arg1 == nil then "request aborted" else arg1.StatusMessage)
            return
        end

        local recommendations = HttpService:JSONDecode(arg1.Body).recommendations
        local recommendation = if recommendations then recommendations[1] else nil
        Logger:debug("Response: {}", serializeTable(arg1.Body))

        if recommendation == nil then
            if callback2 then
                callback2(SquadLuckyRecommendationError.NoRecommendations)
            end

            return
        end
        if not callback then
            return
        end

        callback({
            universeId = recommendation.universeId,
            rootPlaceId = recommendation.rootPlaceId,
            universeName = recommendation.universeName
        })
    end)

    return function()
        bool1 = true
        var2:Cancel()
    end
end

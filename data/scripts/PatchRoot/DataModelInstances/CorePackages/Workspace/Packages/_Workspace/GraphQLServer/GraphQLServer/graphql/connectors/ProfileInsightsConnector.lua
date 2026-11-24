-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local HttpService = game:GetService("HttpService")

local UrlBuilder = require(GraphQLServerParent.UrlBuilder).UrlBuilder
local UrlBase = require(GraphQLServerParent.UrlBuilder).UrlBase
local Promise = require(GraphQLServerParent.Promise)
local GraphQLError = require(GraphQLServerParent.GraphQL).GraphQLError
local Response = require(GraphQLServerParent.Fetch).Response
local fetch = require(GraphQLServerParent.Fetch).fetch

local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local _generatedTypes = require(script.Parent.Parent.generatedTypes)

local FFlagPlayerSearchEnableOnlineFrequents = require(GraphQLServerParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequents

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "profile-insights-api/v1/multiProfileInsights" })

local function findProfileInsightsByUserIds(input, num1: number?, rankingStrategy: string?, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = var1(urlBuilder(), {
            body = HttpService:JSONEncode(
                {
                    userIds = input,
                    count = not rankingStrategy and (num1 or 2) or nil,
                    rankingStrategy = rankingStrategy
                }
            ),
            method = "POST",
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):catch(
            function()
                return Response.error()
            end
        ):expect()

        if not var2.ok then
            callback2(GraphQLError.new(string.format("Failed to fetch profile insights. Error code: %d", var2.status)))

            return
        end

        local var3 = var2:json():catch(function()
            return nil
        end):expect()

        if not var3 then
            callback2(
                GraphQLError.new(
                    string.format("Failed to decode HTTP response as JSON for profile insights: %s.", HttpService:JSONEncode(input))
                )
            )

            return
        end

        callback(var3.userInsights)
    end)
end

return {
    findProfileInsightsByUserIds = findProfileInsightsByUserIds,
    findProfileInsightsByUserIdsFeed = function(tbl1, num1: number?, pageId: string?, str1: string?, arg1)
        if not FFlagPlayerSearchEnableOnlineFrequents then
            str1 = nil
        end
        return (findProfileInsightsByUserIds(tbl1, num1, str1, arg1):andThen(function(profileInsights)
            return { pageId = pageId, profileInsights = profileInsights }
        end))
    end
}

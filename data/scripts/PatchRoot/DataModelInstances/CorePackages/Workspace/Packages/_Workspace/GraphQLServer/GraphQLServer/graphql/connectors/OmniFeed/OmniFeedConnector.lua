-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local Object = require(GraphQLServerParent.LuauPolyfill).Object

local Promise = require(GraphQLServerParent.Promise)
local module = {}
local Fetch = require(GraphQLServerParent.Fetch)
local fetch = Fetch.fetch
local Response = Fetch.Response

local GraphQLError = require(GraphQLServerParent.GraphQL).GraphQLError
local UrlBuilder = require(GraphQLServerParent.UrlBuilder).UrlBuilder
local buildOmniRecommendationsRequest = require(script.Parent.buildOmniRecommendationsRequest)

local _generatedTypes = require(script.Parent.Parent.Parent.generatedTypes)

local string2 = UrlBuilder.fromString("apis:discovery-api/omni-recommendation-metadata")

function module.findOmniFeedBySessionId(arg1, arg2)
    local omniRecommendationsRequest = buildOmniRecommendationsRequest(arg2 or fetch)

    return Promise.new(function(callback, callback2)
        local var1 = omniRecommendationsRequest(arg1.pageType, arg1.sessionId, arg1.nextPageToken, arg1.supportedTreatmentTypes):catch(
            function()
                return Response.error()
            end
        ):expect()

        if not var1.ok then
            callback2(GraphQLError.new(string.format("Failed to fetch omni recommendations. Error code: %d", var1.status)))

            return nil
        end

        local var2 = var1:json():catch(function()
            return nil
        end):expect()

        if not var2 then
            callback2(GraphQLError.new("Failed to decode HTTP response as JSON for omni-recommendation fetch"))
        end
        callback(Object.assign({ omniSessionId = arg1.sessionId, pageType = arg1.pageType }, var2))

        return nil
    end)
end

function module.fetchMoreOmniRecommendationMetadata(arg1, arg2)
    local var1 = arg2 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string2()

        local var3 = var1(var2, {
            body = HttpService:JSONEncode({ sessionId = arg1.sessionId, contents = arg1.recommendations }),
            method = "POST",
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):catch(
            function()
                return Response.error()
            end
        ):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to fetch additional metadata for topicId: %s", arg1.topicId)))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(GraphQLError.new(string.format("Failed to decode HTTP response as JSON for topicId: %s", arg1.topicId)))

            return
        end

        callback(Object.assign(var4, { topicId = arg1.topicId, recommendations = arg1.recommendations }))
    end)
end

return module

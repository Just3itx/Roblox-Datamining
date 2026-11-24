-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")

local UrlBuilder = require(GraphQLServer.Parent.UrlBuilder).UrlBuilder
local UrlBase = require(GraphQLServer.Parent.UrlBuilder).UrlBase
local _LuauPolyfill = require(GraphQLServer.Parent.LuauPolyfill)
local Promise = require(GraphQLServer.Parent.Promise)
local GraphQLError = require(GraphQLServer.Parent.GraphQL).GraphQLError
local _generatedTypes = require(GraphQLServer.graphql.generatedTypes)
local Fetch = require(GraphQLServer.Parent.Fetch)
local fetch = Fetch.fetch
local Response = Fetch.Response

local module = {}

local urlBuilder = UrlBuilder.new(
    {
        base = UrlBase.APIS,
        path = "access-management/v1/feature-access",
        query = { featureNames = "{featureNames}" }
    }
)

function module.getFeatureAccessFromFeatureNamesList(tbl1, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local featureNames = table.concat(tbl1, ",")
        local var2 = urlBuilder({ featureNames = featureNames })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if var3.status == 304 then
            callback2(GraphQLError.new("Got Response: 304, using cached data instead"))
            return
        end

        if not var3.ok then
            callback2(GraphQLError.new("Failed to find feature access values"))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(GraphQLError.new("Failed to decode HTTP response as JSON for AMP Feature Access API"))
            return
        end

        local features = {}

        for _, value in var4.features do
            table.insert(features, { featureName = value.featureName, access = value.access })
        end

        callback({ features = features })
    end)
end

local urlBuilder2 = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "access-management/v1/upsell-feature-access",
    query = {
        { name = "featureName", value = "{featureName}", optional = false },
        { name = "successfulActions", value = "{successfulActions}", optional = false },
        { name = "nameSpace", value = "{nameSpace}", optional = true },
        { name = "extraParameters", value = "{extraParameters}", optional = true }
    }
})

function module.getUpsellFeatureAccessFromFeatureName(featureName: string, tbl1, arg1, nameSpace: string?, extraParameters: string?)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local successfulActions = table.concat(tbl1, ",")
        local var2 = urlBuilder2({
            featureName = featureName,
            successfulActions = successfulActions,
            nameSpace = nameSpace,
            extraParameters = extraParameters
        })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if var3.status == 304 then
            callback2(GraphQLError.new("Got Response: 304, using cached data instead"))
            return
        end

        if not var3.ok then
            callback2(GraphQLError.new("Failed to find upsell feature access values"))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(GraphQLError.new("Failed to decode HTTP response as JSON for AMP Upsell Feature Access API"))
            return
        end

        callback({
            featureName = var4.featureName,
            access = var4.access,
            recourse = var4.recourse,
            recourses = var4.recourses,
            shouldPrompt = var4.shouldPrompt
        })
    end)
end

return module

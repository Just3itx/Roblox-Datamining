-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")

local _LuauPolyfill = require(GraphQLServer.Parent.LuauPolyfill)

local _generatedTypes = require(GraphQLServer.graphql.generatedTypes)

local Promise = require(GraphQLServer.Parent.Promise)
local GraphQLError = require(GraphQLServer.Parent.GraphQL).GraphQLError
local Fetch = require(GraphQLServer.Parent.Fetch)
local fetch = Fetch.fetch

local Response = Fetch.Response
local UrlBuilder = require(GraphQLServer.Parent.UrlBuilder).UrlBuilder
local UrlBase = require(GraphQLServer.Parent.UrlBuilder).UrlBase

local module = {}

local string2 = UrlBuilder.fromString("games:games?universeIds={universeIds}")
local urlBuilder = UrlBuilder.new({ base = UrlBase.new("games", 2), path = "games/{universeId}/media" })

function module.findExperienceDetailsByUniverseId(universeIds: string, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string2({ universeIds = universeIds })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find experience for universeId: %s.", universeIds)))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(
                    string.format("Failed to decode HTTP response as JSON for experience with universeId: %s.", universeIds)
                )
            )

            return
        end

        callback(var4.data[1])
    end)
end

function module.findExperienceMediaByUniverseId(universeId: string, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = urlBuilder({ universeId = universeId })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find experience media for universeId: %s.", universeId)))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(
                    string.format("Failed to decode HTTP response as JSON for experience media for universeId: %s.", universeId)
                )
            )

            return
        end

        callback(var4.data)
    end)
end

return module

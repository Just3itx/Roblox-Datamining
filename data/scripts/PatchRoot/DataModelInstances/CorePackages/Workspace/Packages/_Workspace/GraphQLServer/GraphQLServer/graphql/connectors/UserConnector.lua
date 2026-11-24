-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local UrlBuilder = require(GraphQLServerParent.UrlBuilder).UrlBuilder
local UrlBase = require(GraphQLServerParent.UrlBuilder).UrlBase
local _generatedTypes = require(script.Parent.Parent.generatedTypes)

local Promise = require(GraphQLServerParent.Promise)
local GraphQLError = require(GraphQLServerParent.GraphQL).GraphQLError
local fetch = require(GraphQLServerParent.Fetch).fetch

local Response = require(GraphQLServerParent.Fetch).Response
local module = {}

local urlBuilder = UrlBuilder.new({ base = UrlBase.new("users", 1), path = "users/{id}" })

local function findUserById(id: string, arg1)
    local var1 = arg1 or fetch
    return Promise.new(function(callback, callback2)
        local var2 = urlBuilder({ id = id })

        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find user matching id: %s.", id)))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(GraphQLError.new(string.format("Failed to decode HTTP response as JSON for user matching id: %s.", id)))

            return
        end

        callback({ id = tostring(var4.id), displayName = var4.displayName })
    end)
end

module.findUserById = findUserById

function module.findMe(arg1, arg2)
    local var1 = arg2 or Players.LocalPlayer
    if not var1 then
        return Promise.reject(GraphQLError.new("LocalPlayer not found"))
    end
    local userId = var1.UserId
    return findUserById(tostring(userId), arg1)
end
return module

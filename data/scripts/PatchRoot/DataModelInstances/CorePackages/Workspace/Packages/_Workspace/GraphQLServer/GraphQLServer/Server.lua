-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local GraphQL = require(GraphQLServerParent.GraphQL)

local Promise = require(GraphQLServerParent.Promise)
local Object = require(GraphQLServerParent.LuauPolyfill).Object

local fetch = require(GraphQLServerParent.Fetch).fetch
local _DataLoader = require(GraphQLServerParent.DataLoader)

local Response = require(script.Parent.Response)
local graphql = require(script.Parent.graphql)
local typeDefs = graphql.typeDefs

local resolvers = graphql.resolvers
local dataLoaders = graphql.dataLoaders

local buildTypeResolver = require(script.Parent.schemaUtils.buildTypeResolver)
local buildRootValue = require(script.Parent.schemaUtils.buildRootValue)
local buildFieldResolver = require(script.Parent.schemaUtils.buildFieldResolver)
local addMockResolvers = require(script.Parent.schemaUtils.addMockResolvers)

local getFFlagUserProfilesDataLoaderEnabled = require(GraphQLServerParent.SharedFlags).getFFlagUserProfilesDataLoaderEnabled

local module = {}
module.__index = module

function module.new(tbl1)
    local tbl2 = {
        port = if tbl1.port then tbl1.port else 4000
    }
    local success, result

    if tbl1.typeDefs then
        success = false
        result = nil
    else
        success, result = pcall(function()
            return require(script.Parent.compiled_schema)
        end)
    end

    if success and result then
        tbl2.schema = GraphQL.buildASTSchema(result, { assumeValid = true, assumeValidSDL = true })
    else
        local var1 = if tbl1.typeDefs then tbl1.typeDefs else typeDefs
        tbl2.schema = GraphQL.buildSchema(var1)
    end

    local var1 = if tbl1.resolvers then tbl1.resolvers else resolvers

    if type(tbl1.mockResolvers) == "table" then
        var1 = addMockResolvers(var1, tbl1.mockResolvers)
    end

    tbl2.rootValue = buildRootValue(var1)
    tbl2.typeResolver = buildTypeResolver(var1)
    tbl2.fieldResolver = buildFieldResolver(var1)
    tbl2.fetchImpl = if tbl1.fetchImpl then tbl1.fetchImpl else fetch

    if getFFlagUserProfilesDataLoaderEnabled() then
        tbl2.clientLoaders = Object.assign({}, { userProfiles = dataLoaders.userProfilesDataLoader.new() }, tbl1.dataLoaderInitializers or {})
    end

    setmetatable(tbl2, module)
    return tbl2
end

function module.fetchLocal(tbl1, tbl2)
    local var1 = not tbl2 and {} or HttpService:JSONDecode(tbl2.body)

    local tbl3 = {}
    return Promise.new(function(callback, _)
        local graphql2 = GraphQL.graphql
        local tbl4 = {
            schema = tbl1.schema,
            source = var1.query or var1.mutation,
            rootValue = tbl1.rootValue,
            contextValue = {
                fetchImpl = tbl1.fetchImpl,
                dataLoaders = if getFFlagUserProfilesDataLoaderEnabled() then Object.assign({}, tbl3, tbl1.clientLoaders) else tbl3
            },
            typeResolver = tbl1.typeResolver,
            fieldResolver = tbl1.fieldResolver,
            variableValues = var1.variables
        }

        graphql2(tbl4):andThen(function(arg1)
            callback(Response.new(arg1))
        end)
    end)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local mergeTypeDefs = require(GraphQLServerParent.GraphqlToolsMerge).mergeTypeDefs
local GraphQL = require(GraphQLServerParent.GraphQL)

local resolvers = require(script.resolvers)
local generatedTypes = require(script.generatedTypes)
local luaTypeDefs = require(script.luaTypeDefs)
return {
    typeDefs = "",
    generateTypeDefs = function()
        local var1 = mergeTypeDefs(luaTypeDefs)
        return (GraphQL.print(var1))
    end,
    resolvers = resolvers,
    generatedTypes = generatedTypes,
    dataLoaders = require(script.dataLoaders),
    mocks = require(script.mocks)
}

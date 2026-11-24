-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Server = require(script.Server)
local graphql = require(script.graphql)
local generatedTypes = graphql.generatedTypes
local ApolloClientTestUtils = require(script.ApolloClientTestUtils)

return {
    GraphQLServer = Server,
    types = generatedTypes,
    mocks = graphql.mocks,
    ApolloClientTestUtils = ApolloClientTestUtils,
    generateTypeDefs = graphql.generateTypeDefs,
    enums = require(script.graphql.enums),
    ["jest.config"] = script["jest.config"]
}

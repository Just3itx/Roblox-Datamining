-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxApolloClientParent = script:FindFirstAncestor("RobloxApolloClient").Parent

local ApolloClient = require(RobloxApolloClientParent.ApolloClient)
local ApolloLocalState = require(RobloxApolloClientParent.ApolloLocalState)
local GraphQLServer = require(RobloxApolloClientParent.GraphQLServer).GraphQLServer
local ApolloClient2 = ApolloClient.ApolloClient
local HttpLink = ApolloClient.HttpLink
local InMemoryCache = ApolloClient.InMemoryCache
local typePolicies = ApolloLocalState.typePolicies

function initalizeApolloClient(arg1)
    local graphQlServer = GraphQLServer.new(arg1)
    local httpLink = HttpLink.new({
        uri = "/api",
        fetch = function(_, arg2)
            return graphQlServer:fetchLocal(arg2)
        end
    })

    local inMemoryCache = InMemoryCache.new({ typePolicies = typePolicies })

    return (ApolloClient2.new({ link = httpLink, cache = inMemoryCache }))
end

return initalizeApolloClient

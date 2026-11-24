-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent

local ApolloClient = require(GraphQLServerParent.ApolloClient)
local ApolloClient2 = ApolloClient.ApolloClient
local HttpLink = ApolloClient.HttpLink
local InMemoryCache = ApolloClient.InMemoryCache

local typePolicies = require(GraphQLServerParent.ApolloLocalState).typePolicies

local Server = require(script.Parent.Server)
local buildFetch = require(GraphQLServerParent.Fetch).buildFetch

local Object = require(GraphQLServerParent.LuauPolyfill).Object

local _ApolloClientTestUtilsTypes = require(script.ApolloClientTestUtilsTypes)

local function mockHttpService(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        RequestInternal = function(_, arg2)
            return {
                Start = function(_, callback)
                    local var1 = if arg1.responseMap and arg1.responseMap[arg2.Url] then arg1.responseMap[arg2.Url] else arg1.defaultResponse or {}
                    callback(true, {
                        Body = HttpService:JSONEncode(var1.Body),
                        Success = var1.Success == nil or var1.Success,
                        StatusCode = if var1.StatusCode then var1.StatusCode else 200,
                        StatusMessage = if var1.StatusMessage then var1.StatusMessage else "OK",
                        Headers = not var1.Headers and {} or var1.Headers
                    })
                    if arg1.responseSpy then
                        arg1.responseSpy(arg2)
                    end
                end
            }
        end
    }
end

return {
    mockApolloClient = function(arg1)
        local tbl1 = mockHttpService(arg1)
        local server = Server.new({ mockResolvers = arg1.mockResolvers, fetchImpl = buildFetch(tbl1) })

        return (ApolloClient2.new({
            cache = InMemoryCache.new({ typePolicies = typePolicies }),
            link = HttpLink.new({
                uri = "/api",
                fetch = function(_, arg2)
                    return server:fetchLocal(arg2)
                end
            })
        }))
    end,
    mockHttpService = mockHttpService,
    appendApolloClientToReducer = function(arg1, apolloClient)
        return function(arg2, arg3)
            arg2 = arg1(arg2 or {}, arg3)
            return (Object.assign(table.clone(arg2), { ApolloClient = { apolloClient = apolloClient } }))
        end
    end
}

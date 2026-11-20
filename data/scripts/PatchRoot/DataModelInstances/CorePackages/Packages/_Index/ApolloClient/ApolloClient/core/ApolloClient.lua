-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local setTimeout = LuauPolyfill.setTimeout

local Promise = require(scriptParentParentParent.Promise)

local _GraphQL = require(scriptParentParentParent.GraphQL)

local invariant = require(scriptParentParent.jsutils.invariant)
local invariant2 = invariant.invariant
local InvariantError = invariant.InvariantError

local core = require(script.Parent.Parent.link.core)
local ApolloLink = core.ApolloLink

local execute = core.execute

local _cache = require(script.Parent.Parent.cache)

local compact = require(script.Parent.Parent.utilities).compact
local version = require(script.Parent.Parent.version).version

local HttpLink = require(script.Parent.Parent.link.http).HttpLink

local QueryManager = require(script.Parent.QueryManager).QueryManager

local _ObservableQuery_types = require(script.Parent.ObservableQuery_types)

local _types = require(scriptParentParent.core.types)

local _watchQueryOptions_types = require(script.Parent.watchQueryOptions_types)

local _watchQueryOptions = require(script.Parent.watchQueryOptions)

local LocalState = require(script.Parent.LocalState).LocalState

local _ApolloClient_types = require(script.Parent.ApolloClient_types)

local function mergeOptions(arg1, arg2)
    return compact(
        arg1,
        arg2,
        Boolean.toJSBoolean(arg2.variables) and {
            variables = Object.assign({}, arg1.variables, arg2.variables)
        }
            or arg2.variables
    )
end
tbl1.mergeOptions = mergeOptions

local ApolloClient = {}
ApolloClient.__index = ApolloClient

function ApolloClient.new(tbl3)
    local self = setmetatable({}, ApolloClient)
    self.defaultOptions = {}
    self.resetStoreCallbacks = {}
    self.clearStoreCallbacks = {}

    local uri = tbl3.uri
    local credentials = tbl3.credentials
    local headers = tbl3.headers
    local cache = tbl3.cache
    local defaultOptions = tbl3.defaultOptions
    local resolvers = tbl3.resolvers
    local typeDefs = tbl3.typeDefs
    local fragmentMatcher = tbl3.fragmentMatcher
    local name = tbl3.name
    local version2 = tbl3.version
    local ssrMode = not (tbl3.ssrMode == nil) and tbl3.ssrMode
    local var1 = if tbl3.ssrForceFetchDelay == nil then 0 else tbl3.ssrForceFetchDelay
    local var2 = if tbl3.connectToDevTools == nil then typeof(_G) == "table" and not Boolean.toJSBoolean(_G.__APOLLO_CLIENT__) and _G.__DEV__ else tbl3.connectToDevTools
    local queryDeduplication = tbl3.queryDeduplication == nil or tbl3.queryDeduplication
    local assumeImmutableResults = not (tbl3.assumeImmutableResults == nil) and tbl3.assumeImmutableResults
    local link = tbl3.link

    if not Boolean.toJSBoolean(link) then
        if Boolean.toJSBoolean(uri) then
            link = HttpLink.new({ uri = uri, credentials = credentials, headers = headers })
        else
            link = ApolloLink.empty()
        end
    end

    if not Boolean.toJSBoolean(cache) then
        error(
            InvariantError.new(
                "To initialize Apollo Client, you must specify a 'cache' property in the options object. \nFor more information, please visit: https://go.apollo.dev/c/docs"
            )
        )
    end

    self.link = link
    self.cache = cache
    self.disableNetworkFetches = Boolean.toJSBoolean(ssrMode) and ssrMode or var1 > 0
    self.queryDeduplication = queryDeduplication
    self.defaultOptions = Boolean.toJSBoolean(defaultOptions) and (defaultOptions or {}) or {}
    self.typeDefs = typeDefs

    if Boolean.toJSBoolean(var1) then
        setTimeout(function()
            self.disableNetworkFetches = false
            return self.disableNetworkFetches
        end, var1)
    end

    self.version = version

    self.localState = LocalState.new({ cache = cache, client = self, resolvers = resolvers, fragmentMatcher = fragmentMatcher })

    self.queryManager = QueryManager.new({
        cache = self.cache,
        link = self.link,
        queryDeduplication = queryDeduplication,
        ssrMode = ssrMode,
        clientAwareness = { name = name, version = version2 },
        localState = self.localState,
        assumeImmutableResults = assumeImmutableResults,
        onBroadcast = var2 and function() end or nil
    })

    return self
end

function ApolloClient:stop()
    self.queryManager:stop()
end

function ApolloClient:watchQuery(arg1)
    if Boolean.toJSBoolean(self.defaultOptions.watchQuery) then
        arg1 = mergeOptions(self.defaultOptions.watchQuery, arg1)
    end

    if self.disableNetworkFetches and (arg1.fetchPolicy == "network-only" or arg1.fetchPolicy == "cache-and-network") then
        arg1 = Object.assign({}, arg1, { fetchPolicy = "cache-first" })
    end

    return self.queryManager:watchQuery(arg1)
end

function ApolloClient:query(arg1)
    if Boolean.toJSBoolean(self.defaultOptions.query) then
        arg1 = mergeOptions(self.defaultOptions.query, arg1)
    end

    invariant2(
        arg1.fetchPolicy ~= "cache-and-network",
        "The cache-and-network fetchPolicy does not work with client.query, because client.query can only return a single result. Please use client.watchQuery to receive multiple results from the cache and the network, or consider using a different fetchPolicy, such as cache-first or network-only."
    )

    if self.disableNetworkFetches and arg1.fetchPolicy == "network-only" then
        arg1 = Object.assign({}, arg1, { fetchPolicy = "cache-first" })
    end

    return self.queryManager:query(arg1)
end

function ApolloClient:mutate(arg1)
    if Boolean.toJSBoolean(self.defaultOptions.mutate) then
        arg1 = mergeOptions(self.defaultOptions.mutate, arg1)
    end
    return self.queryManager:mutate(arg1)
end

function ApolloClient:subscribe(arg1)
    return self.queryManager:startGraphQLSubscription(arg1)
end

function ApolloClient:readQuery(arg1, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    return self.cache:readQuery(arg1, bool1)
end

function ApolloClient:readFragment(arg1, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    return self.cache:readFragment(arg1, bool1)
end

function ApolloClient:writeQuery(arg1)
    self.cache:writeQuery(arg1)
    self.queryManager:broadcastQueries()
end

function ApolloClient:writeFragment(arg1)
    self.cache:writeFragment(arg1)
    self.queryManager:broadcastQueries()
end

function ApolloClient.__actionHookForDevTools(tbl3, devToolsHookCb: (...any) -> (...any))
    tbl3.devToolsHookCb = devToolsHookCb
end

function ApolloClient:__requestRaw(arg1)
    return execute(self.link, arg1)
end

function ApolloClient.resetStore(arg1)
    return Promise.delay(0):andThen(function()
        return arg1.queryManager:clearStore()
    end):andThen(function()
        return Promise.all(Array.map(arg1.resetStoreCallbacks, function(arg2)
            return arg2()
        end))
    end):andThen(function()
        return arg1:reFetchObservableQueries()
    end)
end

function ApolloClient.clearStore(arg1)
    return Promise.delay(0):andThen(function()
        return arg1.queryManager:clearStore()
    end):andThen(function()
        return Promise.all(Array.map(arg1.clearStoreCallbacks, function(arg2)
            return arg2()
        end))
    end)
end

function ApolloClient:onResetStore(func1: (...any) -> (...any))
    table.insert(self.resetStoreCallbacks, func1)
    return function()
        self.resetStoreCallbacks = Array.filter(self.resetStoreCallbacks, function(arg1): boolean
            return arg1 ~= func1
        end)
    end
end

function ApolloClient:onClearStore(func1: (...any) -> (...any))
    table.insert(self.clearStoreCallbacks, func1)
    return function()
        self.clearStoreCallbacks = Array.filter(self.clearStoreCallbacks, function(arg1): boolean
            return arg1 ~= func1
        end)
    end
end

function ApolloClient:reFetchObservableQueries(bool1: boolean?)
    return self.queryManager:reFetchObservableQueries(bool1)
end

function ApolloClient:refetchQueries(arg1)
    local queries = {}
    local results = {}

    self.queryManager:refetchQueries(arg1):forEach(function(arg2, arg3)
        table.insert(queries, arg3)
        table.insert(results, arg2)
    end)

    local var1 = Promise.all(results)

    var1.queries = queries
    var1.results = results

    var1:catch(function(arg2)
        invariant2.debug(("In client.refetchQueries, Promise.all promise rejected with error %s"):format(arg2.message))
    end)

    return var1
end

function ApolloClient:getObservableQueries(arg1)
    return self.queryManager:getObservableQueries(if arg1 == nil then "active" else arg1)
end

function ApolloClient:extract(bool1: boolean?)
    return self.cache:extract(bool1)
end

function ApolloClient:restore(arg1)
    return self.cache:restore(arg1)
end

function ApolloClient:addResolvers(arg1)
    self.localState:addResolvers(arg1)
end

function ApolloClient:setResolvers(arg1)
    self.localState:setResolvers(arg1)
end

function ApolloClient:getResolvers()
    return self.localState:getResolvers()
end

function ApolloClient:setLocalStateFragmentMatcher(arg1)
    self.localState:setFragmentMatcher(arg1)
end

function ApolloClient:setLink(link)
    self.queryManager.link = link
    self.link = self.queryManager.link
end

tbl1.ApolloClient = ApolloClient

return tbl1

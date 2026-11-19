-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:20:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local instanceof = LuauPolyfill.instanceof
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local WeakMap = LuauPolyfill.WeakMap

local Promise = require(scriptParentParentParent.Promise)
local HttpService = game:GetService("HttpService")

local isCallable = require(scriptParentParent.luaUtils.isCallable)
local toJSBoolean = require(scriptParentParent.utilities.globals.null).toJSBoolean

local _GraphQL = require(scriptParentParentParent.GraphQL)

local invariant = require(scriptParentParent.jsutils.invariant)
local invariant2 = invariant.invariant
local InvariantError = invariant.InvariantError
local equal = require(scriptParentParent.jsutils.equal)

local execute = require(script.Parent.Parent.link.core).execute

local canonicalStringify = require(script.Parent.Parent.cache).canonicalStringify

local utilities = require(script.Parent.Parent.utilities)
local getDefaultValues = utilities.getDefaultValues
local getOperationDefinition = utilities.getOperationDefinition
local getOperationName = utilities.getOperationName
local hasClientExports = utilities.hasClientExports
local graphQLResultHasError = utilities.graphQLResultHasError
local removeConnectionDirectiveFromDocument = utilities.removeConnectionDirectiveFromDocument
local _canUseWeakMap = utilities.canUseWeakMap

local Observable = utilities.Observable

local asyncMap = utilities.asyncMap
local isNonEmptyArray = utilities.isNonEmptyArray
local Concast = utilities.Concast

local makeUniqueId = utilities.makeUniqueId
local isDocumentNode = utilities.isDocumentNode
local isNonNullObject = utilities.isNonNullObject
local errors = require(script.Parent.Parent.errors)
local ApolloError = errors.ApolloError

local isApolloError = errors.isApolloError
local _watchQueryOptions_types = require(script.Parent.watchQueryOptions_types)

local ObservableQuery = require(script.Parent.ObservableQuery)
local _ObservableQuery_types = require(script.Parent.ObservableQuery_types)
local ObservableQuery2 = ObservableQuery.ObservableQuery

local applyNextFetchPolicy = ObservableQuery.applyNextFetchPolicy
local networkStatus = require(script.Parent.networkStatus)
local NetworkStatus = networkStatus.NetworkStatus

local isNetworkRequestInFlight = networkStatus.isNetworkRequestInFlight
local _types = require(script.Parent.types)

local LocalState = require(script.Parent.LocalState).LocalState

local QueryInfo = require(script.Parent.QueryInfo)
local QueryInfo2 = QueryInfo.QueryInfo

local shouldWriteResult = QueryInfo.shouldWriteResult
local CacheWriteBehavior = QueryInfo.CacheWriteBehavior

local hasOwnProperty = require(scriptParentParent.luaUtils.hasOwnProperty)

local QueryManager = {}
QueryManager.__index = QueryManager

function QueryManager.new(tbl3)
    local cache = tbl3.cache
    local link = tbl3.link
    local queryDeduplication = tbl3.queryDeduplication
    local onBroadcast = tbl3.onBroadcast
    local ssrMode = tbl3.ssrMode
    local clientAwareness = tbl3.clientAwareness
    local localState = tbl3.localState
    local assumeImmutableResults = tbl3.assumeImmutableResults
    if queryDeduplication == nil then
        queryDeduplication = false
    end

    if ssrMode == nil then
        ssrMode = false
    end

    local self = setmetatable({}, QueryManager)

    self.clientAwareness = {}

    self.queries = Map.new()

    self.fetchCancelFns = Map.new()

    self.transformCache = WeakMap.new()

    self.queryIdCounter = 1
    self.requestIdCounter = 1
    self.mutationIdCounter = 1
    self.inFlightLinkObservables = Map.new()

    self.cache = cache
    self.link = link
    self.queryDeduplication = queryDeduplication
    self.clientAwareness = clientAwareness == nil and {} or clientAwareness
    self.localState = localState or LocalState.new({ cache = cache })
    self.ssrMode = ssrMode
    self.assumeImmutableResults = Boolean.toJSBoolean(assumeImmutableResults)
    self.onBroadcast = onBroadcast
    if Boolean.toJSBoolean(self.onBroadcast) then
        self.mutationStore = {}
    end

    return self
end

function QueryManager:stop()
    self.queries:forEach(function(_, arg1)
        self:stopQueryNoBroadcast(arg1)
    end)

    self:cancelPendingFetches(InvariantError.new("QueryManager stopped while query was in flight"))
end

function QueryManager:cancelPendingFetches(arg1)
    self.fetchCancelFns:forEach(function(arg2)
        return arg2(arg1)
    end)
    self.fetchCancelFns:clear()
end

function QueryManager.mutate(arg1, arg2)
    return Promise.resolve():andThen(function()
        local mutation = arg2.mutation
        local variables = arg2.variables
        local optimisticResponse = arg2.optimisticResponse
        local updateQueries = arg2.updateQueries
        local refetchQueries = arg2.refetchQueries
        local awaitRefetchQueries = arg2.awaitRefetchQueries
        local update = arg2.update
        local onQueryUpdated = arg2.onQueryUpdated
        local errorPolicy = arg2.errorPolicy
        local fetchPolicy = arg2.fetchPolicy
        local keepRootFields = arg2.keepRootFields
        local context = arg2.context

        local var1 = refetchQueries == nil and {} or refetchQueries

        if awaitRefetchQueries == nil then
            awaitRefetchQueries = false
        end

        errorPolicy = if errorPolicy == nil then "none" else errorPolicy

        invariant2(mutation, "mutation option is required. You must specify your GraphQL document in the mutation option.")

        invariant2(
            not Boolean.toJSBoolean(fetchPolicy) or fetchPolicy == "no-cache",
            "Mutations only support a 'no-cache' fetchPolicy. If you don't want to disable the cache, remove your fetchPolicy setting to proceed with the default mutation behavior."
        )

        local mutationId = arg1:generateMutationId()
        local document = arg1:transform(mutation).document

        local variables2 = arg1:getVariables(document, variables)

        if arg1:transform(document).hasClientExports then
            variables2 = arg1.localState:addExportedVariables(document, variables2, context):expect()
        end

        local var3

        if Boolean.toJSBoolean(arg1.mutationStore) then
            arg1.mutationStore[mutationId] = {
                mutation = document,
                variables = variables2,
                loading = true,
                error = nil
            }

            var3 = arg1.mutationStore[mutationId]
        else
            var3 = arg1.mutationStore
        end

        if Boolean.toJSBoolean(optimisticResponse) then
            arg1:markMutationOptimistic(optimisticResponse, {
                mutationId = mutationId,
                document = document,
                variables = variables2,
                fetchPolicy = fetchPolicy,
                errorPolicy = errorPolicy,
                context = context,
                updateQueries = updateQueries,
                update = update,
                keepRootFields = keepRootFields
            })
        end

        arg1:broadcastQueries()

        local var4 = arg1

        return Promise.new(function(callback, callback2)
            return asyncMap(
                arg1:getObservableFromLink(
                    document,
                    Object.assign({}, context, { optimisticResponse = optimisticResponse }),
                    variables2,
                    false
                ),
                function(arg3)
                    if graphQLResultHasError(arg3) and errorPolicy == "none" then
                        error(ApolloError.new({ graphQLErrors = arg3.errors }))
                    end

                    if Boolean.toJSBoolean(var3) then
                        var3.loading = false
                        var3.error = nil
                    end

                    local var5 = Object.assign({}, arg3)

                    if isCallable(var1) then
                        var1 = var1(var5)
                    end

                    if errorPolicy == "ignore" and graphQLResultHasError(var5) then
                        var5.errors = nil
                    end

                    return arg1:markMutationResult({
                        mutationId = mutationId,
                        result = var5,
                        document = document,
                        variables = variables2,
                        fetchPolicy = fetchPolicy,
                        errorPolicy = errorPolicy,
                        context = context,
                        update = update,
                        updateQueries = updateQueries,
                        awaitRefetchQueries = awaitRefetchQueries,
                        refetchQueries = var1,
                        removeOptimistic = Boolean.toJSBoolean(optimisticResponse) and mutationId or nil,
                        onQueryUpdated = onQueryUpdated,
                        keepRootFields = keepRootFields
                    })
                end
            ):subscribe(
                {
                    next = function(_, arg3)
                        var4:broadcastQueries()

                        callback(arg3)
                    end,
                    error = function(_, arg3)
                        if Boolean.toJSBoolean(var3) then
                            var3.loading = false
                            var3.error = arg3
                        end

                        if Boolean.toJSBoolean(optimisticResponse) then
                            var4.cache:removeOptimistic(mutationId)
                        end

                        var4:broadcastQueries()

                        callback2(instanceof(arg3, ApolloError) and arg3 or ApolloError.new({ networkError = arg3 }))
                    end
                }
            )
        end)
    end)
end

function QueryManager:markMutationResult(tbl3, arg1)
    if arg1 == nil then
        arg1 = self.cache
    end

    local result = tbl3.result
    local tbl4 = {}
    local bool1 = tbl3.fetchPolicy == "no-cache"

    if not bool1 and shouldWriteResult(result, tbl3.errorPolicy) then
        table.insert(
            tbl4,
            {
                result = result.data,
                dataId = "ROOT_MUTATION",
                query = tbl3.document,
                variables = tbl3.variables
            }
        )
        local updateQueries = tbl3.updateQueries
        if updateQueries ~= nil then
            self.queries:forEach(function(arg2, arg3)
                local observableQuery = arg2.observableQuery

                if Boolean.toJSBoolean(observableQuery) then
                    observableQuery = observableQuery.queryName
                end

                if not (Boolean.toJSBoolean(observableQuery) and hasOwnProperty(updateQueries, observableQuery)) then
                    return
                end
                local var1 = updateQueries[observableQuery]
                local var2 = self.queries:get(arg3)
                local document = var2.document
                local variables = var2.variables

                local var3 = arg1:diff({ query = document, variables = variables, returnPartialData = true, optimistic = false })

                local result2 = var3.result

                if not var3.complete or not Boolean.toJSBoolean(result2) then
                    return
                end
                local var4 = updateQueries
                local tbl5 = { mutationResult = result, queryName = 0, queryVariables = 0 }
                local operationName

                if Boolean.toJSBoolean(document) then
                    operationName = getOperationName(document)
                    if not Boolean.toJSBoolean(operationName) then
                        operationName = nil
                    end
                else
                    operationName = nil
                end

                tbl5.queryName = operationName

                tbl5.queryVariables = variables
                local var5 = var1(var4, result2, tbl5)

                if not Boolean.toJSBoolean(var5) then
                    return
                end

                table.insert(tbl4, { result = var5, dataId = "ROOT_QUERY", query = document, variables = variables })
            end)
        end
    end

    if #tbl4 > 0
        or Boolean.toJSBoolean(tbl3.refetchQueries)
        or Boolean.toJSBoolean(tbl3.update)
        or Boolean.toJSBoolean(tbl3.onQueryUpdated)
        or Boolean.toJSBoolean(tbl3.removeOptimistic)
    then
        local tbl5 = {}

        local tbl6 = {
            updateCache = function(_, arg2)
                if not bool1 then
                    Array.forEach(tbl4, function(arg3)
                        return arg2:write(arg3)
                    end)
                end

                local update = tbl3.update
                if update ~= nil and Boolean.toJSBoolean(update) then
                    if not bool1 then
                        local var1 = arg2:diff({
                            id = "ROOT_MUTATION",
                            query = self:transform(tbl3.document).asQuery,
                            variables = tbl3.variables,
                            optimistic = false,
                            returnPartialData = true
                        })

                        if var1.complete then
                            result = Object.assign({}, result, { data = var1.result })
                        end
                    end

                    update(tbl3, arg2, result, { context = tbl3.context, variables = tbl3.variables })
                end

                if bool1 or tbl3.keepRootFields then
                    return
                end

                arg2:modify({
                    id = "ROOT_MUTATION",
                    fields = function(_, arg3, arg4)
                        local fieldName = arg4.fieldName
                        local delete = arg4.DELETE
                        return if fieldName == "__typename" then arg3 else delete
                    end
                })
            end,
            include = tbl3.refetchQueries,
            optimistic = false,
            removeOptimistic = tbl3.removeOptimistic,
            onQueryUpdated = if Boolean.toJSBoolean(tbl3.onQueryUpdated) then tbl3.onQueryUpdated or nil else nil
        }

        self:refetchQueries(tbl6):forEach(function(arg2)
            return table.insert(tbl5, arg2)
        end)

        if tbl3.awaitRefetchQueries or Boolean.toJSBoolean(tbl3.onQueryUpdated) then
            return Promise.all(Array.filter(tbl5, toJSBoolean)):andThen(function()
                return result
            end)
        end
    end

    return Promise.resolve(result)
end

function QueryManager:markMutationOptimistic(arg1, tbl3)
    local var1 = if isCallable(arg1) then arg1(tbl3.variables) else arg1

    return self.cache:recordOptimisticTransaction(function(arg2)
        local success, result = pcall(function()
            self:markMutationResult(Object.assign({}, tbl3, { result = { data = var1 } }), arg2)
        end)
        if not success then
            invariant2.error(result)
        end
    end, tbl3.mutationId)
end

function QueryManager.fetchQuery(tbl3, str1: string, arg1, arg2)
    return tbl3:fetchQueryObservable(str1, arg1, arg2).promise
end

function QueryManager:getQueryStore()
    local queryStore = ({})
    self.queries:forEach(function(arg1, arg2)
        queryStore[arg2] = {
            variables = arg1.variables,
            networkStatus = arg1.networkStatus,
            networkError = arg1.networkError,
            graphQLErrors = arg1.graphQLErrors
        }
    end)
    return queryStore
end

function QueryManager:resetErrors(str1: string)
    local var1 = self.queries:get(str1)
    if Boolean.toJSBoolean(var1) then
        var1.networkError = nil
        var1.graphQLErrors = {}
    end
end

function QueryManager:transform(arg1)
    local transformCache = self.transformCache

    if not transformCache:has(arg1) then
        local document = self.cache:transformDocument(arg1)
        local var2 = removeConnectionDirectiveFromDocument(self.cache:transformForLink(document))

        local clientQuery = self.localState:clientQuery(document)

        if Boolean.toJSBoolean(var2) then
            var2 = self.localState:serverQuery(var2)
        end

        local tbl3 = {
            document = document,
            hasClientExports = hasClientExports(document),
            hasForcedResolvers = self.localState:shouldForceResolvers(document),
            clientQuery = clientQuery,
            serverQuery = var2,
            defaultVars = getDefaultValues(getOperationDefinition(document)),
            asQuery = Object.assign({}, document, {
                definitions = Array.map(document.definitions, function(arg2)
                    if arg2.kind == "OperationDefinition" and arg2.operation ~= "query" then
                        return (Object.assign({}, arg2, { operation = "query" }))
                    end
                    return arg2
                end)
            })
        }

        local function add(arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
            if arg2 ~= nil and not transformCache:has(arg2) then
                transformCache:set(arg2, tbl3)
            end
        end

        add(arg1)
        add(document)
        add(clientQuery)
        add(var2)
    end

    return transformCache:get(arg1)
end

function QueryManager:getVariables(arg1, arg2)
    return Object.assign({}, self:transform(arg1).defaultVars, arg2)
end

function QueryManager:watchQuery(options)
    options = Object.assign({}, options, { variables = self:getVariables(options.query, options.variables) })

    if typeof(options.notifyOnNetworkStatusChange) == "nil" then
        options.notifyOnNetworkStatusChange = false
    end

    local queryInfo2 = QueryInfo2.new(self.cache)
    local observableQuery2 = ObservableQuery2.new({ queryManager = self, queryInfo = queryInfo2, options = options })

    self.queries:set(observableQuery2.queryId, queryInfo2)

    queryInfo2:init({ document = options.query, observableQuery = observableQuery2, variables = options.variables })

    return observableQuery2
end

function QueryManager.query(tbl3, arg1, str1: string?)
    if str1 == nil then
        str1 = tbl3:generateQueryId()
    end

    invariant2(arg1.query, "query option is required. You must specify your GraphQL document in the query option.")

    invariant2(arg1.query.kind == "Document", "You must wrap the query string in a \"gql\" tag.")

    invariant2(not Boolean.toJSBoolean(arg1.returnPartialData), "returnPartialData option only supported on watchQuery.")

    invariant2(not Boolean.toJSBoolean(arg1.pollInterval), "pollInterval option only supported on watchQuery.")

    return tbl3:fetchQuery(str1, arg1):andThen(function<T>(arg2: T): T
        tbl3:stopQuery(str1)
        return arg2
    end):catch(function(arg2)
        tbl3:stopQuery(str1)
        error(arg2)
    end)
end

function QueryManager:generateQueryId(): string
    local queryIdCounter = self.queryIdCounter
    self.queryIdCounter += 1
    return tostring(queryIdCounter)
end

function QueryManager:generateRequestId()
    local requestIdCounter = self.requestIdCounter
    self.requestIdCounter += 1
    return requestIdCounter
end

function QueryManager:generateMutationId(): string
    local mutationIdCounter = self.mutationIdCounter
    self.mutationIdCounter += 1
    return tostring(mutationIdCounter)
end

function QueryManager.stopQueryInStore(tbl3, str1: string)
    tbl3:stopQueryInStoreNoBroadcast(str1)
    tbl3:broadcastQueries()
end

function QueryManager:stopQueryInStoreNoBroadcast(str1: string)
    local var1 = self.queries:get(str1)
    if Boolean.toJSBoolean(var1) then
        var1:stop()
    end
end

function QueryManager:clearStore()
    self:cancelPendingFetches(InvariantError.new("Store reset while query was in flight (not completed in link chain)"))

    self.queries:forEach(function(arg1, _)
        if Boolean.toJSBoolean(arg1.observableQuery) then
            arg1.networkStatus = NetworkStatus.loading
            return
        end
        arg1:stop()
    end)

    if Boolean.toJSBoolean(self.mutationStore) then
        self.mutationStore = {}
    end

    return self.cache:reset()
end

function QueryManager.resetStore(arg1)
    return arg1:clearStore():andThen(function()
        return arg1:reFetchObservableQueries()
    end)
end

function QueryManager:getObservableQueries(arg1)
    arg1 = if arg1 == nil then "active" else arg1

    local map = Map.new(nil)

    local map2 = Map.new(nil)

    local set = Set.new()

    if Array.isArray(arg1) then
        Array.forEach(arg1, function(arg2)
            if typeof(arg2) == "string" then
                map2:set(arg2, false)
            elseif isDocumentNode(arg2) then
                map2:set(self:transform(arg2).document, false)
            elseif isNonNullObject(arg2) and Boolean.toJSBoolean(arg2.query) then
                set:add(arg2)
            end
        end)
    end

    self.queries:forEach(function(arg2, arg3)
        local observableQuery = arg2.observableQuery
        local document = arg2.document
        if not Boolean.toJSBoolean(observableQuery) then
            return
        end

        if arg1 == "all" then
            map:set(arg3, observableQuery)
            return
        end

        local queryName = observableQuery.queryName

        if observableQuery.options.fetchPolicy == "standby" or not observableQuery:hasObservers() then
            return
        end

        if arg1 ~= "active"
            and (not Boolean.toJSBoolean(queryName) or not map2:has(queryName))
            and (not Boolean.toJSBoolean(document) or not map2:has(document))
        then
            return
        end
        map:set(arg3, observableQuery)
        if Boolean.toJSBoolean(queryName) then
            map2:set(queryName, true)
        end
        if Boolean.toJSBoolean(document) then
            map2:set(document, true)
        end
    end)

    if Boolean.toJSBoolean(set.size) then
        for _, value in set do
            local uniqueId = makeUniqueId("legacyOneTimeQuery")
            local query = self:getQuery(uniqueId)
            local tbl3 = {
                document = value.query,
                variables = value.variables
            }
            local queryInfo = query:init(tbl3)

            local observableQuery2 = ObservableQuery2.new(
                {
                    queryManager = self,
                    queryInfo = queryInfo,
                    options = Object.assign({}, value, { fetchPolicy = "network-only" })
                }
            )
            queryInfo:setObservableQuery(observableQuery2)
            map:set(uniqueId, observableQuery2)
        end
    end

    if _G.__DEV__ and Boolean.toJSBoolean(map2.size) then
        map2:forEach(function(arg2, input)
            if not arg2 then
                invariant2.warn(
                    ("Unknown query %s%s requested in refetchQueries options.include array"):format(
                        if typeof(input) == "string" then "named " else "",
                        HttpService:JSONEncode(input)
                    )
                )
            end
        end)
    end

    return map
end

function QueryManager.reFetchObservableQueries(tbl3, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    local tbl4 = {}

    tbl3:getObservableQueries(if Boolean.toJSBoolean(bool1) then "all" else "active"):forEach(function(arg1, arg2)
        local fetchPolicy = arg1.options.fetchPolicy
        arg1:resetLastResults()
        if Boolean.toJSBoolean(bool1) or fetchPolicy ~= "standby" and fetchPolicy ~= "cache-only" then
            table.insert(tbl4, arg1:refetch())
        end
        tbl3:getQuery(arg2):setDiff(nil)
    end)

    tbl3:broadcastQueries()

    return Promise.all(Array.filter(tbl4, toJSBoolean))
end

function QueryManager.setObservableQuery(arg1, arg2)
    arg1:getQuery(arg2.queryId):setObservableQuery(arg2)
end

function QueryManager:startGraphQLSubscription(arg1)
    local query = arg1.query
    local fetchPolicy = arg1.fetchPolicy
    local errorPolicy = arg1.errorPolicy
    local variables = arg1.variables
    local context = arg1.context
    context = arg1.context == nil and {} or context

    local document = self:transform(query).document
    local variables2 = self:getVariables(document, variables)

    local function makeObservable(variables3)
        return self:getObservableFromLink(document, context, variables3):map(function(arg2)
            if fetchPolicy ~= "no-cache" then
                if shouldWriteResult(arg2, errorPolicy) then
                    self.cache:write({ query = document, result = arg2.data, dataId = "ROOT_SUBSCRIPTION", variables = variables3 })
                end

                self:broadcastQueries()
            end

            if graphQLResultHasError(arg2) then
                error(ApolloError.new({ graphQLErrors = arg2.errors }))
            end

            return arg2
        end)
    end

    if not self:transform(document).hasClientExports then
        return makeObservable(variables2)
    end

    local var1 = self.localState:addExportedVariables(document, variables2, context):andThen(makeObservable)

    return Observable.new(function(arg2)
        local var2 = nil
        var1:andThen(function(arg3)
            var2 = arg3:subscribe(arg2)
            return var2
        end, arg2.error)
        return function()
            if var2 ~= nil then
                return var2:unsubscribe()
            end
            return var2
        end
    end)
end

function QueryManager.stopQuery(tbl3, str1: string)
    tbl3:stopQueryNoBroadcast(str1)
    tbl3:broadcastQueries()
end

function QueryManager:stopQueryNoBroadcast(str1: string)
    self:stopQueryInStoreNoBroadcast(str1)
    self:removeQuery(str1)
end

function QueryManager:removeQuery(str1: string)
    self.fetchCancelFns:delete(str1)
    self:getQuery(str1):stop()
    self.queries:delete(str1)
end

function QueryManager:broadcastQueries()
    if Boolean.toJSBoolean(self.onBroadcast) then
        self:onBroadcast()
    end

    self.queries:forEach(function(arg1, _)
        return arg1:notify()
    end)
end

function QueryManager:getLocalState()
    return self.localState
end

function QueryManager:getObservableFromLink(arg1, arg2, variables, bool1: boolean?)
    if bool1 == nil then
        if Boolean.toJSBoolean(arg2) then
            if arg2.queryDeduplication ~= nil then
                bool1 = arg2.queryDeduplication
            else
                bool1 = self.queryDeduplication
            end
        else
            bool1 = self.queryDeduplication
        end
    end

    local serverQuery = self:transform(arg1).serverQuery
    local var1, concast

    if Boolean.toJSBoolean(serverQuery) then
        local inFlightLinkObservables = self.inFlightLinkObservables
        local link = self.link

        local tbl3 = {
            query = serverQuery,
            variables = variables,
            operationName = if Boolean.toJSBoolean(getOperationName(serverQuery)) then getOperationName(serverQuery) or nil else nil,
            context = self:prepareContext(Object.assign({}, arg2, { forceFetch = not bool1 }))
        }

        var1 = tbl3.context

        if bool1 then
            local var2 = inFlightLinkObservables:get(serverQuery)
            local var3 = Boolean.toJSBoolean(var2) and var2 or Map.new(nil)
            inFlightLinkObservables:set(serverQuery, var3)

            local var4 = canonicalStringify(variables)
            concast = var3:get(var4)

            if not Boolean.toJSBoolean(concast) then
                concast = Concast.new({ (execute(link, tbl3)) })

                var3:set(var4, concast)

                concast:cleanup(function()
                    if Boolean.toJSBoolean(var3:delete(var4)) and var3.size < 1 then
                        inFlightLinkObservables:delete(serverQuery)
                    end
                end)
            end
        else
            concast = Concast.new({ (execute(link, tbl3)) })
        end
    else
        concast = Concast.new({ Observable.of({ data = {} }) })

        var1 = self:prepareContext(arg2)
    end

    local clientQuery = self:transform(arg1).clientQuery

    if toJSBoolean(clientQuery) then
        concast = asyncMap(concast, function(remoteResult)
            return self.localState:runResolvers(
                {
                    document = clientQuery,
                    remoteResult = remoteResult,
                    context = var1,
                    variables = variables
                }
            )
        end)
    end
    return concast
end

function QueryManager:getResultsFromLink(arg1, arg2, arg3)
    arg1.lastRequestId = self:generateRequestId()
    local lastRequestId = arg1.lastRequestId

    return asyncMap(self:getObservableFromLink(arg1.document, arg3.context, arg3.variables), function(arg4)
        local var1 = isNonEmptyArray(arg4.errors)

        if lastRequestId >= arg1.lastRequestId then
            if var1 and arg3.errorPolicy == "none" then
                error(arg1:markError(ApolloError.new({ graphQLErrors = arg4.errors })))
            end

            arg1:markResult(arg4, arg3, arg2)
            arg1:markReady()
        end

        local tbl3 = {
            data = arg4.data,
            loading = false,
            networkStatus = Boolean.toJSBoolean(arg1.networkStatus) and arg1.networkStatus or NetworkStatus.ready
        }

        if var1 and arg3.errorPolicy ~= "ignore" then
            tbl3.errors = arg4.errors
        end

        return tbl3
    end, function(networkError)
        if not isApolloError(networkError) then
            networkError = ApolloError.new({ networkError = networkError })
        end

        if lastRequestId >= arg1.lastRequestId then
            arg1:markError(networkError)
        end

        error(networkError)
    end)
end

function QueryManager:fetchQueryObservable(str1: string, arg1, arg2)
    if arg2 == nil then
        arg2 = NetworkStatus.loading
    end

    local document = self:transform(arg1.query).document
    local variables = self:getVariables(document, arg1.variables)
    local query = self:getQuery(str1)

    local fetchPolicy = arg1.fetchPolicy
    local errorPolicy = arg1.errorPolicy
    local returnPartialData = arg1.returnPartialData
    local notifyOnNetworkStatusChange = arg1.notifyOnNetworkStatusChange
    local context = arg1.context

    local var1 = if fetchPolicy == nil then "cache-first" else fetchPolicy

    local var2 = if errorPolicy == nil then "none" else errorPolicy

    if returnPartialData == nil then
        returnPartialData = false
    end

    if notifyOnNetworkStatusChange == nil then
        notifyOnNetworkStatusChange = false
    end

    local var3 = Object.assign({}, arg1, {
        query = document,
        variables = variables,
        fetchPolicy = var1,
        errorPolicy = var2,
        returnPartialData = returnPartialData,
        notifyOnNetworkStatusChange = notifyOnNetworkStatusChange,
        context = context == nil and {} or context
    })

    local function fromVariables(variables2)
        var3.variables = variables2
        return self:fetchQueryByPolicy(query, var3, arg2)
    end

    local concast = nil

    self.fetchCancelFns:set(str1, function(arg3)
        Promise.delay(0):andThen(function()
            return concast:cancel(arg3)
        end)
    end)

    concast = Concast.new((function()
        if self:transform(var3.query).hasClientExports then
            return self.localState:addExportedVariables(var3.query, var3.variables, var3.context):andThen(fromVariables)
        end
        return fromVariables(var3.variables)
    end)())

    concast:cleanup(function()
        self.fetchCancelFns:delete(str1)
        applyNextFetchPolicy(arg1)
    end)

    return concast
end

function QueryManager:refetchQueries(arg1)
    local updateCache = arg1.updateCache
    local include = arg1.include
    local optimistic = arg1.optimistic
    local removeOptimistic = arg1.removeOptimistic
    local onQueryUpdated = arg1.onQueryUpdated
    if optimistic == nil then
        optimistic = false
    end

    if removeOptimistic == nil then
        if Boolean.toJSBoolean(optimistic) then
            removeOptimistic = makeUniqueId("refetchQueries")
        else
            removeOptimistic = nil
        end
    end

    local map = Map.new(nil)

    if Boolean.toJSBoolean(include) then
        self:getObservableQueries(include):forEach(function(oq, arg3)
            map:set(arg3, { oq = oq, lastDiff = self:getQuery(arg3):getDiff() })
        end)
    end

    local map2 = Map.new(nil)

    if Boolean.toJSBoolean(updateCache) then
        local cache = self.cache
        local tbl3 = {
            update = updateCache,
            optimistic = if optimistic and Boolean.toJSBoolean(removeOptimistic) then removeOptimistic else false,
            removeOptimistic = removeOptimistic,
            onWatchUpdated = 0
        }
        function tbl3.onWatchUpdated(_, arg2, diff, lastDiff)
            local oq = if instanceof(arg2.watcher, QueryInfo2) then arg2.watcher.observableQuery else instanceof(arg2.watcher, QueryInfo2)

            if Boolean.toJSBoolean(oq) then
                if onQueryUpdated then
                    map:delete(oq.queryId)

                    local var2 = onQueryUpdated(arg1, oq, diff, lastDiff)

                    if var2 == true then
                        var2 = oq:refetch()
                    end

                    if var2 ~= false then
                        map2:set(oq, var2)
                    end

                    return false
                end

                if onQueryUpdated then
                    map:set(oq.queryId, { oq = oq, lastDiff = lastDiff, diff = diff })
                end
            end
            return nil
        end

        cache:batch(tbl3)
    end

    if Boolean.toJSBoolean(map.size) then
        map:forEach(function(tbl3, str1: string)
            local oq = tbl3.oq
            local lastDiff = tbl3.lastDiff
            local diff = tbl3.diff
            local var1

            if onQueryUpdated == nil then
                var1 = nil
            else
                if diff == nil then
                    local queryInfo = oq.queryInfo
                    queryInfo:reset()
                    diff = queryInfo:getDiff()
                end

                var1 = onQueryUpdated(arg1, oq, diff, lastDiff)
            end

            if onQueryUpdated == nil or var1 == true then
                var1 = oq:refetch()
            end

            if var1 ~= false then
                map2:set(oq, var1)
            end

            local var2 = string.find(str1, "legacyOneTimeQuery")
            if var2 ~= nil and var2 >= 1 then
                self:stopQueryNoBroadcast(str1)
            end
        end)
    end

    if Boolean.toJSBoolean(removeOptimistic) then
        self.cache:removeOptimistic(removeOptimistic)
    end

    return map2
end

function QueryManager:fetchQueryByPolicy(arg1, arg2, networkStatus2)
    local query = arg2.query
    local variables = arg2.variables
    local fetchPolicy = arg2.fetchPolicy
    local refetchWritePolicy = arg2.refetchWritePolicy
    local errorPolicy = arg2.errorPolicy
    local returnPartialData = arg2.returnPartialData
    local context = arg2.context
    local notifyOnNetworkStatusChange = arg2.notifyOnNetworkStatusChange

    local networkStatus3 = arg1.networkStatus

    arg1:init({ document = query, variables = variables, networkStatus = networkStatus2 })

    local function readCache() -- Luacid: Inlined by compiler; 3 call sites recovered
        return arg1:getDiff(variables)
    end

    local function resultsFromCache(arg3, arg4)
        if arg4 == nil then
            arg4 = Boolean.toJSBoolean(arg1.networkStatus) and arg1.networkStatus or NetworkStatus.loading
        end

        local result = arg3.result

        if _G.__DEV__
            and arg3.missing ~= nil
            and isNonEmptyArray(arg3.missing)
            and not (equal(result, {}) or Boolean.toJSBoolean(returnPartialData))
        then
            invariant2.debug(("Missing cache result fields: %s"):format(Array.join(Array.map(arg3.missing, function(arg5)
                return Array.join(arg5.path, ".")
            end), ", ")), arg3.missing)
        end

        local function fromData(arg5)
            return Observable.of(
                (Object.assign(
                    {},
                    {
                        data = arg5,
                        loading = isNetworkRequestInFlight(arg4),
                        networkStatus = arg4
                    },
                    not Boolean.toJSBoolean(arg3.complete) and { partial = true } or nil
                ))
            )
        end

        if not (Boolean.toJSBoolean(result) and self:transform(query).hasForcedResolvers) then
            return fromData(result)
        end

        return self.localState:runResolvers({
            document = query,
            remoteResult = { data = result },
            context = context,
            variables = variables,
            onlyRunForcedResolvers = true
        }):andThen(
            function(arg5)
                return fromData(Boolean.toJSBoolean(arg5.data) and arg5.data or nil)
            end
        )
    end

    local var1 = if fetchPolicy == "no-cache" then CacheWriteBehavior.FORBID elseif networkStatus2 == NetworkStatus.refetch and refetchWritePolicy ~= "merge" then CacheWriteBehavior.OVERWRITE else CacheWriteBehavior.MERGE

    local function resultsFromLink()
        return self:getResultsFromLink(
            arg1,
            var1,
            {
                variables = variables,
                context = context,
                fetchPolicy = fetchPolicy,
                errorPolicy = errorPolicy
            }
        )
    end
    if notifyOnNetworkStatusChange then
        if typeof(networkStatus3) == "number" and networkStatus3 ~= networkStatus2 then
            notifyOnNetworkStatusChange = isNetworkRequestInFlight(networkStatus2)
        else
            notifyOnNetworkStatusChange = false
        end
    end
    if fetchPolicy == "cache-first" then
        local var2 = readCache()

        if Boolean.toJSBoolean(var2.complete) then
            return { resultsFromCache(var2, arg1:markReady()) }
        end

        if Boolean.toJSBoolean(returnPartialData) or Boolean.toJSBoolean(notifyOnNetworkStatusChange) then
            return { resultsFromCache(var2), resultsFromLink() }
        end

        return { resultsFromLink() }
    elseif fetchPolicy == "cache-and-network" then
        local var2 = readCache()

        return if Boolean.toJSBoolean(var2.complete)
            or Boolean.toJSBoolean(returnPartialData)
            or Boolean.toJSBoolean(notifyOnNetworkStatusChange) then { resultsFromCache(var2), resultsFromLink() } else { resultsFromLink() }
    elseif fetchPolicy == "cache-only" then
        return { resultsFromCache(arg1:getDiff(variables), arg1:markReady()) }
    elseif fetchPolicy == "network-only" then
        if Boolean.toJSBoolean(notifyOnNetworkStatusChange) then
            return { resultsFromCache(readCache()), resultsFromLink() }
        end

        return { resultsFromLink() }
    elseif fetchPolicy == "no-cache" then
        if Boolean.toJSBoolean(notifyOnNetworkStatusChange) then
            return { resultsFromCache(arg1:getDiff()), resultsFromLink() }
        end

        return { resultsFromLink() }
    elseif fetchPolicy == "standby" then
        return {}
    end

    local var2 = readCache()

    if Boolean.toJSBoolean(var2.complete) then
        return { resultsFromCache(var2, arg1:markReady()) }
    end

    if Boolean.toJSBoolean(returnPartialData) or Boolean.toJSBoolean(notifyOnNetworkStatusChange) then
        return { resultsFromCache(var2), resultsFromLink() }
    end

    return { resultsFromLink() }
end

function QueryManager:getQuery(str1: string)
    if Boolean.toJSBoolean(str1) and not self.queries:has(str1) then
        self.queries:set(str1, QueryInfo2.new(self.cache))
    end
    return self.queries:get(str1)
end

function QueryManager:prepareContext(arg1)
    local var1 = self.localState:prepareContext(arg1 == nil and {} or arg1)
    return Object.assign({}, var1, { clientAwareness = self.clientAwareness })
end

tbl1.QueryManager = QueryManager

return tbl1

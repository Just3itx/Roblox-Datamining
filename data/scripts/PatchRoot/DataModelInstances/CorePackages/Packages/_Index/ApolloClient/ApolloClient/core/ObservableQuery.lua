-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:20:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local module = {}

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local isCallable = require(scriptParentParent.luaUtils.isCallable)

local Promise = require(scriptParentParentParent.Promise)

local invariant = require(scriptParentParent.jsutils.invariant).invariant
local equal = require(scriptParentParent.jsutils.equal)

local networkStatus = require(script.Parent.networkStatus)
local NetworkStatus = networkStatus.NetworkStatus

local isNetworkRequestInFlight = networkStatus.isNetworkRequestInFlight

local utilities = require(script.Parent.Parent.utilities)

local compact = utilities.compact
local cloneDeep = utilities.cloneDeep
local getOperationDefinition = utilities.getOperationDefinition
local Observable = utilities.Observable

local iterateObserversSafely = utilities.iterateObserversSafely
local isNonEmptyArray = utilities.isNonEmptyArray
local fixObservableSubclass = utilities.fixObservableSubclass

local ApolloError = require(script.Parent.Parent.errors).ApolloError

local _types = require(script.Parent.types)

local _watchQueryOptions_types = require(script.Parent.watchQueryOptions_types)

local _QueryInfo = require(script.Parent.QueryInfo)

local _ObservableQuery_types = require(script.Parent.ObservableQuery_types)

local defaultSubscriptionObserverErrorCallback = nil

local bool1 = false

local ObservableQuery = setmetatable({}, { __index = Observable })
function ObservableQuery.__index(arg1, arg2)
    if arg2 == "variables" then
        return arg1.options.variables
    elseif rawget(arg1, arg2) then
        return rawget(arg1, arg2)
    elseif rawget(ObservableQuery, arg2) then
        return rawget(ObservableQuery, arg2)
    end
    return getmetatable(ObservableQuery).__index[arg2]
end

function ObservableQuery.__newindex(arg1, arg2, arg3)
    if arg2 == "variables" then
        error("setting getter-only property 'variables'")
    end
    rawset(arg1, arg2, arg3)
end

function ObservableQuery.new(tbl1)
    local queryManager = tbl1.queryManager
    local queryInfo = tbl1.queryInfo
    local options = tbl1.options
    local var2 = nil
    var2 = setmetatable(Observable.new(function(arg1)
        xpcall(function()
            local _observer = arg1._subscription._observer
            if Boolean.toJSBoolean(_observer) and not Boolean.toJSBoolean(_observer.error) then
                _observer.error = defaultSubscriptionObserverErrorCallback
            end
        end, function() end)

        local bool2 = not Boolean.toJSBoolean(var2.observers.size)
        var2.observers:add(arg1)

        if Boolean.toJSBoolean(var2.lastError) then
            if Boolean.toJSBoolean(arg1.error) then
                arg1:error(var2.lastError)
            end
        elseif Boolean.toJSBoolean(var2.lastResult) and Boolean.toJSBoolean(arg1.next) then
            arg1:next(var2.lastResult)
        end

        if bool2 then
            var2:reobserve():catch(function() end)
        end

        return function()
            if var2.observers:delete(arg1) and not Boolean.toJSBoolean(var2.observers.size) then
                var2:tearDownQuery()
            end
        end
    end), ObservableQuery)

    local set = Set.new()
    var2.observers = set
    local set2 = Set.new()
    var2.subscriptions = set2

    var2.observer = {
        next = function(_, arg1)
            if Boolean.toJSBoolean(var2.lastError) or var2:isDifferentFromLastResult(arg1) then
                var2:updateLastResult(arg1)
                iterateObserversSafely(var2.observers, "next", arg1)
            end
        end,
        error = function(_, arg1)
            var2:updateLastResult(
                (Object.assign(
                    {},
                    var2.lastResult,
                    {
                        error = arg1,
                        errors = arg1.graphQLErrors,
                        networkStatus = NetworkStatus.error,
                        loading = false
                    }
                ))
            )
            var2.lastError = arg1
            iterateObserversSafely(var2.observers, "error", var2.lastError)
        end
    }

    var2.isTornDown = false

    var2.options = options
    local queryId = queryManager:generateQueryId()
    var2.queryId = queryId

    local queryName = getOperationDefinition(options.query)

    if not Boolean.toJSBoolean(queryName) then
        var2.queryName = queryName
    elseif not Boolean.toJSBoolean(queryName.name) then
        local name = queryName.name
        var2.queryName = name
    else
        local value = queryName.name.value
        var2.queryName = value
    end

    local fetchPolicy = Boolean.toJSBoolean(options.fetchPolicy) and options.fetchPolicy or "cache-first"
    var2.initialFetchPolicy = fetchPolicy

    var2.queryManager = queryManager
    var2.queryInfo = queryInfo
    return var2
end

function ObservableQuery.result(arg1)
    return Promise.new(function(callback, callback2)
        local var2 = nil

        local var3 = nil
        var3 = {
            next = function(_, arg2)
                callback(arg2)

                arg1.observers:delete(var3)
                if not Boolean.toJSBoolean(arg1.observers.size) then
                    arg1.queryManager:removeQuery(arg1.queryId)
                end
                setTimeout(function()
                    var2:unsubscribe()
                end, 0)
            end,
            error = function(_, arg2)
                callback2(arg2)
            end
        }

        var2 = arg1:subscribe(var3)
    end)
end

function ObservableQuery.getCurrentResult(tbl1, bool2: boolean?)
    if bool2 == nil then
        bool2 = true
    end

    local lastResult = tbl1.lastResult

    local var2 = if tbl1.options.fetchPolicy == nil then "cache-first" else tbl1.options.fetchPolicy
    local var1 = if Boolean.toJSBoolean(tbl1.queryInfo.networkStatus) then tbl1.queryInfo.networkStatus elseif Boolean.toJSBoolean(lastResult) and Boolean.toJSBoolean(lastResult.networkStatus) then lastResult.networkStatus else NetworkStatus.ready
    local var4 = Object.assign({}, lastResult, { loading = isNetworkRequestInFlight(var1), networkStatus = var1 })

    if not tbl1.queryManager:transform(tbl1.options.query).hasForcedResolvers then
        local diff = tbl1.queryInfo:getDiff()

        if Boolean.toJSBoolean(diff.complete) or Boolean.toJSBoolean(tbl1.options.returnPartialData) then
            var4.data = diff.result
        else
            var4.data = nil
        end

        if Boolean.toJSBoolean(diff.complete) then
            if var4.networkStatus == NetworkStatus.loading and (var2 == "cache-first" or var2 == "cache-only") then
                var4.networkStatus = NetworkStatus.ready
                var4.loading = false
            end
            var4.partial = nil
        elseif var2 ~= "no-cache" then
            var4.partial = true
        end

        if not (Boolean.toJSBoolean(diff.complete)
            or Boolean.toJSBoolean(tbl1.options.partialRefetch)
            or Boolean.toJSBoolean(var4.loading)
            or Boolean.toJSBoolean(var4.data)
            or Boolean.toJSBoolean(var4.error)) then
            var4.error = ApolloError.new({ clientErrors = diff.missing })
        end
    end

    if bool2 then
        tbl1:updateLastResult(var4)
    end

    return var4
end

function ObservableQuery.isDifferentFromLastResult(arg1, arg2): boolean
    return not equal(arg1.lastResultSnapshot, arg2)
end

function ObservableQuery.getLastResult(arg1)
    return arg1.lastResult
end

function ObservableQuery.getLastError(arg1)
    return arg1.lastError
end

function ObservableQuery.resetLastResults(arg1)
    arg1.lastResult = nil
    arg1.lastResultSnapshot = nil
    arg1.lastError = nil
    arg1.isTornDown = false
end

function ObservableQuery.resetQueryStoreErrors(arg1)
    arg1.queryManager:resetErrors(arg1.queryId)
end

function ObservableQuery.refetch(arg1, arg2)
    local tbl1 = { pollInterval = 0 }

    local fetchPolicy = arg1.options.fetchPolicy
    if fetchPolicy == "no-cache" then
        tbl1.fetchPolicy = "no-cache"
    elseif fetchPolicy ~= "cache-and-network" then
        tbl1.fetchPolicy = "network-only"
    end

    if Boolean.toJSBoolean(arg2) and not equal(arg1.options.variables, arg2) then
        arg1.options.variables = Object.assign({}, arg1.options.variables, arg2)
        tbl1.variables = arg1.options.variables
    end

    arg1.queryInfo:resetLastWrite()
    return arg1:reobserve(tbl1, NetworkStatus.refetch)
end

function ObservableQuery.fetchMore(arg1, arg2)
    local var2 = Object.assign(
        {},
        if Boolean.toJSBoolean(arg2.query) then arg2 else Object.assign({}, arg1.options, arg2, { variables = Object.assign({}, arg1.options.variables, arg2.variables) }),
        { fetchPolicy = "no-cache" }
    )

    local var3 = arg1.queryManager:generateQueryId()

    if Boolean.toJSBoolean(var2.notifyOnNetworkStatusChange) then
        arg1.queryInfo.networkStatus = NetworkStatus.fetchMore
        arg1:observe()
    end

    return arg1.queryManager:fetchQuery(var3, var2, NetworkStatus.fetchMore):andThen(function(arg3)
        local data = arg3.data
        local updateQuery = arg2.updateQuery

        if not Boolean.toJSBoolean(updateQuery) then
            arg1.queryManager.cache:writeQuery({ query = var2.query, variables = var2.variables, data = data })

            return arg3
        end

        if _G.__DEV__ and not (bool1 and _G.__WARNED_ABOUT_OBSERVABLE_QUERY_UPDATE_QUERY__) then
            invariant.warn(
                "The updateQuery callback for fetchMore is deprecated, and will be removed\nin the next major version of Apollo Client.\n\nPlease convert updateQuery functions to field policies with appropriate\nread and merge functions, or use/adapt a helper function (such as\nconcatPagination, offsetLimitPagination, or relayStylePagination) from\n@apollo/client/utilities.\n\nThe field policy system handles pagination more effectively than a\nhand-written updateQuery function, and you only need to define the policy\nonce, rather than every time you call fetchMore."
            )

            bool1 = true
            _G.__WARNED_ABOUT_OBSERVABLE_QUERY_UPDATE_QUERY__ = bool1
        end

        arg1:updateQuery(function(arg4)
            return updateQuery(arg2, arg4, { fetchMoreResult = data, variables = var2.variables })
        end)

        return arg3
    end):andThen(function<T>(arg3: T): T
        arg1.queryManager:stopQuery(var3)
        arg1:reobserve()
        return arg3
    end):catch(function(arg3)
        arg1.queryManager:stopQuery(var3)
        arg1:reobserve()
        error(arg3)
    end)
end

function ObservableQuery.subscribeToMore(arg1, arg2)
    local var2 = arg1.queryManager:startGraphQLSubscription(
        {
            query = arg2.document,
            variables = arg2.variables,
            context = arg2.context
        }
    ):subscribe(
        {
            next = function(_, subscriptionData)
                local updateQuery = arg2.updateQuery
                if not Boolean.toJSBoolean(updateQuery) then
                    return
                end

                arg1:updateQuery(function(arg3, arg4)
                    local variables = arg4.variables
                    return updateQuery(arg3, { subscriptionData = subscriptionData, variables = variables })
                end)
            end,
            error = function(_, arg3)
                if Boolean.toJSBoolean(arg2.onError) then
                    arg2:onError(arg3)
                    return
                end
                invariant.error("Unhandled GraphQL subscription error", arg3)
            end
        }
    )
    arg1.subscriptions:add(var2)

    return function()
        if Boolean.toJSBoolean(arg1.subscriptions:delete(var2)) then
            var2:unsubscribe()
        end
    end
end

function ObservableQuery.setOptions(arg1, arg2)
    return arg1:reobserve(arg2)
end

function ObservableQuery.setVariables(arg1, variables)
    if equal(arg1.variables, variables) then
        if Boolean.toJSBoolean(arg1.observers.size) then
            return arg1:result()
        end
        return Promise.resolve()
    end

    arg1.options.variables = variables

    if not Boolean.toJSBoolean(arg1.observers.size) then
        return Promise.resolve()
    end

    return arg1:reobserve({ fetchPolicy = arg1.initialFetchPolicy, variables = variables }, NetworkStatus.setVariables)
end

function ObservableQuery.updateQuery(tbl1, func1: (...any) -> (...any))
    local queryManager = tbl1.queryManager

    local cache = queryManager.cache
    local tbl2 = {
        query = tbl1.options.query,
        variables = tbl1.variables,
        previousResult = if Boolean.toJSBoolean(tbl1.lastResult) then tbl1.lastResult.data or nil else nil,
        returnPartialData = true,
        optimistic = false
    }
    local var2 = func1(cache:diff(tbl2).result, { variables = tbl1.variables })

    if not Boolean.toJSBoolean(var2) then
        return
    end

    queryManager.cache:writeQuery({ query = tbl1.options.query, data = var2, variables = tbl1.variables })

    queryManager:broadcastQueries()
end

function ObservableQuery.startPolling(tbl1, pollInterval: number)
    tbl1.options.pollInterval = pollInterval
    tbl1:updatePolling()
end

function ObservableQuery.stopPolling(arg1)
    arg1.options.pollInterval = 0
    arg1:updatePolling()
end

function ObservableQuery.fetch(arg1, arg2, arg3)
    arg1.queryManager:setObservableQuery(arg1)
    return arg1.queryManager:fetchQueryObservable(arg1.queryId, arg2, arg3)
end

function ObservableQuery.updatePolling(arg1)
    local poll = nil

    if Boolean.toJSBoolean(arg1.queryManager.ssrMode) then
        return
    end

    local pollingInfo = arg1.pollingInfo
    local pollInterval = arg1.options.pollInterval

    if not Boolean.toJSBoolean(pollInterval) then
        if Boolean.toJSBoolean(pollingInfo) then
            clearTimeout(pollingInfo.timeout)
            arg1.pollingInfo = nil
        end

        return
    end

    if Boolean.toJSBoolean(pollingInfo) and pollingInfo.interval == pollInterval then
        return
    end

    invariant(pollInterval, "Attempted to start a polling query without a polling interval.")

    if not (Boolean.toJSBoolean(pollingInfo) and pollingInfo) then
        arg1.pollingInfo = {}
        pollingInfo = arg1.pollingInfo
    end
    pollingInfo.interval = pollInterval

    local function maybeFetch()
        if not Boolean.toJSBoolean(arg1.pollingInfo) then
            return
        end

        if not isNetworkRequestInFlight(arg1.queryInfo.networkStatus) then
            arg1:reobserve({ fetchPolicy = "network-only" }, NetworkStatus.poll):andThen(poll, poll)
            return
        end
        poll()
    end

    poll = function()
        local pollingInfo2 = arg1.pollingInfo
        if not Boolean.toJSBoolean(pollingInfo2) then
            return
        end
        if pollingInfo2.timeout then
            clearTimeout(pollingInfo2.timeout)
        end
        pollingInfo2.timeout = setTimeout(maybeFetch, pollingInfo2.interval)
    end

    poll()
end

function ObservableQuery.updateLastResult(arg1, arg2)
    local lastResult = arg1.lastResult
    arg1.lastResult = arg2

    if Boolean.toJSBoolean(arg1.queryManager.assumeImmutableResults) then
        arg1.lastResultSnapshot = arg2
    else
        arg1.lastResultSnapshot = cloneDeep(arg2)
    end

    if not isNonEmptyArray(arg2.errors) then
        arg1.lastError = nil
    end
    return lastResult
end

function ObservableQuery.reobserve(arg1, arg2, arg3)
    arg1.isTornDown = false

    local bool2 = arg3 == NetworkStatus.refetch or arg3 == NetworkStatus.fetchMore or arg3 == NetworkStatus.poll

    local variables = arg1.options.variables
    local var2 = if bool2 then compact(arg1.options, arg2) else Object.assign(arg1.options, compact(arg2))

    if not bool2 then
        arg1:updatePolling()

        if arg2 ~= nil
            and Boolean.toJSBoolean(arg2.variables)
            and not (Boolean.toJSBoolean(arg2.fetchPolicy) or equal(arg2.variables, variables))
        then
            var2.fetchPolicy = arg1.initialFetchPolicy
            if arg3 == nil then
                arg3 = NetworkStatus.setVariables
            end
        end
    end

    local concast = arg1:fetch(var2, arg3)

    if not bool2 then
        if arg1.concast then
            arg1.concast:removeObserver(arg1.observer, true)
        end

        arg1.concast = concast
    end

    concast:addObserver(arg1.observer)

    return concast.promise
end

function ObservableQuery.observe(arg1)
    arg1.observer:next(arg1:getCurrentResult(false))
end

function ObservableQuery.hasObservers(arg1): boolean
    return arg1.observers.size > 0
end

function ObservableQuery.tearDownQuery(arg1)
    if Boolean.toJSBoolean(arg1.isTornDown) then
        return
    end
    if Boolean.toJSBoolean(arg1.concast) then
        arg1.concast:removeObserver(arg1.observer)
        arg1.concast = nil
    end

    arg1:stopPolling()

    arg1.subscriptions:forEach(function(arg2)
        return arg2:unsubscribe()
    end)
    arg1.subscriptions:clear()
    arg1.queryManager:stopQuery(arg1.queryId)
    arg1.observers:clear()
    arg1.isTornDown = true
end

fixObservableSubclass(ObservableQuery)

module.ObservableQuery = ObservableQuery

defaultSubscriptionObserverErrorCallback = function(_, arg1)
    invariant.error("Unhandled error", arg1.message, arg1.stack)
end

function module.applyNextFetchPolicy(arg1)
    local var2 = if arg1.fetchPolicy == nil then "cache-first" else arg1.fetchPolicy

    local nextFetchPolicy = arg1.nextFetchPolicy

    if not Boolean.toJSBoolean(nextFetchPolicy) then
        return
    end

    if isCallable(nextFetchPolicy) then
        arg1.fetchPolicy = nextFetchPolicy(arg1, var2)
        return
    end
    arg1.fetchPolicy = nextFetchPolicy
end
return module

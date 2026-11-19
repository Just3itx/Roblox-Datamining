-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:40:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Promise = require(scriptParentParentParentParent.Promise)
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local hasOwnProperty = require(scriptParentParentParent.luaUtils.hasOwnProperty)

local equal = require(scriptParentParentParent.jsutils.equal)

local ApolloError = require(scriptParentParentParent.errors).ApolloError

local NetworkStatus = require(script.Parent.Parent.Parent.core).NetworkStatus

local _utilities = require(scriptParentParentParent.utilities)

local DocumentType = require(script.Parent.Parent.parser).DocumentType
local _types = require(script.Parent.Parent.types.types)

local OperationData = require(script.Parent.OperationData).OperationData

local QueryData = setmetatable({}, { __index = OperationData })
QueryData.__index = QueryData

function QueryData.new(tbl2)
    local options = tbl2.options
    local context = tbl2.context
    local onNewData = tbl2.onNewData
    local operationData = OperationData.new(options, context)
    operationData.runLazy = false
    operationData.previous = {}

    operationData.onNewData = onNewData

    function operationData.runLazyQuery(lazyOptions)
        operationData:cleanup()
        operationData.runLazy = true
        operationData.lazyOptions = lazyOptions
        operationData:onNewData()
    end

    function operationData.obsRefetch(_, tbl3)
        if Boolean.toJSBoolean(operationData.currentObservable) then
            return operationData.currentObservable:refetch(tbl3)
        end
        return nil
    end

    function operationData.obsFetchMore(_, arg1)
        if operationData.currentObservable then
            return (operationData.currentObservable:fetchMore(arg1))
        end

        return nil
    end

    function operationData.obsUpdateQuery(_, func1: (...any) -> (...any))
        if operationData.currentObservable then
            return (operationData.currentObservable:updateQuery(func1))
        end

        return nil
    end

    function operationData.obsStartPolling(_, num1: number)
        if operationData.currentObservable then
            return (operationData.currentObservable:startPolling(num1))
        end

        return nil
    end

    function operationData.obsStopPolling(_)
        if operationData.currentObservable then
            return (operationData.currentObservable:stopPolling())
        end

        return nil
    end

    function operationData.obsSubscribeToMore(arg1)
        if operationData.currentObservable then
            return (operationData.currentObservable:subscribeToMore(arg1))
        end

        return nil
    end

    return (setmetatable(operationData, QueryData))
end

function QueryData:execute()
    self:refreshClient()
    local options = self:getOptions()
    local skip = options.skip
    local query = options.query
    if skip or query ~= self.previous.query then
        self:removeQuerySubscription()
        self:removeObservable(not Boolean.toJSBoolean(skip))
        self.previous.query = query
    end
    self:updateObservableQuery()
    return self:getExecuteSsrResult() or self:getExecuteResult()
end

function QueryData:executeLazy()
    if Boolean.toJSBoolean(self.runLazy) then
        return table.pack(self.runLazyQuery, self:execute())
    end

    return table.pack(self.runLazyQuery, { loading = false, networkStatus = NetworkStatus.ready, called = false, data = nil })
end

function QueryData.fetchData(arg1)
    local options = arg1:getOptions()
    if Boolean.toJSBoolean(Boolean.toJSBoolean(options.skip) and options.skip or options.ssr == false) then
        return false
    end
    return Promise.new(function(arg2)
        return arg1:startQuerySubscription(arg2)
    end)
end

function QueryData:afterExecute(tbl2)
    local tbl3 = tbl2 or {}
    local lazy = if tbl3.lazy then tbl3.lazy else false
    self.isMounted = true
    local previousOptions = self:getOptions()
    local bool1 = previousOptions.ssr == false

    if Boolean.toJSBoolean(self.currentObservable)
        and not (Boolean.toJSBoolean(bool1) or Boolean.toJSBoolean(self:ssrInitiated()))
    then
        self:startQuerySubscription()
    end
    if not Boolean.toJSBoolean(lazy) or Boolean.toJSBoolean(self.runLazy) then
        self:handleErrorOrCompleted()
    end
    self.previousOptions = previousOptions
    return function(...)
        return self:unmount(...)
    end
end

function QueryData:cleanup()
    self:removeQuerySubscription()
    self:removeObservable(true)
    self.previous.result = nil
end

function QueryData:getOptions()
    local var2 = getmetatable((getmetatable(self))).__index.getOptions(self)

    if Boolean.toJSBoolean(self.lazyOptions) then
        var2.variables = Object.assign({}, var2.variables, self.lazyOptions.variables)
        var2.context = Object.assign({}, var2.context, self.lazyOptions.context)
    end

    if Boolean.toJSBoolean(self.runLazy) then
        self.options.skip = nil
    end
    return var2
end

function QueryData:ssrInitiated()
    return if Boolean.toJSBoolean(self.context) then self.context.renderPromises else self.context
end

function QueryData:getExecuteSsrResult()
    local options = self:getOptions()
    local ssr = options.ssr
    local skip = options.skip

    local disableNetworkFetches = self:refreshClient().client.disableNetworkFetches
    local var2 = Object.assign({}, {
        loading = true,
        networkStatus = NetworkStatus.loading,
        called = true,
        data = nil,
        stale = false,
        client = self.client
    }, self:observableQueryFields())

    if Boolean.toJSBoolean(ssr == false)
        and (Boolean.toJSBoolean(self:ssrInitiated()) or Boolean.toJSBoolean(disableNetworkFetches))
    then
        self.previous.result = var2
        return var2
    end
    if not Boolean.toJSBoolean(self:ssrInitiated()) then
        return nil
    end

    if Boolean.toJSBoolean(self:getExecuteResult()) then
        var2 = self:getExecuteResult() or var2
    end

    if Boolean.toJSBoolean(var2.loading) and not Boolean.toJSBoolean(skip) then
        self.context.renderPromises:addQueryPromise(self, function()
            return nil
        end)
    end
    return var2
end

function QueryData:prepareObservableQueryOptions()
    local options = self:getOptions()
    self:verifyDocumentType(options.query, DocumentType.Query)
    local displayName = Boolean.toJSBoolean(options.displayName) and options.displayName or "Query"

    if Boolean.toJSBoolean(self:ssrInitiated())
        and (options.fetchPolicy == "network-only" or options.fetchPolicy == "cache-and-network")
    then
        options.fetchPolicy = "cache-first"
    end
    return Object.assign({}, options, { displayName = displayName, context = options.context })
end

function QueryData:initializeObservableQuery()
    if Boolean.toJSBoolean(self:ssrInitiated()) then
        self.currentObservable = self.context.renderPromises:getSSRObservable(self:getOptions())
    end
    if Boolean.toJSBoolean(self.currentObservable) then
        return
    end

    local var2 = self:prepareObservableQueryOptions()
    self.previous.observableQueryOptions = Object.assign({}, var2, { children = Object.None })
    self.currentObservable = self:refreshClient().client:watchQuery(Object.assign({}, var2))
    if Boolean.toJSBoolean(self:ssrInitiated()) then
        self.context.renderPromises:registerSSRObservable(self.currentObservable, var2)
    end
end

function QueryData:updateObservableQuery()
    if not Boolean.toJSBoolean(self.currentObservable) then
        self:initializeObservableQuery()
        return
    end
    local observableQueryOptions = Object.assign({}, self:prepareObservableQueryOptions(), { children = Object.None })

    if Boolean.toJSBoolean(self:getOptions().skip) then
        self.previous.observableQueryOptions = observableQueryOptions
        return
    end
    if not equal(observableQueryOptions, self.previous.observableQueryOptions) then
        self.previous.observableQueryOptions = observableQueryOptions

        self.currentObservable:setOptions(observableQueryOptions):catch(function() end)
    end
end

function QueryData:startQuerySubscription(func1: ((...any) -> (...any))?)
    if func1 == nil then
        func1 = self.onNewData
    end
    if Boolean.toJSBoolean(self.currentSubscription) or Boolean.toJSBoolean(self:getOptions().skip) then
        return
    end
    self.currentSubscription = self.currentObservable:subscribe({
        next = function(_, arg1)
            local loading = arg1.loading
            local networkStatus = arg1.networkStatus
            local data = arg1.data
            local result = self.previous.result

            if Boolean.toJSBoolean(result)
                and result.loading == loading
                and result.networkStatus == networkStatus
                and equal(result.data, data)
            then
                return
            end

            func1(self)
        end,
        error = function(_, error2)
            self:resubscribeToQuery()
            if not hasOwnProperty(error2, "graphQLErrors") then
                error(error2)
            end
            local result = self.previous.result

            if Boolean.toJSBoolean(result) and Boolean.toJSBoolean(result.loading) or not equal(error2, self.previous.error) then
                self.previous.error = error2
                func1(self)
            end
        end
    })
end

function QueryData:resubscribeToQuery()
    self:removeQuerySubscription()

    local currentObservable = self.currentObservable
    if not Boolean.toJSBoolean(currentObservable) then
        return
    end

    local lastError = currentObservable:getLastError()
    local lastResult = currentObservable:getLastResult()
    currentObservable:resetLastResults()
    self:startQuerySubscription()
    Object.assign(currentObservable, { lastError = lastError, lastResult = lastResult })
end

function QueryData:getExecuteResult()
    local var2 = self:observableQueryFields()
    local options = self:getOptions()

    if Boolean.toJSBoolean(options.skip) then
        var2 = Object.assign(
            {},
            var2,
            {
                data = Object.None,
                error = Object.None,
                loading = false,
                networkStatus = NetworkStatus.ready,
                called = true
            }
        )
    elseif Boolean.toJSBoolean(self.currentObservable) then
        local currentResult = self.currentObservable:getCurrentResult()

        local data = currentResult.data
        local loading = currentResult.loading
        local partial = currentResult.partial
        local networkStatus = currentResult.networkStatus
        local errors = currentResult.errors
        local error = currentResult.error

        if Boolean.toJSBoolean(errors) and #errors > 0 then
            error = ApolloError.new({ graphQLErrors = errors })
        end
        var2 = Object.assign({}, var2, { data = data, loading = loading, networkStatus = networkStatus, error = error, called = true })

        if not Boolean.toJSBoolean(loading) then
            if Boolean.toJSBoolean(error) then
                Object.assign(var2, { data = (self.currentObservable:getLastResult() or {}).data })
            else
                local fetchPolicy = self.currentObservable.options.fetchPolicy
                local partialRefetch = options.partialRefetch

                if Boolean.toJSBoolean(partialRefetch)
                    and Boolean.toJSBoolean(partial)
                    and (not Boolean.toJSBoolean(data) or #Object.keys(data) == 0)
                    and fetchPolicy ~= "cache-only"
                then
                    Object.assign(var2, { loading = true, networkStatus = NetworkStatus.loading })
                    var2:refetch()
                    return var2
                end
            end
        end
    end

    var2.client = self.client

    self:setOptions(options, true)
    local result = self.previous.result
    if Boolean.toJSBoolean(result) and Boolean.toJSBoolean(result.loading) then
        self.previous.loading = result.loading
    else
        self.previous.loading = false
    end

    if Boolean.toJSBoolean(result) then
        var2.previousData = Boolean.toJSBoolean(result.data) and result.data or result.previousData
    else
        var2.previousData = result
    end
    self.previous.result = var2

    if Boolean.toJSBoolean(self.currentObservable) then
        self.currentObservable:resetQueryStoreErrors()
    end
    return var2
end

function QueryData:handleErrorOrCompleted()
    if not (self.currentObservable and self.previous.result) then
        return
    end

    local result = self.previous.result
    local data = result.data
    local loading = result.loading
    local error = result.error
    if Boolean.toJSBoolean(loading) then
        return
    end

    local options = self:getOptions()

    local query = options.query
    local variables = options.variables
    local onCompleted = options.onCompleted
    local onError = options.onError
    local skip = options.skip

    if Boolean.toJSBoolean(self.previousOptions)
        and not Boolean.toJSBoolean(self.previous.loading)
        and equal(self.previousOptions.query, query)
        and equal(self.previousOptions.variables, variables)
    then
        return
    end
    if Boolean.toJSBoolean(onCompleted) and not (Boolean.toJSBoolean(error) or Boolean.toJSBoolean(skip)) then
        onCompleted(data)
        return
    end

    if Boolean.toJSBoolean(onError) and Boolean.toJSBoolean(error) then
        onError(error)
    end
end

function QueryData:removeQuerySubscription()
    if Boolean.toJSBoolean(self.currentSubscription) then
        self.currentSubscription:unsubscribe()
        self.currentSubscription = nil
    end
end

function QueryData:removeObservable(bool1: boolean)
    if not Boolean.toJSBoolean(self.currentObservable) then
        return
    end

    self.currentObservable.tearDownQuery(self.currentObservable)
    if Boolean.toJSBoolean(bool1) then
        self.currentObservable = nil
    end
end

function QueryData:observableQueryFields()
    return {
        variables = if Boolean.toJSBoolean(self.currentObservable) then self.currentObservable.variables else nil,
        refetch = self.obsRefetch,
        fetchMore = self.obsFetchMore,
        updateQuery = self.obsUpdateQuery,
        startPolling = self.obsStartPolling,
        stopPolling = self.obsStopPolling,
        subscribeToMore = self.obsSubscribeToMore
    }
end

tbl1.QueryData = QueryData
return tbl1

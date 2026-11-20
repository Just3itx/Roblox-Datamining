-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local Boolean = LuauPolyfill.Boolean
local clearTimeout = LuauPolyfill.clearTimeout
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local setTimeout = LuauPolyfill.setTimeout
local WeakMap = LuauPolyfill.WeakMap

local _GraphQL = require(scriptParentParentParent.GraphQL)

local equal = require(scriptParentParent.jsutils.equal)

local _cache = require(scriptParentParent.cache)

local _watchQueryOptions_types = require(script.Parent.watchQueryOptions_types)

local _ObservableQuery_types = require(script.Parent.ObservableQuery_types)

local _core = require(script.Parent.Parent.link.core)

local utilities = require(script.Parent.Parent.utilities)

local isNonEmptyArray = utilities.isNonEmptyArray
local graphQLResultHasError = utilities.graphQLResultHasError
local canUseWeakMap = utilities.canUseWeakMap
local networkStatus = require(script.Parent.networkStatus)
local NetworkStatus = networkStatus.NetworkStatus

local isNetworkRequestInFlight = networkStatus.isNetworkRequestInFlight

local _errors = require(script.Parent.Parent.errors)

local CacheWriteBehavior = { FORBID = 0, OVERWRITE = 1, MERGE = 2 }

tbl1.CacheWriteBehavior = CacheWriteBehavior
local var1 = if canUseWeakMap then WeakMap.new() else Map.new(nil)

local function wrapDestructiveCacheMethod(cache, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = cache[str1]
    if typeof(var2) == "function" then
        cache[str1] = function(...)
            var1:set(cache, (var1:get(cache) + 1) % 1000000000000000)

            return var2(...)
        end
    end
end

local function cancelNotifyTimeout(tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    if Boolean.toJSBoolean(tbl3.notifyTimeout) then
        clearTimeout(tbl3.notifyTimeout)
        tbl3.notifyTimeout = nil
    end
end

local QueryInfo = {}
QueryInfo.__index = QueryInfo

function QueryInfo.new(cache)
    local tbl4 = {
        listeners = Set.new(),
        document = nil,
        lastRequestId = 1,
        subscriptions = Set.new(),
        stopped = false,
        cache = cache,
        dirty = false,
        observableQuery = nil
    }

    if not var1:has(cache) then
        var1:set(cache, 0)
        wrapDestructiveCacheMethod(cache, "evict")
        wrapDestructiveCacheMethod(cache, "modify")
        wrapDestructiveCacheMethod(cache, "reset")
    end

    return (setmetatable(tbl4, QueryInfo))
end

function QueryInfo:init(tbl4)
    local var2 = Boolean.toJSBoolean(tbl4.networkStatus) and tbl4.networkStatus or NetworkStatus.loading

    if Boolean.toJSBoolean(self.variables)
        and self.networkStatus ~= NetworkStatus.loading
        and not equal(self.variables, tbl4.variables)
    then
        var2 = NetworkStatus.setVariables
    end
    if not equal(tbl4.variables, self.variables) then
        self.lastDiff = nil
    end
    Object.assign(self, {
        document = tbl4.document,
        variables = tbl4.variables,
        networkError = Object.None,
        graphQLErrors = not Boolean.toJSBoolean(self.graphQLErrors) and {} or self.graphQLErrors or {},
        networkStatus = var2
    })

    if Boolean.toJSBoolean(tbl4.observableQuery) then
        self:setObservableQuery(tbl4.observableQuery)
    end

    if Boolean.toJSBoolean(tbl4.lastRequestId) then
        self.lastRequestId = tbl4.lastRequestId
    end
    return self
end

function QueryInfo:reset()
    cancelNotifyTimeout(self)
    self.lastDiff = nil
    self.dirty = false
end

function QueryInfo:getDiff(variables)
    if variables == nil then
        variables = self.variables
    end

    local diffOptions = self:getDiffOptions(variables)

    if Boolean.toJSBoolean(self.lastDiff) and equal(diffOptions, self.lastDiff.options) then
        return self.lastDiff.diff
    end

    self.variables = variables
    self:updateWatch(self.variables)

    local observableQuery = self.observableQuery

    if Boolean.toJSBoolean(observableQuery) and observableQuery.options.fetchPolicy == "no-cache" then
        return { complete = false }
    end

    local var2 = self.cache:diff(diffOptions)
    self:updateLastDiff(var2, diffOptions)
    return var2
end

function QueryInfo:updateLastDiff(diff, arg1)
    self.lastDiff = Boolean.toJSBoolean(diff) and {
        diff = diff,
        options = Boolean.toJSBoolean(arg1) and arg1 or self:getDiffOptions()
    }
        or nil
end

function QueryInfo:getDiffOptions(variables)
    if variables == nil then
        variables = self.variables
    end

    local observableQuery = self.observableQuery

    return {
        query = self.document,
        variables = variables,
        returnPartialData = true,
        optimistic = true,
        canonizeResults = not Boolean.toJSBoolean(observableQuery) or observableQuery.options.canonizeResults ~= false
    }
end

function QueryInfo:setDiff(arg1)
    local var2 = if Boolean.toJSBoolean(self.lastDiff) then self.lastDiff.diff else self.lastDiff
    self:updateLastDiff(arg1)

    if Boolean.toJSBoolean(var2) then
        var2 = var2.result
    end

    if Boolean.toJSBoolean(arg1) then
        arg1 = arg1.result
    end

    if self.dirty or equal(var2, arg1) then
        return
    end

    self.dirty = true
    if not Boolean.toJSBoolean(self.notifyTimeout) then
        self.notifyTimeout = setTimeout(function()
            return self:notify()
        end, 0)
    end
end

function QueryInfo:setObservableQuery(observableQuery)
    if observableQuery == self.observableQuery then
        return
    end

    if Boolean.toJSBoolean(self.oqListener) then
        self.listeners:delete(self.oqListener)
    end

    self.observableQuery = observableQuery

    if not Boolean.toJSBoolean(observableQuery) or observableQuery == nil then
        self.oqListener = nil

        return
    end

    observableQuery.queryInfo = self
    function self.oqListener()
        if Boolean.toJSBoolean(self:getDiff().fromOptimisticTransaction) then
            observableQuery.observe(observableQuery)
            return
        end
        observableQuery:reobserve()
    end

    self.listeners:add(self.oqListener)
end

function QueryInfo:notify()
    cancelNotifyTimeout(self)

    if self:shouldNotify() then
        self.listeners:forEach(function(arg1)
            return arg1(self)
        end)
    end
    self.dirty = false
end

function QueryInfo:shouldNotify()
    if not (self.dirty and Boolean.toJSBoolean(self.listeners.size)) then
        return false
    end

    if isNetworkRequestInFlight(self.networkStatus) and Boolean.toJSBoolean(self.observableQuery) then
        local fetchPolicy = self.observableQuery.options.fetchPolicy
        if fetchPolicy ~= "cache-only" and fetchPolicy ~= "cache-and-network" then
            return false
        end
    end
    return true
end

function QueryInfo:stop()
    if self.stopped then
        return
    end

    self.stopped = true

    self:reset()
    self:cancel()

    self.cancel = QueryInfo.cancel

    self.subscriptions:forEach(function(arg1)
        return arg1:unsubscribe()
    end)

    local observableQuery = self.observableQuery

    if Boolean.toJSBoolean(observableQuery) then
        observableQuery:stopPolling()
    end
end

function QueryInfo:cancel() end

function QueryInfo:updateWatch(arg1)
    if arg1 == nil then
        arg1 = self.variables
    end

    local observableQuery = self.observableQuery

    if Boolean.toJSBoolean(observableQuery) and observableQuery.options.fetchPolicy == "no-cache" then
        return
    end

    local lastWatch = Object.assign({}, self:getDiffOptions(arg1), {
        watcher = self,
        callback = function(_, arg2)
            return self:setDiff(arg2)
        end
    })

    local var3 = Object.assign({}, lastWatch, { callback = Object.None })
    local var4 = Object.assign({}, self.lastWatch, { callback = Object.None })
    if not (Boolean.toJSBoolean(self.lastWatch) and equal(var3, var4)) then
        self:cancel()
        self.lastWatch = lastWatch
        self.cancel = self.cache:watch(self.lastWatch)
    end
end

function QueryInfo.resetLastWrite(arg1)
    arg1.lastWrite = nil
end

function QueryInfo:shouldWrite(arg1, tbl4): boolean
    local lastWrite = self.lastWrite

    local var2 = Boolean.toJSBoolean(lastWrite)

    if var2 then
        if lastWrite.dmCount == var1:get(self.cache) then
            var2 = equal(tbl4, lastWrite.variables) and equal(arg1.data, lastWrite.result.data)
        else
            var2 = false
        end
    end

    return not var2
end

local shouldWriteResult = nil

function QueryInfo:markResult(arg1, tbl4, num1: number)
    if isNonEmptyArray(arg1.errors) then
        self.graphQLErrors = arg1.errors
    else
        self.graphQLErrors = {}
    end

    self:reset()

    if tbl4.fetchPolicy == "no-cache" then
        self:updateLastDiff({ result = arg1.data, complete = true }, self:getDiffOptions(tbl4.variables))
        return
    end

    if num1 == CacheWriteBehavior.FORBID then
        return
    end

    if not shouldWriteResult(arg1, tbl4.errorPolicy) then
        self.lastWrite = nil
        return
    end

    self.cache:performTransaction(function(arg2)
        if self:shouldWrite(arg1, tbl4.variables) then
            arg2:writeQuery({
                query = self.document,
                data = arg1.data,
                variables = tbl4.variables,
                overwrite = num1 == CacheWriteBehavior.OVERWRITE
            })
            self.lastWrite = {
                result = arg1,
                variables = tbl4.variables,
                dmCount = var1:get(self.cache)
            }
        elseif Boolean.toJSBoolean(self.lastDiff) and Boolean.toJSBoolean(self.lastDiff.diff.complete) then
            arg1.data = self.lastDiff.diff.result
            return
        end

        local diffOptions = self:getDiffOptions(tbl4.variables)
        local var2 = arg2:diff(diffOptions)

        if not self.stopped then
            self:updateWatch(tbl4.variables)
        end

        self:updateLastDiff(var2, diffOptions)
        if Boolean.toJSBoolean(var2.complete) then
            arg1.data = var2.result
        end
    end)
end

function QueryInfo.markReady(arg1)
    arg1.networkError = nil
    arg1.networkStatus = NetworkStatus.ready
    return arg1.networkStatus
end

function QueryInfo.markError(arg1, arg2)
    arg1.networkStatus = NetworkStatus.error
    arg1.lastWrite = nil

    arg1:reset()

    if Boolean.toJSBoolean(arg2.graphQLErrors) then
        arg1.graphQLErrors = arg2.graphQLErrors
    end

    if Boolean.toJSBoolean(arg2.networkError) then
        arg1.networkError = arg2.networkError
    end

    return arg2
end
tbl1.QueryInfo = QueryInfo

shouldWriteResult = function(arg1, arg2): boolean
    arg2 = if arg2 == nil then "none" else arg2

    local bool1 = not graphQLResultHasError(arg1)

    if not bool1 and (arg2 == "ignore" or arg2 == "all") and Boolean.toJSBoolean(arg1.data) then
        bool1 = true
    end

    return bool1
end
tbl1.shouldWriteResult = shouldWriteResult

return tbl1

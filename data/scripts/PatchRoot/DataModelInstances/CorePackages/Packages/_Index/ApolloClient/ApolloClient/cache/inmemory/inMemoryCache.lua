-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:20:31Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local instanceof = LuauPolyfill.instanceof
local NULL = require(scriptParentParentParent.utilities).NULL

local Promise = require(scriptParentParentParentParent.Promise)

local tbl1 = {}

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local wrap = require(scriptParentParentParent.optimism).wrap
local equal = require(scriptParentParentParent.jsutils.equal)

local ApolloCache = require(script.Parent.Parent.core.cache).ApolloCache

local _Cache = require(script.Parent.Parent.core.types.Cache)

local MissingFieldError = require(script.Parent.Parent.core.types.common).MissingFieldError

local utilities = require(script.Parent.Parent.Parent.utilities)
local addTypenameToDocument = utilities.addTypenameToDocument

local isReference = utilities.isReference
local _types = require(script.Parent.types)

local StoreReader = require(script.Parent.readFromStore).StoreReader

local StoreWriter = require(script.Parent.writeToStore).StoreWriter

local entityStore = require(script.Parent.entityStore)

local EntityStore_Root = entityStore.EntityStore_Root
local supportsResultCaching = entityStore.supportsResultCaching
local reactiveVars = require(script.Parent.reactiveVars)
local makeVar = reactiveVars.makeVar
local forgetCache = reactiveVars.forgetCache
local recallCache = reactiveVars.recallCache
local policies = require(script.Parent.policies)
local defaultDataIdFromObject = policies.defaultDataIdFromObject

local Policies = policies.Policies

local hasOwn = require(script.Parent.helpers).hasOwn
local canonicalStringify = require(script.Parent["object-canon"]).canonicalStringify

local tbl2 = {
    dataIdFromObject = defaultDataIdFromObject,
    addTypename = true,
    resultCaching = true,
    typePolicies = {}
}

local InMemoryCache = setmetatable({}, { __index = ApolloCache })
InMemoryCache.__index = InMemoryCache
function InMemoryCache.new(arg1)
    local self = setmetatable(ApolloCache.new(), InMemoryCache)

    self.watches = Set.new()

    self.typenameDocumentCache = Map.new(nil)
    self.makeVar = makeVar
    self.txCount = 0
    self.config = Object.assign({}, tbl2, arg1 == nil and {} or arg1)

    self.addTypename = self.config.addTypename

    self.policies = Policies.new({
        cache = self,
        dataIdFromObject = self.config.dataIdFromObject,
        possibleTypes = self.config.possibleTypes,
        typePolicies = self.config.typePolicies
    })

    self:init()

    return self
end

function InMemoryCache:init()
    self.data = EntityStore_Root.new({ policies = self.policies, resultCaching = self.config.resultCaching })

    self.optimisticData = self.data.stump

    self:resetResultCache()
end

function InMemoryCache:resetResultCache(bool1: boolean?)
    local storeReader = self.storeReader

    local new = StoreReader.new
    local tbl3 = {
        cache = self,
        addTypename = self.addTypename,
        resultCacheMaxSize = self.config.resultCacheMaxSize,
        canon = if bool1 or not storeReader then nil else storeReader.canon
    }
    self.storeReader = new(tbl3)

    self.storeWriter = StoreWriter.new(self, self.storeReader)

    self.maybeBroadcastWatch = wrap(function(_, arg1, arg2)
        return self:broadcastWatch(arg1, arg2)
    end, {
        max = self.config.resultCacheMaxSize,
        makeCacheKey = function(_, arg1)
            local var2 = if arg1.optimistic then self.optimisticData else self.data

            if not supportsResultCaching(var2) then
                return
            end

            local optimistic = arg1.optimistic
            local rootId = arg1.rootId
            local variables = arg1.variables
            return var2:makeCacheKey(
                arg1.query,
                arg1.callback,
                canonicalStringify({ optimistic = optimistic, rootId = rootId, variables = variables })
            )
        end
    }, self)

    Set.new({ self.data.group, self.optimisticData.group }):forEach(function(arg1)
        return arg1:resetCaching()
    end)
end

function InMemoryCache.restore(arg1, arg2)
    arg1:init()

    if arg2 then
        arg1.data:replace(arg2)
    end
    return arg1
end

function InMemoryCache.extract(tbl3, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    if bool1 then
        return tbl3.optimisticData:extract()
    end
    return tbl3.data:extract()
end

function InMemoryCache.read(arg1, arg2)
    local returnPartialData = not (arg2.returnPartialData == nil) and arg2.returnPartialData

    local success, result = pcall(function()
        return arg1.storeReader:diffQueryAgainstStore(
            Object.assign({}, arg2, {
                store = arg2.optimistic and arg1.optimisticData or arg1.data,
                config = arg1.config,
                returnPartialData = returnPartialData
            })
        ).result
            or NULL
    end)

    if not success then
        if instanceof(result, MissingFieldError) then
            return NULL
        end
        error(result)
    end
    return result
end

function InMemoryCache:write(arg1)
    local success, result = pcall(function()
        local var2 = self
        var2.txCount += 1
        return self.storeWriter:writeToStore(self.data, arg1)
    end)

    self.txCount -= 1

    if self.txCount == 0 and arg1.broadcast ~= false then
        self:broadcastWatches()
    end

    if not success then
        error(result)
    end
    return result
end

function InMemoryCache:modify(arg1): boolean
    if hasOwn(arg1, "id") and not arg1.id then
        return false
    end

    local var2 = if arg1.optimistic then self.optimisticData else self.data

    local success, result = pcall(function()
        local var3 = self
        var3.txCount += 1

        return var2:modify(arg1.id or "ROOT_QUERY", arg1.fields)
    end)

    self.txCount -= 1

    if self.txCount == 0 and arg1.broadcast ~= false then
        self:broadcastWatches()
    end

    if not success then
        error(result)
    end
    return result
end

function InMemoryCache:diff(arg1)
    return self.storeReader:diffQueryAgainstStore(
        Object.assign(
            {},
            arg1,
            {
                store = arg1.optimistic and self.optimisticData or self.data,
                rootId = arg1.id or "ROOT_QUERY",
                config = self.config
            }
        )
    )
end

function InMemoryCache:watch(arg1)
    if self.watches.size == 0 then
        recallCache(self)
    end
    self.watches:add(arg1)
    if arg1.immediate then
        self:maybeBroadcastWatch(arg1)
    end
    return function()
        if self.watches:delete(arg1) and self.watches.size == 0 then
            forgetCache(self)
        end

        self.maybeBroadcastWatch:forget(arg1)
    end
end

function InMemoryCache:gc(tbl3)
    canonicalStringify:reset()
    local var2 = self.optimisticData:gc()

    if tbl3 and self.txCount == 0 then
        if tbl3.resetResultCache then
            self:resetResultCache(tbl3.resetResultIdentities)
            return var2
        end

        if tbl3.resetResultIdentities then
            self.storeReader:resetCanon()
        end
    end
    return var2
end

function InMemoryCache.retain(tbl3, str1: string, bool1: boolean?)
    if bool1 then
        return tbl3.optimisticData:retain(str1)
    end
    return tbl3.data:retain(str1)
end

function InMemoryCache.release(tbl3, str1: string, bool1: boolean?)
    if bool1 then
        return tbl3.optimisticData:release(str1)
    end
    return tbl3.data:release(str1)
end

function InMemoryCache:identify(arg1)
    if isReference(arg1) then
        return arg1.__ref
    end

    return self.policies:identify(arg1)[1]
end

function InMemoryCache:evict(arg1)
    if not arg1.id then
        if hasOwn(arg1, "id") then
            return false
        end

        arg1 = Object.assign(table.clone(arg1), { id = "ROOT_QUERY" })
    end

    local success, result = pcall(function()
        local var2 = self
        var2.txCount += 1
        return self.optimisticData:evict(arg1)
    end)

    self.txCount -= 1

    if self.txCount == 0 and arg1.broadcast ~= false then
        self:broadcastWatches()
    end

    if not success then
        error(result)
    end
    return result
end

function InMemoryCache.reset(arg1)
    arg1:init()
    arg1:broadcastWatches()
    canonicalStringify:reset()
    return Promise.delay(0)
end

function InMemoryCache.removeOptimistic(tbl3, str1: string)
    local optimisticData = tbl3.optimisticData:removeLayer(str1)
    if optimisticData ~= tbl3.optimisticData then
        tbl3.optimisticData = optimisticData
        tbl3:broadcastWatches()
    end
end

function InMemoryCache:batch(arg1)
    local var2 = arg1.optimistic == nil or arg1.optimistic
    local removeOptimistic = arg1.removeOptimistic
    local onWatchUpdated = arg1.onWatchUpdated

    local function perform(optimisticData)
        local data = self.data
        local optimisticData2 = self.optimisticData
        local var3 = self
        var3.txCount += 1
        if optimisticData then
            self.optimisticData = optimisticData
            self.data = self.optimisticData
        end

        local success, result = pcall(arg1.update, arg1, self)

        local var4 = self
        var4.txCount -= 1
        self.data = data
        self.optimisticData = optimisticData2

        if not success then
            error(result)
        end
    end

    local set = Set.new()

    if onWatchUpdated and self.txCount == 0 then
        local assign = Object.assign
        local var3 = table.clone(arg1)

        self:broadcastWatches(assign(var3, {
            onWatchUpdated = function(_, arg2): boolean
                set:add(arg2)
                return false
            end
        }))
    end

    if typeof(var2) == "string" then
        self.optimisticData = self.optimisticData:addLayer(var2, perform)
    elseif var2 == false then
        perform(self.data)
    else
        perform()
    end

    if typeof(removeOptimistic) == "string" then
        self.optimisticData = self.optimisticData:removeLayer(removeOptimistic)
    end

    if not onWatchUpdated or not (set.size > 0) then
        self:broadcastWatches(arg1)
        return
    end

    local assign = Object.assign
    local var3 = table.clone(arg1)

    self:broadcastWatches(assign(var3, {
        onWatchUpdated = function(arg2, arg3, arg4)
            local var4 = onWatchUpdated(arg2, arg3, arg4)
            if var4 ~= false then
                set:delete(arg3)
            end
            return var4
        end
    }))

    if set.size > 0 then
        set:forEach(function(arg2)
            return self.maybeBroadcastWatch:dirty(arg2)
        end)
    end
end

function InMemoryCache.performTransaction(tbl3, func1: (...any) -> (...any), optimistic)
    return tbl3:batch({
        update = function(_, ...)
            return func1(...)
        end,
        optimistic = optimistic or optimistic ~= NULL
    })
end

function InMemoryCache:transformDocument(arg1)
    if not self.addTypename then
        return arg1
    end

    local var2 = self.typenameDocumentCache:get(arg1)
    if not var2 then
        var2 = addTypenameToDocument(arg1)
        self.typenameDocumentCache:set(arg1, var2)

        self.typenameDocumentCache:set(var2, var2)
    end
    return var2
end

function InMemoryCache:broadcastWatches(arg1)
    if self.txCount == 0 then
        self.watches:forEach(function(arg2)
            return self:maybeBroadcastWatch(arg2, arg1)
        end)
    end
end

function InMemoryCache:broadcastWatch(arg1, arg2)
    local lastDiff = arg1.lastDiff
    local var1 = self:diff({ query = arg1.query, variables = arg1.variables, optimistic = arg1.optimistic })
    if arg2 then
        if arg1.optimistic and typeof(arg2.optimistic) == "string" then
            var1.fromOptimisticTransaction = true
        end

        local onWatchUpdated = arg2.onWatchUpdated
        if onWatchUpdated and onWatchUpdated(self, arg1, var1, lastDiff) == false then
            return
        end
    end

    if not (lastDiff and equal(lastDiff.result, var1.result)) then
        arg1.lastDiff = var1
        arg1:callback(arg1.lastDiff, lastDiff)
    end
end

tbl1.InMemoryCache = InMemoryCache

return tbl1

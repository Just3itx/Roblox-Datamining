-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local LuauPolyfill = require(scriptParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local instanceof = LuauPolyfill.instanceof
local setTimeout = LuauPolyfill.setTimeout

local Error = LuauPolyfill.Error
local Error2 = LuauPolyfill.Error
local Promise = require(scriptParent.Promise)

local tbl1 = {}

local getCurrentBatch = nil
local getValidMaxBatchSize = nil
local dispatchBatch = nil
local failedDispatch = nil
local resolveCacheHits = nil
local getValidBatchScheduleFn = nil
local getValidCacheKeyFn = nil
local getValidCacheMap = nil
local getValidName = nil
local isArrayLike = nil

local DataLoader = ({})

DataLoader.__index = DataLoader

function DataLoader.new(_batchLoadFn: (...any) -> (...any), tbl3)
    local self = setmetatable({}, DataLoader)
    if typeof(_batchLoadFn) ~= "function" then
        error(
            Error.new(
                "DataLoader must be constructed with a function which accepts " .. ("Array<key> and returns Promise<Array<value>>, but got: %s."):format(tostring(_batchLoadFn))
            )
        )
    end
    self._batchLoadFn = _batchLoadFn
    self._maxBatchSize = getValidMaxBatchSize(tbl3)
    self._batchScheduleFn = getValidBatchScheduleFn(tbl3)
    self._cacheKeyFn = getValidCacheKeyFn(tbl3)
    self._cacheMap = getValidCacheMap(tbl3)
    self._batch = nil
    self.name = getValidName(tbl3)
    return self
end

function DataLoader:load(arg1)
    if arg1 == nil then
        error(Error.new("The loader.load() function must be called with a value, " .. ("but got: %s."):format(tostring(arg1))))
    end

    local currentBatch = getCurrentBatch(self)
    local _cacheMap = self._cacheMap
    local var1 = self._cacheKeyFn(arg1)

    if Boolean.toJSBoolean(_cacheMap) then
        local var2 = _cacheMap:get(var1)
        if Boolean.toJSBoolean(var2) then
            local cacheHits = Boolean.toJSBoolean(currentBatch.cacheHits) and currentBatch.cacheHits

            if not cacheHits then
                currentBatch.cacheHits = {}
                cacheHits = currentBatch.cacheHits
            end
            return Promise.new(function(callback)
                table.insert(cacheHits, function()
                    callback(var2)
                end)
            end)
        end
    end

    table.insert(currentBatch.keys, arg1)
    local promise = Promise.new(function(resolve, reject)
        table.insert(currentBatch.callbacks, { resolve = resolve, reject = reject })
    end)

    if Boolean.toJSBoolean(_cacheMap) then
        _cacheMap:set(var1, promise)
    end
    return promise
end

function DataLoader.loadMany(arg1, arg2)
    local var1, var2

    if Boolean.toJSBoolean(isArrayLike(arg2)) then
        var1 = 0
        var2 = {}
    else
        error(
            Error.new("The loader.loadMany() function must be called with Array<key> " .. ("but got: %s."):format(tostring(arg2)))
        )
        var1 = 0
        var2 = {}
    end

    while var1 < #arg2 do
        local var3 = arg1:load(arg2[var1 + 1])

        table.insert(var2, var3:catch(function<T>(arg3: T): T
            return arg3
        end))

        var1 += 1
    end

    return Promise.all(var2)
end

function DataLoader:clear(arg1)
    local _cacheMap = self._cacheMap
    if Boolean.toJSBoolean(_cacheMap) then
        _cacheMap:delete((self._cacheKeyFn(arg1)))
    end
    return self
end

function DataLoader:clearAll()
    local _cacheMap = self._cacheMap
    if Boolean.toJSBoolean(_cacheMap) then
        _cacheMap:clear()
    end
    return self
end

function DataLoader:prime(arg1, arg2)
    local _cacheMap = self._cacheMap
    if Boolean.toJSBoolean(_cacheMap) then
        local var1 = self._cacheKeyFn(arg1)

        if _cacheMap:get(var1) == nil then
            local var2

            if instanceof(arg2, Error2) then
                var2 = Promise.reject(arg2)

                var2:catch(function() end)
            else
                var2 = Promise.resolve(arg2)
            end
            _cacheMap:set(var1, var2)
        end
    end
    return self
end

local function func1(arg1)
    setTimeout(arg1)
end

getCurrentBatch = function(tbl3)
    local _batch = tbl3._batch
    if _batch ~= nil and not Boolean.toJSBoolean(_batch.hasDispatched) and #_batch.keys < tbl3._maxBatchSize then
        return _batch
    end

    local tbl2 = {
        hasDispatched = false,
        keys = {},
        callbacks = {}
    }
    tbl3._batch = tbl2

    tbl3._batchScheduleFn(function()
        dispatchBatch(tbl3, tbl2)
    end)
    return tbl2
end

dispatchBatch = function(tbl3, tbl4)
    tbl4.hasDispatched = true

    if #tbl4.keys == 0 then
        resolveCacheHits(tbl4)
        return
    end

    local var1 = nil

    local _success, result, result2 = xpcall(function()
        var1 = tbl3._batchLoadFn(tbl4.keys)
    end, function(arg1)
        return failedDispatch(
            tbl3,
            tbl4,
            Error.new(
                "DataLoader must be constructed with a function which accepts " .. "Array<key> and returns Promise<Array<value>>, but the function " .. ("errored synchronously: %s."):format(tostring(arg1))
            )
        ), true
    end)
    if result2 then
        return result
    end

    if not Boolean.toJSBoolean(var1) or typeof(var1.andThen) ~= "function" then
        return failedDispatch(
            tbl3,
            tbl4,
            Error.new(
                "DataLoader must be constructed with a function which accepts " .. "Array<key> and returns Promise<Array<value>>, but the function did " .. ("not return a Promise: %s."):format(tostring(var1))
            )
        )
    end

    var1:andThen(function(arg1)
        if not Boolean.toJSBoolean(isArrayLike(arg1)) then
            error(
                Error.new(
                    "DataLoader must be constructed with a function which accepts " .. "Array<key> and returns Promise<Array<value>>, but the function did " .. ("not return a Promise of an Array: %s."):format(table.concat(arg1, ","))
                )
            )
        end
        if #arg1 ~= #tbl4.keys then
            error(
                Error.new(
                    "DataLoader must be constructed with a function which accepts "
                        .. "Array<key> and returns Promise<Array<value>>, but the function did "
                            .. "not return a Promise of an Array of the same length as the Array " .. "of keys." .. ("\n\nKeys:\n%s"):format(table.concat(tbl4.keys, ",")) .. ("\n\nValues:\n%s"):format(table.concat(arg1, ","))
                )
            )
        end

        resolveCacheHits(tbl4)
        local num1 = 0

        while num1 < #tbl4.callbacks do
            local var2 = arg1[num1 + 1]
            if instanceof(var2, Error2) then
                tbl4.callbacks[num1 + 1].reject(var2)
            else
                tbl4.callbacks[num1 + 1].resolve(var2)
            end

            num1 += 1
        end
    end):catch(function(arg1)
        failedDispatch(tbl3, tbl4, arg1)
    end)
    return nil
end

failedDispatch = function(tbl3, tbl4, arg1)
    resolveCacheHits(tbl4)
    local num1 = 0

    while num1 < #tbl4.keys do
        tbl3:clear(tbl4.keys[num1 + 1])
        tbl4.callbacks[num1 + 1].reject(arg1)

        num1 += 1
    end
end

resolveCacheHits = function(tbl3)
    if not Boolean.toJSBoolean(tbl3.cacheHits) then
        return
    end

    local num1 = 0

    while num1 < #tbl3.cacheHits do
        tbl3.cacheHits[num1 + 1]()

        num1 += 1
    end
end

getValidMaxBatchSize = function(tbl3)
    local bool1 = not Boolean.toJSBoolean(tbl3) or tbl3.batch ~= false
    if not Boolean.toJSBoolean(bool1) then
        return 1
    end
    if Boolean.toJSBoolean(tbl3) then
        tbl3 = tbl3.maxBatchSize
    end
    if tbl3 == nil then
        return math.huge
    end
    if typeof(tbl3) ~= "number" or tbl3 < 1 then
        error(Error.new(("maxBatchSize must be a positive number: %s"):format(tostring(tbl3))))
    end
    return tbl3
end

getValidBatchScheduleFn = function(tbl3)
    if Boolean.toJSBoolean(tbl3) then
        tbl3 = tbl3.batchScheduleFn
    end
    if tbl3 == nil then
        return func1
    end
    if typeof(tbl3) ~= "function" then
        error(Error.new(("batchScheduleFn must be a function: %s"):format(tostring(tbl3))))
    end
    return tbl3
end

getValidCacheKeyFn = function(tbl3)
    if Boolean.toJSBoolean(tbl3) then
        tbl3 = tbl3.cacheKeyFn
    end

    if tbl3 == nil then
        return function<T>(arg1: T): T
            return arg1
        end
    end
    if typeof(tbl3) ~= "function" then
        error(Error.new(("cacheKeyFn must be a function: %s"):format(tostring(tbl3))))
    end
    return tbl3
end

getValidCacheMap = function(tbl3)
    local bool1 = not Boolean.toJSBoolean(tbl3) or tbl3.cache ~= false
    if not Boolean.toJSBoolean(bool1) then
        return nil
    end
    if Boolean.toJSBoolean(tbl3) then
        tbl3 = tbl3.cacheMap
    end

    if tbl3 == nil then
        return Map.new()
    end
    if tbl3 ~= nil then
        local var1 = Array.filter({
            "get",
            "set",
            "delete",
            "clear"
        }, function(arg1)
            if not Boolean.toJSBoolean(tbl3) then
                return tbl3
            end

            return typeof(tbl3[tostring(arg1)]) ~= "function"
        end)
        if #var1 ~= 0 then
            error(Error.new("Custom cacheMap missing methods: " .. tostring(Array.join(var1, ", "))))
        end
    end
    return tbl3
end

getValidName = function(tbl3)
    return if Boolean.toJSBoolean(if Boolean.toJSBoolean(tbl3) then tbl3.name else tbl3) then tbl3.name else nil
end

isArrayLike = function(arg1): boolean
    return not (typeof(arg1) ~= "table") and (#arg1 == 0 or #arg1 > 0 and arg1[#arg1] ~= nil)
end

tbl1.DataLoader = DataLoader
return tbl1

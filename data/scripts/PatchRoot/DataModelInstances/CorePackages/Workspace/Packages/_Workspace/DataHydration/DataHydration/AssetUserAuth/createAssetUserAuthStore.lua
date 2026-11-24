-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local Promise = require(DataHydrationParent.Promise)

local fetchAssetUserAuth = require(script.Parent.fetchAssetUserAuth)
local _AssetUserAuthStoreTypes = require(script.Parent.AssetUserAuthStoreTypes)

local function ALWAYS_REFRESH(): boolean
    return true
end

local function createAssetUserAuthStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(str1: string, _)
            return fetchAssetUserAuth.fetchOperation(str1, tbl3)
        end
    })

    local function refreshOperation(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        return fetchAssetUserAuth.fetchOperation(str1, tbl3):andThen(function<T>(arg1: T): T
            cache.updateItem(str1, arg1)
            return arg1
        end)
    end

    local function seedAndReturn(arg1)
        local path = arg1.path
        if typeof(path) == "string" and #path > 0 then
            local var1 = string.match(path, "operations/(.+)$") or path
            cache.updateItem(var1, arg1)
        end
        return arg1
    end

    return {
        patchAssetIcon = function(str1: string, arg1)
            return fetchAssetUserAuth.patchAssetIcon(str1, arg1, tbl3):andThen(function(arg2)
                local path = arg2.path
                if typeof(path) == "string" and #path > 0 then
                    local var1 = string.match(path, "operations/(.+)$") or path
                    cache.updateItem(var1, arg2)
                end
                return arg2
            end)
        end,
        updateIcon = function(str1: string, str2: string)
            return fetchAssetUserAuth.updateIcon(str1, str2, tbl3):andThen(seedAndReturn)
        end,
        getPreviews = function(str1: string)
            return fetchAssetUserAuth.getPreviews(str1, tbl3)
        end,
        updatePreviews = function(str1: string, tbl4)
            return fetchAssetUserAuth.updatePreviews(str1, tbl4, tbl3):andThen(seedAndReturn)
        end,
        createImageAsset = function(str1: string, str2: string, arg1)
            return fetchAssetUserAuth.createImageAsset(str1, str2, arg1, tbl3):andThen(seedAndReturn)
        end,
        pollUntilDone = function(arg1)
            local var1

            if typeof(arg1) == "string" then
                var1 = arg1
            else
                local path = arg1.path or ""
                var1 = string.match(path, "operations/(.+)$") or arg1.operationId or path
            end
            return Promise.new(function(callback, callback2)
                local num1 = 0
                local num2 = 0

                local function poll()
                    num1 += 1

                    refreshOperation(var1):andThen(function(operation)
                        num2 = 0
                        if operation.done then
                            if operation.error then
                                callback2(operation.error.message or "Operation failed")
                                return
                            end
                            callback({ status = "done", operation = operation })
                        elseif num1 >= 30 then
                            callback({ status = "timed_out", operationId = var1 })
                        else
                            task.delay(2, poll)
                        end
                    end):catch(function(arg2)
                        num2 += 1
                        if num2 <= 3 then
                            local num3 = math.pow(2, num2 - 1) * 2
                            task.delay(num3, poll)
                            return
                        end
                        callback2(arg2)
                    end)
                end

                poll()
            end)
        end,
        getOperation = dataResolver.getCachedItem,
        fetchOperation = dataResolver.fetchItem,
        getAndFetchOperation = function(str1: string)
            return dataResolver.getAndFetchItem(str1, ALWAYS_REFRESH)
        end,
        refreshOperation = refreshOperation,
        updateOperation = cache.updateItem,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createAssetUserAuthStore

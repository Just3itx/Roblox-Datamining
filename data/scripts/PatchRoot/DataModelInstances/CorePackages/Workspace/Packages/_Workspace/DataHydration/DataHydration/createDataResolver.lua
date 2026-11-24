-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)
local getLocalPlayerUserId = DataHydrationUtils.getLocalPlayerUserId
local observeLocalPlayerUserId = DataHydrationUtils.observeLocalPlayerUserId
local createRequestQueue = require(DataHydration.createRequestQueue)
local createMutationLayer = require(DataHydration.createMutationLayer)
local Promise = require(DataHydrationParent.Promise)
local Signals = require(DataHydrationParent.Signals)
local FFlagDataHydrationAccountReset = require(DataHydrationParent.SharedFlags).FFlagDataHydrationAccountReset
local FFlagSduiReleaseSearchResultsPageState = require(DataHydrationParent.SharedFlags).FFlagSduiReleaseSearchResultsPageState
local FFlagBuildExperienceMonetizationMultiKind = require(DataHydration.Flags.FFlagBuildExperienceMonetizationMultiKind)

local num1 = game:DefineFastInt("LuaAppDataHydrationDefaultBatchSize", 50)
local num2 = game:DefineFastInt("LuaAppDataHydrationQueueProcessDelaySec", 1)

local num3 = game:DefineFastInt("LuaAppDataHydrationDefaultRequestTimeoutSec", 30)

local function createDataResolver(tbl1)
    local var1 = tbl1.supportsMultiGet == nil or tbl1.supportsMultiGet
    local var2 = tbl1.requestBatchSize or num1
    if not var1 then
        var2 = if tbl1.requestBatchSize then var2 else 1
    end
    local var3 = tbl1.queueProcessDelaySec or num2
    if not var1 then
        var3 = if tbl1.queueProcessDelaySec then var3 else 0
    end
    local var4 = tbl1.requestTimeoutSec or num3
    local cache = tbl1.cache
    local requestQueue = createRequestQueue()

    local tbl2 = ({})

    local tbl3 = ({})
    local var5 = nil
    local localPlayerUserId = getLocalPlayerUserId()
    local signal = nil
    local var6 = nil
    local signal2 = nil
    local var7 = nil
    if FFlagDataHydrationAccountReset then
        signal, var6 = Signals.createSignal(0)
    end
    if FFlagBuildExperienceMonetizationMultiKind then
        signal2, var7 = Signals.createSignal(0)
    end

    local mutationLayer = if tbl1.supportsMutations then createMutationLayer() else nil

    local function FORCE_FETCH(): boolean
        return true
    end

    local function logError(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl1.logError then
            tbl1.logError(str1)
        end
    end

    local function isCurrentRequest(num4: number?, num5: number?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return num5 == signal(false) and num4 == getLocalPlayerUserId()
    end

    local function snapshotEpochs(tbl4) -- Luacid: Inlined by compiler; 4 call sites recovered
        local result = ({})
        for _, value in tbl4 do
            result[value] = tbl3[value] or 0
        end
        return result
    end

    local function filterCurrentIds(tbl4, tbl5)
        local result = {}
        for _, value in tbl4 do
            if tbl5[value] == (tbl3[value] or 0) then
                table.insert(result, value)
            end
        end
        return result
    end

    local function handleFailure(str1: string, tbl4, num4: number?, num5: number?, tbl5)
        if FFlagDataHydrationAccountReset then
            if not isCurrentRequest(num4, num5) then
                return
            end
        elseif num4 ~= localPlayerUserId then
            return
        end

        local tbl6 = filterCurrentIds(tbl4, tbl5)
        if #tbl6 == 0 then
            return
        end

        logError(str1)

        for _, value in tbl6 do
            tbl2[value] = nil
        end
        cache.markItemsAsFailed(tbl6)

        if mutationLayer then
            mutationLayer.drainCommitted(tbl6, cache.updateItem)
        end
    end

    local function handleSuccess(tbl4, tbl5, num4: number?, num5: number?, tbl6)
        if FFlagDataHydrationAccountReset then
            if not isCurrentRequest(num4, num5) then
                return
            end
        elseif num4 ~= localPlayerUserId then
            return
        end

        local tbl7 = filterCurrentIds(tbl5, tbl6)
        local tbl8 = ({})
        for value, value2 in tbl4 do
            if tbl6[value] == nil or tbl6[value] == (tbl3[value] or 0) then
                tbl8[value] = value2
            end
        end

        for value, _ in tbl8 do
            tbl2[value] = nil
        end
        if tbl1.replaceItems then
            cache.replaceItems(tbl8)
        else
            cache.updateItems(tbl8)
        end

        local tbl9 = {}

        for _, value in tbl7 do
            if tbl8[value] ~= nil then
                continue
            end

            if mutationLayer and mutationLayer.isCommitted(value) then
                tbl2[value] = nil
            else
                table.insert(tbl9, value)
            end
        end

        if mutationLayer then
            mutationLayer.drainCommitted(tbl7, cache.updateItem)
        end

        if #tbl9 > 0 then
            handleFailure("Items missing in response", tbl9, num4, num5, tbl6)
        end
    end

    local function scheduleFetch() -- Luacid: Inlined by compiler; 1 call site recovered
        if var5 ~= nil or requestQueue.isEmpty() then
            return
        end

        var5 = task.delay(var3, function()
            local var8 = localPlayerUserId
            local var9 = if FFlagDataHydrationAccountReset then signal(false) else nil
            var5 = nil

            if requestQueue.isEmpty() then
                return
            end

            local var10 = requestQueue.pop(var2)
            for _, value in var10 do
                tbl2[value] = true
            end

            local tbl4 = snapshotEpochs(var10)
            local items = cache.getItems(var10)

            local bool1 = false

            local var11 = task.delay(var4, function()
                if tbl1.ignoreResponsesAfterTimeout then
                    bool1 = true
                end
                handleFailure(`No fetch response after {var4} sec`, var10, var8, var9, tbl4)
            end)

            local success, result = pcall(function()
                if var1 then
                    tbl1.fetchFn(items):andThen(function(tbl5)
                        if bool1 then
                            return
                        end
                        handleSuccess(tbl5, var10, var8, var9, tbl4)
                        task.cancel(var11)
                    end):catch(function(arg1)
                        if bool1 then
                            return
                        end
                        handleFailure(arg1, var10, var8, var9, tbl4)
                        task.cancel(var11)
                    end)

                    return
                end

                local tbl5 = {}
                for _, value in var10 do
                    local item = items[value]
                    table.insert(tbl5, tbl1.fetchFn(value, item))
                end

                Promise.all(tbl5):andThen(function(arg1)
                    if bool1 then
                        return
                    end
                    local tbl6 = ({})
                    for value, value2 in var10 do
                        tbl6[value2] = arg1[value]
                    end
                    handleSuccess(tbl6, var10, var8, var9, tbl4)
                    task.cancel(var11)
                end):catch(function(arg1)
                    if bool1 then
                        return
                    end
                    handleFailure(arg1, var10, var8, var9, tbl4)
                    task.cancel(var11)
                end)
            end)

            if not success then
                handleFailure(result, var10, var8, var9, tbl4)
                task.cancel(var11)
            end

            scheduleFetch()
        end)
    end

    local function isRequestInQueueOrInFlight(str1: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        return if requestQueue.hasItem(str1) then true else tbl2[str1] ~= nil
    end

    local function getAndFetchItems(tbl4, func1: ((...any) -> (...any))?, num4: number?)
        local var8, var9 = cache.getItems(tbl4, func1, num4)
        local andFetchItems = ({})
        local tbl5 = {}
        for value, value2 in var8 do
            andFetchItems[value] = value2

            if var9[value] and not isRequestInQueueOrInFlight(value) then
                requestQueue.push(value)
                table.insert(tbl5, value)
            end
        end

        if #tbl5 > 0 then
            cache.resetFailedItems(tbl5)
        end

        if not requestQueue.isEmpty() and var5 == nil then
            if requestQueue.isEmpty() then
                return andFetchItems
            end

            var5 = task.delay(var3, function()
                local var10 = localPlayerUserId
                local var11 = if FFlagDataHydrationAccountReset then signal(false) else nil
                var5 = nil

                if requestQueue.isEmpty() then
                    return
                end

                local var12 = requestQueue.pop(var2)
                for _, value in var12 do
                    tbl2[value] = true
                end

                local tbl6 = snapshotEpochs(var12)
                local items = cache.getItems(var12)

                local bool1 = false

                local var13 = task.delay(var4, function()
                    if tbl1.ignoreResponsesAfterTimeout then
                        bool1 = true
                    end
                    handleFailure(`No fetch response after {var4} sec`, var12, var10, var11, tbl6)
                end)

                local success, result = pcall(function()
                    if var1 then
                        tbl1.fetchFn(items):andThen(function(tbl7)
                            if bool1 then
                                return
                            end
                            handleSuccess(tbl7, var12, var10, var11, tbl6)
                            task.cancel(var13)
                        end):catch(function(arg1)
                            if bool1 then
                                return
                            end
                            handleFailure(arg1, var12, var10, var11, tbl6)
                            task.cancel(var13)
                        end)

                        return
                    end

                    local tbl7 = {}
                    for _, value in var12 do
                        local item = items[value]
                        table.insert(tbl7, tbl1.fetchFn(value, item))
                    end

                    Promise.all(tbl7):andThen(function(arg1)
                        if bool1 then
                            return
                        end
                        local tbl8 = ({})
                        for value, value2 in var12 do
                            tbl8[value2] = arg1[value]
                        end
                        handleSuccess(tbl8, var12, var10, var11, tbl6)
                        task.cancel(var13)
                    end):catch(function(arg1)
                        if bool1 then
                            return
                        end
                        handleFailure(arg1, var12, var10, var11, tbl6)
                        task.cancel(var13)
                    end)
                end)

                if not success then
                    handleFailure(result, var12, var10, var11, tbl6)
                    task.cancel(var13)
                end

                scheduleFetch()
            end)
        end
        return andFetchItems
    end

    local function getAndFetchItem(str1: string, func1: ((...any) -> (...any))?, num4: number?)
        local var8, var9 = cache.getItem(str1, func1, num4)

        if var9 and not isRequestInQueueOrInFlight(str1) then
            cache.resetFailedItem(str1)
            requestQueue.push(str1)
        end

        if not requestQueue.isEmpty() and var5 == nil then
            if requestQueue.isEmpty() then
                return var8, var9
            end

            var5 = task.delay(var3, function()
                local var10 = localPlayerUserId
                local var11 = if FFlagDataHydrationAccountReset then signal(false) else nil
                var5 = nil

                if requestQueue.isEmpty() then
                    return
                end

                local var12 = requestQueue.pop(var2)
                for _, value in var12 do
                    tbl2[value] = true
                end

                local tbl4 = snapshotEpochs(var12)
                local items = cache.getItems(var12)

                local bool1 = false

                local var13 = task.delay(var4, function()
                    if tbl1.ignoreResponsesAfterTimeout then
                        bool1 = true
                    end
                    handleFailure(`No fetch response after {var4} sec`, var12, var10, var11, tbl4)
                end)

                local success, result = pcall(function()
                    if var1 then
                        tbl1.fetchFn(items):andThen(function(tbl5)
                            if bool1 then
                                return
                            end
                            handleSuccess(tbl5, var12, var10, var11, tbl4)
                            task.cancel(var13)
                        end):catch(function(arg1)
                            if bool1 then
                                return
                            end
                            handleFailure(arg1, var12, var10, var11, tbl4)
                            task.cancel(var13)
                        end)

                        return
                    end

                    local tbl5 = {}
                    for _, value in var12 do
                        local item = items[value]
                        table.insert(tbl5, tbl1.fetchFn(value, item))
                    end

                    Promise.all(tbl5):andThen(function(arg1)
                        if bool1 then
                            return
                        end
                        local tbl6 = ({})
                        for value, value2 in var12 do
                            tbl6[value2] = arg1[value]
                        end
                        handleSuccess(tbl6, var12, var10, var11, tbl4)
                        task.cancel(var13)
                    end):catch(function(arg1)
                        if bool1 then
                            return
                        end
                        handleFailure(arg1, var12, var10, var11, tbl4)
                        task.cancel(var13)
                    end)
                end)

                if not success then
                    handleFailure(result, var12, var10, var11, tbl4)
                    task.cancel(var13)
                end

                scheduleFetch()
            end)
        end
        return var8, var9
    end

    local function getCachedItem(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        return cache.getItem(str1)
    end

    local function getCachedItems(tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
        return cache.getItems(tbl4)
    end

    local function fetchItem(str1: string, func1: ((...any) -> (...any))?)
        return getAndFetchItem(str1, func1 or FORCE_FETCH)
    end

    local function fetchItems(tbl4, func1: ((...any) -> (...any))?)
        return (getAndFetchItems(tbl4, func1 or FORCE_FETCH))
    end

    local function refetchItem(str1: string)
        tbl3[str1] = (tbl3[str1] or 0) + 1
        tbl2[str1] = nil
        cache.resetFailedItem(str1)
        if not requestQueue.hasItem(str1) then
            requestQueue.push(str1)
        end

        scheduleFetch()
        return cache.getItem(str1)
    end

    local function releaseItem(str1: string)
        requestQueue.remove(str1)
        if tbl2[str1] then
            tbl2[str1] = nil

            tbl3[str1] = (tbl3[str1] or 0) + 1
        end
        if cache.removeItem then
            cache.removeItem(str1)
        end
    end

    local function clearResolverState(bool1: boolean)
        if FFlagDataHydrationAccountReset then
            var6(signal(false) + 1)
        end
        if var5 then
            task.cancel(var5)
            var5 = nil
        end
        tbl2 = {}
        if not FFlagDataHydrationAccountReset then
            cache.clear()
            requestQueue.clear()
            if mutationLayer then
                mutationLayer.clearAll()
            end
            if tbl1.onClear then
                tbl1.onClear()
            end

            return
        end

        requestQueue.clear()
        if mutationLayer then
            mutationLayer.clearAll()
        end
        if tbl1.onBeforeClear then
            tbl1.onBeforeClear()
        end

        if not bool1 then
            cache.clear()
        end

        if tbl1.onClear then
            tbl1.onClear()
        end
    end

    local function clear() -- Luacid: Inlined by compiler; 2 call sites recovered
        clearResolverState(false)
    end

    local connection = nil
    local var8 = nil
    if FFlagDataHydrationAccountReset then
        var8 = observeLocalPlayerUserId(function(arg1)
            localPlayerUserId = arg1
            clearResolverState(tbl1.keepCacheOnAccountReset == true)
            if FFlagBuildExperienceMonetizationMultiKind then
                var7(signal2(false) + 1)
            end
        end)
    else
        connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
            local localPlayerUserId2 = getLocalPlayerUserId()
            if localPlayerUserId2 == localPlayerUserId then
                return
            end

            localPlayerUserId = localPlayerUserId2
            clear()

            if FFlagBuildExperienceMonetizationMultiKind then
                var7(signal2(false) + 1)
            end
        end)
    end

    local function dispose()
        if var8 then
            var8()
            var8 = nil
        end
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if FFlagDataHydrationAccountReset then
            clear()
        end

        cache.dispose()
    end

    local tbl4 = {
        getAndFetchItems = getAndFetchItems,
        getAndFetchItem = getAndFetchItem,
        getCachedItem = getCachedItem,
        getCachedItems = getCachedItems,
        fetchItem = fetchItem,
        fetchItems = fetchItems,
        refetchItem = refetchItem,
        isRequestInQueueOrInFlight = isRequestInQueueOrInFlight,
        releaseItem = 0,
        dispose = 0,
        clear = 0,
        getAccountGeneration = 0,
        getAccountResetGeneration = 0,
        isCurrentRequest = 0
    }

    if not FFlagSduiReleaseSearchResultsPageState then
        releaseItem = nil
    end

    tbl4.releaseItem = releaseItem
    tbl4.dispose = dispose
    tbl4.clear = clear
    tbl4.getAccountGeneration = if FFlagDataHydrationAccountReset then signal else nil
    tbl4.getAccountResetGeneration = if FFlagBuildExperienceMonetizationMultiKind then signal2 else nil

    tbl4.isCurrentRequest = if FFlagDataHydrationAccountReset then isCurrentRequest else nil

    if mutationLayer then
        function tbl4.getOptimisticCachedItem(str1: string)
            local var9, var10 = getCachedItem(str1)
            return mutationLayer.getMergedResult(str1, var9), var10
        end

        function tbl4.getOptimisticCachedItems(tbl5)
            local var9, var10 = getCachedItems(tbl5)
            local tbl6 = ({})
            for value, value2 in var9 do
                tbl6[value] = mutationLayer.getMergedResult(value, value2)
            end
            return tbl6, var10
        end

        function tbl4.getOptimisticAndFetchItem(str1: string, func1: ((...any) -> (...any))?, num4: number?)
            local var9, var10 = getAndFetchItem(str1, func1, num4)
            return mutationLayer.getMergedResult(str1, var9), var10
        end

        function tbl4.getOptimisticAndFetchItems(tbl5, func1: ((...any) -> (...any))?, num4: number?)
            local result = ({})

            for value, value2 in (getAndFetchItems(tbl5, func1, num4)) do
                result[value] = mutationLayer.getMergedResult(value, value2)
            end
            return result
        end

        function tbl4.setMutation(str1: string, arg1)
            mutationLayer.set(str1, arg1)
        end

        function tbl4.clearMutation(str1: string)
            mutationLayer.clear(str1)
        end

        function tbl4.commitMutation(str1: string)
            if isRequestInQueueOrInFlight(str1) then
                mutationLayer.markCommitted(str1)
                return
            end
            local var9 = mutationLayer.get(str1)
            if var9 ~= nil then
                cache.updateItem(str1, var9)
            end
            mutationLayer.clear(str1)
        end
    end

    return tbl4
end
return createDataResolver

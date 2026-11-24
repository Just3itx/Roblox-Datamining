-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local _LuauPolyfill = require(DataHydrationParent.LuauPolyfill)
local logResponseError = DiscoveryUtils.logResponseError

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MarketplaceItemFavoriteStoreTypes = require(script.Parent.MarketplaceItemFavoriteStoreTypes)
local MarketplaceItemFavoriteUrlBuilder = require(script.Parent.MarketplaceItemFavoriteUrlBuilder)
local fetchMarketplaceItemFavorite = require(script.Parent.fetchMarketplaceItemFavorite)
local requestMarketplaceItemFavoriteUpdate = require(script.Parent.requestMarketplaceItemFavoriteUpdate)

local function getStatusCode(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if type(arg1) == "table" then arg1.StatusCode else nil
end

local function createMarketplaceItemFavoriteStore(arg1)
    local itemType = arg1.itemType
    local endpointName = MarketplaceItemFavoriteUrlBuilder.getEndpointName(itemType)
    local tbl1 = ({})
    local tbl2 = ({})

    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        supportsMutations = true,
        logError = function(arg2)
            logResponseError(endpointName, arg2)
        end,
        onClear = function()
            table.clear(tbl1)
        end,
        fetchFn = function(str1: string, _)
            local var1 = tbl2[str1]
            return fetchMarketplaceItemFavorite(itemType, str1):andThen(function(arg2)
                if tbl2[str1] ~= var1 then
                    return cache.getItem(str1).data(false)
                end

                return {
                    isFavorited = arg2.responseBody ~= nil
                }
            end)
        end
    })
    local function getServerFavorited(str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
        local var1 = cache.getItem(str1).data(false)
        return if var1 then var1.isFavorited else nil
    end

    local function showFavoriteCount(str1: string, tbl3, baselineFavorited: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        local baselineCount = tbl3.baselineCount
        if baselineCount == nil or arg1.setFavoriteCount == nil then
            return
        end
        local num1 = if baselineFavorited == tbl3.baselineFavorited then 0 elseif baselineFavorited then 1 else -1

        arg1.setFavoriteCount(str1, math.max(0, baselineCount + num1))
    end

    local function finishToggle(str1: string, tbl3, type: string)
        tbl1[str1] = nil
        dataResolver.clearMutation(str1)
        local isFavorited = getServerFavorited(str1)

        if isFavorited == nil then
            return
        end

        showFavoriteCount(str1, tbl3, isFavorited)
        local onSettled = tbl3.callbacks and tbl3.callbacks.onSettled
        if tbl3.hasWritten and onSettled then
            onSettled({ type = type, isFavorited = isFavorited })
        end
    end

    local writeDesired = nil

    local function continueToggle(str1: string, tbl3, type: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        if tbl3.desired == getServerFavorited(str1) then
            finishToggle(str1, tbl3, type)
            return
        end
        writeDesired(str1, tbl3)
    end

    writeDesired = function(str1: string, tbl3)
        local desired = tbl3.desired
        tbl3.isWriting = true
        tbl3.hasWritten = true
        local onWriteStart = tbl3.callbacks and tbl3.callbacks.onWriteStart
        if onWriteStart then
            onWriteStart(desired)
        end

        requestMarketplaceItemFavoriteUpdate(itemType, str1, desired):andThen(function()
            if tbl1[str1] ~= tbl3 then
                return
            end
            tbl3.isWriting = false
            tbl2[str1] = (tbl2[str1] or 0) + 1
            cache.updateItem(str1, { isFavorited = desired })
            continueToggle(str1, tbl3, "success")
        end):catch(function(arg2)
            if tbl1[str1] ~= tbl3 then
                return
            end
            tbl3.isWriting = false
            logResponseError(endpointName, { StatusCode = getStatusCode(arg2) })
            if tbl3.desired == desired then
                finishToggle(str1, tbl3, "error")
                return
            end

            continueToggle(str1, tbl3, "success")
        end)
    end

    return {
        getFavorite = function(str1: string)
            return dataResolver.getOptimisticCachedItem(str1)
        end,
        getAndFetchFavorite = function(str1: string)
            return dataResolver.getOptimisticAndFetchItem(str1)
        end,
        toggleFavorite = function(str1: string, callbacks): boolean
            local var1 = dataResolver.getOptimisticCachedItem(str1).data(false)
            if var1 == nil then
                return false
            end
            local baselineFavorited = not var1.isFavorited

            local tbl3 = tbl1[str1]
            if tbl3 == nil then
                tbl3 = {
                    desired = baselineFavorited,
                    isWriting = false,
                    hasWritten = false,
                    baselineFavorited = var1.isFavorited,
                    baselineCount = if arg1.getFavoriteCount then arg1.getFavoriteCount(str1) else nil,
                    callbacks = callbacks
                }
                tbl1[str1] = tbl3
            else
                tbl3.desired = baselineFavorited
                if callbacks then
                    tbl3.callbacks = callbacks
                end
            end

            dataResolver.setMutation(str1, { isFavorited = baselineFavorited })
            showFavoriteCount(str1, tbl3, baselineFavorited)

            if not tbl3.isWriting then
                continueToggle(str1, tbl3, "success")
            end

            return true
        end,
        updateItems = cache.updateItems,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createMarketplaceItemFavoriteStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local FavoritesStoreTypes = require(script.Parent.FavoritesStoreTypes)
local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger
local fetchFavorite = require(script.Parent.fetchFavorite)
local requestFavoriteUpdate = require(script.Parent.requestFavoriteUpdate)
local Signals = require(DataHydrationParent.Signals)
local FavoritesUrlBuilder = require(script.Parent.FavoritesUrlBuilder)
local _LuauPolyfill = require(DataHydrationParent.LuauPolyfill)

local FFlagLuaAppDataHydrationUpdateItem = require(DataHydrationParent.SharedFlags).FFlagLuaAppDataHydrationUpdateItem

local function createFavoritesStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        logError = function(arg1)
            logResponseError(FavoritesUrlBuilder.FAVORITE_URL, arg1)
        end,
        fetchFn = function(universeId: string, _)
            return fetchFavorite(universeId):andThen(function(arg1)
                local responseBody = arg1.responseBody
                if not FavoritesStoreTypes.favoriteResponseValidator(responseBody) then
                    DiscoveryEventErrorLogger.reportError(
                        "createFavoritesStore",
                        "Invalid favorite response",
                        { universeId = universeId, responseBody = responseBody }
                    )
                    error({ StatusCode = arg1.responseCode })
                end
                return {
                    isFavorited = responseBody.isFavorited
                }
            end)
        end
    })

    local function clear()
        cache.clear()
        dataResolver.clear()
    end

    local function dispose()
        dataResolver.dispose()
    end

    return {
        fetchFavorite = dataResolver.fetchItem,
        fetchFavorites = dataResolver.fetchItems,
        getFavorite = dataResolver.getCachedItem,
        getFavorites = dataResolver.getCachedItems,
        getAndFetchFavorite = dataResolver.getAndFetchItem,
        getAndFetchFavorites = dataResolver.getAndFetchItems,
        updateFavorite = function(universeId: string, isFavorited: boolean)
            local var1, var2 = Signals.createSignal(nil)

            local var3 = cache.getItem(universeId).data(false)
            cache.updateItem(universeId, { isFavorited = isFavorited })

            requestFavoriteUpdate(universeId, isFavorited):andThen(function(_)
                var2({ type = "success", isFavorited = isFavorited })
            end):catch(function(arg1)
                cache.updateItem(universeId, var3)
                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil
                local statusMessage = if type(arg1) == "table" and arg1.StatusMessage then arg1.StatusMessage else nil
                DiscoveryEventErrorLogger.reportError(
                    "updateFavorite",
                    "Error updating favorite",
                    {
                        universeId = universeId,
                        statusCode = statusCode,
                        statusMessage = statusMessage
                    }
                )
                logResponseError(FavoritesUrlBuilder.FAVORITE_UPDATE_URL, { StatusCode = statusCode })

                var2({ type = "error", error = tostring(arg1) })
            end)

            return var1
        end,
        updateItem = if FFlagLuaAppDataHydrationUpdateItem then cache.updateItem else nil,
        updateItems = cache.updateItems,
        clear = clear,
        dispose = dispose
    }
end

return createFavoritesStore

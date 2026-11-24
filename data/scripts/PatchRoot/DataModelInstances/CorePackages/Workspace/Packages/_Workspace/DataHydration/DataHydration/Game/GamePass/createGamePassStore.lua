-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local _GamePassStoreTypes = require(script.Parent.GamePassStoreTypes)
local fetchGamePasses = require(script.Parent.fetchGamePasses)

local function createGamePassStore()
    local dataCache = createDataCache()

    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        logError = function(arg1)
            local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil
            logResponseError("game-passes/v1/universes/.../game-passes", { StatusCode = statusCode })
            DiscoveryEventErrorLogger.reportError("GamePassStore", "Failed to fetch game passes", { err = tostring(arg1) })
        end,
        fetchFn = function(str1: string, _)
            return fetchGamePasses(str1):andThen(function(arg1): {string}
                local result = {}

                for _, value in arg1.gamePasses do
                    local str2 = tostring(value.id)
                    table.insert(result, str2)
                    dataCache.updateItems({ [str2] = value })
                end

                return result
            end)
        end
    })

    return {
        getPassesForUniverse = dataResolver.getCachedItem,
        getAndFetchPassesForUniverse = dataResolver.getAndFetchItem,
        fetchPassesForUniverse = dataResolver.fetchItem,
        getGamePassInfo = dataCache.getItem,
        updateGamePassInfo = dataCache.updateItem,
        updateGamePassInfos = dataCache.updateItems,
        updateUniversePasses = cache.updateItems,
        clear = function()
            cache.clear()
            dataResolver.clear()
            dataCache.clear()
        end,
        dispose = function()
            dataResolver.dispose()
            dataCache.dispose()
        end
    }
end
return createGamePassStore

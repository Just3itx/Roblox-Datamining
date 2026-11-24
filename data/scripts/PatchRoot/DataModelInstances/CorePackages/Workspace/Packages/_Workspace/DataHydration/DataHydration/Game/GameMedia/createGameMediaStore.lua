-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local DiscoveryEventErrorLogger = require(DataHydrationParent.DiscoveryUtils).DiscoveryEventErrorLogger

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local fetchGameMedia = require(script.Parent.fetchGameMedia)
local GameMediaStoreTypes = require(script.Parent.GameMediaStoreTypes)
local FFlagMyStatsMediaSelector = require(DataHydrationParent.SharedFlags).FFlagMyStatsMediaSelector

local function createGameMediaStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = FFlagMyStatsMediaSelector,
        logError = function(arg1)
            if type(arg1) == "table" and arg1.errorType then
                DiscoveryEventErrorLogger.reportError(arg1.errorType, arg1.errorMessage)
                return
            end
            DiscoveryEventErrorLogger.reportError("FetchGameMediaError", tostring(arg1))
        end,
        fetchFn = function(str1: string, _)
            return fetchGameMedia(str1):andThen(function(arg1)
                if not (arg1 and arg1.responseBody) then
                    error(
                        {
                            errorType = "FetchGameMediaResponseError",
                            errorMessage = if arg1 then "Missing response body" else "No response"
                        }
                    )
                end
                local var1, errorMessage = GameMediaStoreTypes.gameMediaResponseValidator(arg1.responseBody)
                if not var1 then
                    error({ errorType = "FetchGameMediaResponseInvalidInterface", errorMessage = errorMessage })
                end

                local result = {}
                local data = arg1.responseBody.data

                if data then
                    for _, value in data do
                        if not value.imageId then
                            continue
                        end

                        table.insert(result, {
                            imageId = value.imageId,
                            assetTypeId = value.assetTypeId,
                            videoId = value.videoId,
                            videoHash = value.videoHash,
                            videoTitle = value.videoTitle
                        })
                    end
                end

                return result
            end)
        end
    })

    return {
        getAndFetchGameMedia = dataResolver.getAndFetchItem,
        getGameMedia = dataResolver.getCachedItem,
        fetchGameMedia = dataResolver.fetchItem,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createGameMediaStore

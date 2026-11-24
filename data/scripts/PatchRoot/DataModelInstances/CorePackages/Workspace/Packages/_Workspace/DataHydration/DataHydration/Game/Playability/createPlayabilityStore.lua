-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Dash = require(DataHydrationParent.Dash)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local fetchPlayability = require(script.Parent.fetchPlayability)
local PlayabilityStoreTypes = require(script.Parent.PlayabilityStoreTypes)

local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger

local var1 = require(DataHydrationParent.SharedFlags).GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds()

local function createPlayabilityStore()
    local cache = createDataCache(var1)
    local dataResolver = createDataResolver({
        cache = cache,
        logError = function(arg1)
            if type(arg1) ~= "table" then
                DiscoveryEventErrorLogger.reportError("FetchPlayabilityError", tostring(arg1))
                return
            end

            if arg1.responseCode then
                logResponseError("v1/games/multiget-playability-status", { StatusCode = tonumber(arg1.responseCode) })
            end

            if arg1.errorType and arg1.errorMessage then
                DiscoveryEventErrorLogger.reportError(arg1.errorType, arg1.errorMessage, arg1.customFields)
            end
        end,
        fetchFn = function(tbl1)
            local universeIds = Dash.keys(tbl1)
            return fetchPlayability(universeIds):andThen(function(arg1)
                if not (arg1 and arg1.responseBody) then
                    error({
                        responseCode = arg1 and arg1.responseCode,
                        errorType = "FetchPlayabilityResponseError",
                        errorMessage = if arg1 then "Missing response body" else "No response",
                        customFields = { universeIds = universeIds }
                    })
                end

                local var3, errorMessage = PlayabilityStoreTypes.playabilityResponseValidator(arg1.responseBody)
                if not var3 then
                    error({
                        responseCode = arg1.responseCode,
                        errorType = "FetchPlayabilityResponseInvalidInterface",
                        errorMessage = errorMessage,
                        customFields = { universeIds = universeIds }
                    })
                end

                local result = ({})
                for _, value in arg1.responseBody do
                    local str1 = tostring(value.universeId)
                    result[str1] = {
                        isPlayable = value.isPlayable,
                        playabilityStatus = value.playabilityStatus
                    }
                end

                return result
            end):catch(function(arg1)
                error(arg1)
            end)
        end
    })

    return {
        fetchPlayability = dataResolver.fetchItem,
        getPlayability = dataResolver.getCachedItem,
        getAndFetchPlayability = dataResolver.getAndFetchItem,
        updatePlayability = cache.updateItem,
        updatePlayabilities = cache.updateItems,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createPlayabilityStore

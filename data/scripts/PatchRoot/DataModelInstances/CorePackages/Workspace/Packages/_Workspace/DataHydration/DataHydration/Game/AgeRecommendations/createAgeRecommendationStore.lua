-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:06Z
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
local fetchAgeRecommendation = require(script.Parent.fetchAgeRecommendation)
local AgeRecommendationStoreTypes = require(script.Parent.AgeRecommendationStoreTypes)

local FFlagShowGameAgeRating = require(DataHydrationParent.SharedFlags).FFlagShowGameAgeRating

local function createAgeRecommendationStore()
    local cache = createDataCache()

    local dataResolver = createDataResolver({
        cache = cache,
        requestBatchSize = 1,
        logError = function(arg1)
            if type(arg1) ~= "table" then
                DiscoveryEventErrorLogger.reportError("FetchAgeRecommendationError", tostring(arg1))
                return
            end

            if arg1.responseCode then
                logResponseError("experience-guidelines-api/get-age-recommendation", { StatusCode = tonumber(arg1.responseCode) })
            end

            if arg1.errorType and arg1.errorMessage then
                DiscoveryEventErrorLogger.reportError(arg1.errorType, arg1.errorMessage, arg1.customFields)
            end
        end,
        fetchFn = function(tbl1)
            local universeId = next(tbl1)
            if not universeId then
                error({
                    errorType = "CreateAgeRecommendationStoreMissingUniverseId",
                    errorMessage = "CreateAgeRecommendationStore requires universeId",
                    customFields = { universeId = universeId }
                })
            end
            return fetchAgeRecommendation(universeId):andThen(function(arg1)
                if not (arg1 and arg1.responseBody) then
                    error({
                        responseCode = arg1 and arg1.responseCode,
                        errorType = "FetchAgeRecommendationResponseError",
                        errorMessage = if arg1 then "Missing response body" else "No response",
                        customFields = { universeId = universeId }
                    })
                end

                local var2, errorMessage = AgeRecommendationStoreTypes.ageRecommendationResponseValidator(arg1.responseBody)
                if not var2 then
                    error({
                        responseCode = arg1.responseCode,
                        errorType = "FetchAgeRecommendationResponseInvalidInterface",
                        errorMessage = errorMessage,
                        customFields = { universeId = universeId }
                    })
                end

                local result = ({})

                local ageRecommendation = arg1.responseBody.ageRecommendationDetails.summary.ageRecommendation

                if FFlagShowGameAgeRating and not ageRecommendation then
                    result[universeId] = {}
                    return result
                end
                local var4 = universeId
                result[var4] = {
                    displayName = ageRecommendation.displayName,
                    displayNameWithHeaderShort = ageRecommendation.displayNameWithHeaderShort,
                    minimumAgeDisplay = if FFlagShowGameAgeRating then ageRecommendation.minimumAgeDisplay else nil,
                    igrsRating = ageRecommendation.igrsRating,
                    igrsRatingDisplayMessage = ageRecommendation.igrsRatingDisplayMessage
                }

                return result
            end):catch(function(arg1)
                error(arg1)
            end)
        end
    })

    return {
        fetchAgeRecommendation = dataResolver.fetchItem,
        getAgeRecommendation = dataResolver.getCachedItem,
        getAndFetchAgeRecommendation = dataResolver.getAndFetchItem,
        updateAgeRecommendations = cache.updateItems,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createAgeRecommendationStore

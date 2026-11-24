-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchExperienceQuestionnaire = require(script.Parent.fetchExperienceQuestionnaire)
local _ExperienceQuestionnaireStoreTypes = require(script.Parent.ExperienceQuestionnaireStoreTypes)

local function createExperienceQuestionnaireStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchExperienceQuestionnaire.fetchEligibility(num1, tbl3)
    end)
    local singleEntityResolver2 = createSingleEntityResolver(function(num1: number)
        return fetchExperienceQuestionnaire.fetchMetadataStatus(num1, tbl3)
    end)
    local singleEntityResolver3 = createSingleEntityResolver(function(num1: number)
        return fetchExperienceQuestionnaire.fetchActiveResponse(num1, tbl3)
    end)
    local singleEntityResolver4 = createSingleEntityResolver(function(num1: number)
        return fetchExperienceQuestionnaire.fetchLatestQuestionnaire(num1, tbl3)
    end)
    local singleEntityResolver5 = createSingleEntityResolver(function(num1: number)
        return fetchExperienceQuestionnaire.fetchLatestSubmission(num1, tbl3)
    end)

    local cache = createDataCache()

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(str1: string, _)
            return fetchExperienceQuestionnaire.fetchQuestionnaireById(str1, tbl3)
        end
    })

    return {
        getEligibility = singleEntityResolver.get,
        fetchEligibility = singleEntityResolver.fetch,
        getAndFetchEligibility = singleEntityResolver.getAndFetch,
        getMetadataStatus = singleEntityResolver2.get,
        fetchMetadataStatus = singleEntityResolver2.fetch,
        getAndFetchMetadataStatus = singleEntityResolver2.getAndFetch,
        getActiveResponse = singleEntityResolver3.get,
        fetchActiveResponse = singleEntityResolver3.fetch,
        getAndFetchActiveResponse = singleEntityResolver3.getAndFetch,
        getLatestQuestionnaire = singleEntityResolver4.get,
        fetchLatestQuestionnaire = singleEntityResolver4.fetch,
        getAndFetchLatestQuestionnaire = singleEntityResolver4.getAndFetch,
        getQuestionnaireById = function(arg1)
            return dataResolver.getCachedItem(arg1)
        end,
        fetchQuestionnaireById = function(arg1)
            return dataResolver.fetchItem(arg1)
        end,
        getAndFetchQuestionnaireById = function(arg1)
            return dataResolver.getAndFetchItem(arg1)
        end,
        getLatestSubmission = singleEntityResolver5.get,
        fetchLatestSubmission = singleEntityResolver5.fetch,
        getAndFetchLatestSubmission = singleEntityResolver5.getAndFetch,
        saveSubmission = function(num1: number, arg1)
            return fetchExperienceQuestionnaire.saveSubmission(num1, arg1, tbl3):andThen(function<T>(arg2: T): T
                singleEntityResolver3.fetch(num1)
                singleEntityResolver5.fetch(num1)
                return arg2
            end)
        end,
        validateResponses = function(arg1)
            return fetchExperienceQuestionnaire.validateResponses(arg1, tbl3)
        end,
        previewSubmission = function(arg1)
            return fetchExperienceQuestionnaire.previewSubmission(arg1, tbl3)
        end,
        clear = function()
            singleEntityResolver.clear()
            singleEntityResolver2.clear()
            singleEntityResolver3.clear()
            singleEntityResolver4.clear()
            dataResolver.clear()
            singleEntityResolver5.clear()
        end,
        dispose = function()
            singleEntityResolver.dispose()
            singleEntityResolver2.dispose()
            singleEntityResolver3.dispose()
            singleEntityResolver4.dispose()
            dataResolver.dispose()
            singleEntityResolver5.dispose()
        end
    }
end
return createExperienceQuestionnaireStore

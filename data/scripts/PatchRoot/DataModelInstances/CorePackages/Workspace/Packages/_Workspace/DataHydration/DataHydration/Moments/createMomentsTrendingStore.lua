-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")

local Promise = require(DataHydrationParent.Promise)
local HttpClient = require(DataHydrationParent.HttpClient)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local fetchTrendingMoments = require(script.Parent.Requests.fetchTrendingMoments)

local function paramsKey(momentsSessionId: string, cursor: string?): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return HttpService:JSONEncode({ momentsSessionId = momentsSessionId, hasCursor = cursor ~= nil, cursor = cursor or "" })
end

local function createMomentsTrendingStore(arg1)
    local var1 = arg1 or {}
    local tbl1 = ({})
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            local var2 = tbl1[str1]
            if var2 == nil then
                return Promise.reject(`Missing trending moments request params for {str1}`)
            end
            return HttpClient.asPromise(fetchTrendingMoments(var2.momentsSessionId, var2.cursor, var1.network))
        end
    })

    local function setParams(momentsSessionId: string, cursor: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
        local str1 = paramsKey(momentsSessionId, cursor)
        tbl1[str1] = { momentsSessionId = momentsSessionId, cursor = cursor }

        return str1
    end

    return {
        getTrending = function(str1: string, str2: string?, arg2)
            return HttpClient.asPromise(fetchTrendingMoments(str1, str2, var1.network, arg2))
        end,
        getCachedTrending = function(momentsSessionId: string, cursor: string?)
            return dataResolver.getCachedItem((setParams(momentsSessionId, cursor)))
        end,
        fetchTrending = function(momentsSessionId: string, cursor: string?)
            return dataResolver.fetchItem((setParams(momentsSessionId, cursor)))
        end,
        getAndFetchTrending = function(momentsSessionId: string, cursor: string?)
            return dataResolver.getAndFetchItem((setParams(momentsSessionId, cursor)))
        end,
        clear = function()
            tbl1 = {}
            dataResolver.clear()
        end,
        dispose = function()
            tbl1 = {}
            dataResolver.dispose()
        end
    }
end
return createMomentsTrendingStore

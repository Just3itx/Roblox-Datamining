-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchCampaignStats = require(script.Parent.fetchCampaignStats)
local _CampaignStatsTypes = require(script.Parent.CampaignStatsTypes)

local function createCampaignStatsStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl,
        nowMs = tbl2.nowMs
    }

    local cache = createDataCache(tbl2.ttlSeconds or 300)

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            local var1 = tonumber(str1)
            return fetchCampaignStats.fetchCampaignStats(var1, tbl3)
        end
    })

    return {
        getCampaignStats = function(num1: number)
            return dataResolver.getCachedItem(tostring(num1))
        end,
        fetchCampaignStats = function(num1: number)
            return dataResolver.fetchItem(tostring(num1))
        end,
        getAndFetchCampaignStats = function(num1: number, func1: ((...any) -> (...any))?)
            return dataResolver.getAndFetchItem(tostring(num1), func1)
        end,
        isCampaignStatsRequestInQueueOrInFlight = function(num1: number)
            return dataResolver.isRequestInQueueOrInFlight(tostring(num1))
        end,
        updateCampaignStats = function(num1: number, byCampaign)
            cache.replaceItem(tostring(num1), {
                byCampaign = byCampaign,
                failedMetrics = {
                    plays = false,
                    adClicks = false,
                    adViews = false,
                    playtimeSeconds = false
                }
            })
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createCampaignStatsStore

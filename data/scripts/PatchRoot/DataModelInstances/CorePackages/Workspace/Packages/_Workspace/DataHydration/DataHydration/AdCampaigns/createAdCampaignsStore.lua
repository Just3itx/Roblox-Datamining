-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchAdCampaigns = require(script.Parent.fetchAdCampaigns)
local _AdCampaignsTypes = require(script.Parent.AdCampaignsTypes)

local function createAdCampaignsStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }

    local cache = createDataCache(tbl2.ttlSeconds or 300)

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_: string, _)
            return fetchAdCampaigns.fetchAdCampaigns(tbl3)
        end
    })

    return {
        getAdCampaigns = function()
            return dataResolver.getCachedItem("0")
        end,
        fetchAdCampaigns = function()
            return dataResolver.fetchItem("0")
        end,
        getAndFetchAdCampaigns = function()
            return dataResolver.getAndFetchItem("0")
        end,
        isAdCampaignsRequestInQueueOrInFlight = function()
            return dataResolver.isRequestInQueueOrInFlight("0")
        end,
        updateAdCampaigns = function(tbl4)
            cache.replaceItem("0", tbl4)
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createAdCampaignsStore

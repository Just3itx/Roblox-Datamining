-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local Signals = require(DataHydrationParent.Signals)

local SharedFlags = require(DataHydrationParent.SharedFlags)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MarketplaceCatalogCategoryStoreTypes = require(script.Parent.MarketplaceCatalogCategoryStoreTypes)

local FFlagMarketplaceCatalogCategoryTrackLastReceived = SharedFlags.FFlagMarketplaceCatalogCategoryTrackLastReceived
local FFlagSduiSkipEmptyCatalogCategoryHydration = SharedFlags.FFlagSduiSkipEmptyCatalogCategoryHydration

local function createMarketplaceCatalogCategoryStore()
    local var1 = nil
    local var2 = nil
    if FFlagMarketplaceCatalogCategoryTrackLastReceived then
        local var3
        var1, var3 = Signals.createSignal({})
        var2 = var3
    end

    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end,
        onClear = FFlagSduiSkipEmptyCatalogCategoryHydration and function()
            if var2 then
                var2({})
            end
        end or nil
    })

    local function updateMarketplaceCatalogCategories(tbl1)
        if FFlagSduiSkipEmptyCatalogCategoryHydration and next(tbl1) == nil then
            return
        end
        var2(tbl1)
        cache.updateItems(tbl1)
    end

    local function clear()
        if var2 then
            var2({})
        end
        dataResolver.clear()
    end

    local tbl1 = {
        getMarketplaceCatalogCategory = dataResolver.getCachedItem,
        getMarketplaceCatalogCategories = dataResolver.getCachedItems,
        updateMarketplaceCatalogCategories = 0,
        updateMarketplaceCatalogCategory = 0,
        getLastReceivedCategories = 0,
        clear = 0,
        dispose = 0
    }

    if not FFlagMarketplaceCatalogCategoryTrackLastReceived then
        updateMarketplaceCatalogCategories = cache.updateItems
    end

    tbl1.updateMarketplaceCatalogCategories = updateMarketplaceCatalogCategories

    tbl1.updateMarketplaceCatalogCategory = cache.updateItem
    tbl1.getLastReceivedCategories = var1
    if not FFlagMarketplaceCatalogCategoryTrackLastReceived then
        clear = dataResolver.clear
    end

    tbl1.clear = clear
    tbl1.dispose = dataResolver.dispose
    return tbl1
end

return createMarketplaceCatalogCategoryStore

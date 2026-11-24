-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:24Z
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
local _MarketplaceCatalogSortStoreTypes = require(script.Parent.MarketplaceCatalogSortStoreTypes)

local FFlagMarketplaceCatalogSortTrackLastReceived = SharedFlags.FFlagMarketplaceCatalogSortTrackLastReceived
local FFlagAXSduiNilEmptyTagId = require(DataHydration.Flags.FFlagAXSduiNilEmptyTagId)
local FFlagDataHydrationAccountReset = SharedFlags.FFlagDataHydrationAccountReset

local function normalizeCardFooters(cardFooters)
    if not cardFooters then
        return nil
    end
    local var1 = table.create(#cardFooters)
    for _, cardFooter in cardFooters do
        table.insert(var1, { contentType = cardFooter.contentType or cardFooter.content_type })
    end
    return var1
end

local function normalizeCardStyle(cardStyle) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        thumbnailAspectRatio = cardStyle.thumbnailAspectRatio or cardStyle.thumbnail_aspect_ratio
    }
end

local function normalizeSort(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1.cardFooters or arg1.cardStyle) then
        return arg1
    end
    local var1 = table.clone(arg1)
    if arg1.cardFooters then
        var1.cardFooters = normalizeCardFooters(arg1.cardFooters)
    end
    if arg1.cardStyle then
        var1.cardStyle = normalizeCardStyle(arg1.cardStyle)
    end
    return var1
end

local function clearEmptyTagId(arg1)
    if arg1.tagId ~= "" then
        return arg1
    end
    local var1 = table.clone(arg1)
    var1.tagId = nil
    return var1
end

local function createMarketplaceCatalogSortStore()
    local dataCache = if FFlagAXSduiNilEmptyTagId then createDataCache(
        nil,
        nil,
        {
            sanitizeItem = clearEmptyTagId,
            observeLocalUser = not FFlagDataHydrationAccountReset and nil
        }
    ) else createDataCache(nil, nil, FFlagDataHydrationAccountReset and { observeLocalUser = false } or nil)

    local dataResolver = createDataResolver({
        cache = dataCache,
        fetchFn = function(_)
            return Promise.resolve({})
        end,
        keepCacheOnAccountReset = if FFlagDataHydrationAccountReset then true else nil
    })

    local var1 = nil
    local var2 = nil
    if FFlagMarketplaceCatalogSortTrackLastReceived then
        local var3
        var1, var3 = Signals.createSignal({})
        var2 = var3
    end

    local function updateMarketplaceCatalogSorts(tbl1)
        var2(tbl1)
        dataCache.updateItems(tbl1)
    end

    local function clear()
        if var2 then
            var2({})
        end
        dataResolver.clear()
    end

    local tbl1 = {
        getMarketplaceCatalogSort = dataResolver.getCachedItem,
        getMarketplaceCatalogSorts = dataResolver.getCachedItems,
        getNormalizedMarketplaceCatalogSort = function(str1: string)
            local cachedItem = dataResolver.getCachedItem(str1)
            return {
                data = function(arg1)
                    local var3 = cachedItem.data(arg1)
                    if var3 then
                        return normalizeSort(var3)
                    end

                    return nil
                end,
                status = cachedItem.status
            }
        end,
        updateMarketplaceCatalogSorts = 0,
        updateMarketplaceCatalogSort = 0,
        getLastReceivedSorts = 0,
        clear = 0,
        dispose = 0
    }

    if not FFlagMarketplaceCatalogSortTrackLastReceived then
        updateMarketplaceCatalogSorts = dataCache.updateItems
    end

    tbl1.updateMarketplaceCatalogSorts = updateMarketplaceCatalogSorts

    tbl1.updateMarketplaceCatalogSort = dataCache.updateItem
    tbl1.getLastReceivedSorts = var1
    if not FFlagMarketplaceCatalogSortTrackLastReceived then
        clear = dataResolver.clear
    end

    tbl1.clear = clear
    tbl1.dispose = dataResolver.dispose
    return tbl1
end

return createMarketplaceCatalogSortStore

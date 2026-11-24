-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)
local _Signals = require(DataHydrationParent.Signals)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MarketplaceBundleStoreTypes = require(script.Parent.MarketplaceBundleStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function normalizeTaxonomy(taxonomy)
    if not taxonomy then
        return nil
    end
    local var1 = table.create(#taxonomy)
    for _, value in taxonomy do
        table.insert(var1, {
            taxonomyId = if value.taxonomyId ~= nil then value.taxonomyId else value.taxonomy_id,
            taxonomyName = if value.taxonomyName ~= nil then value.taxonomyName else value.taxonomy_name
        })
    end
    return var1
end

local function normalizeBundledItems(bundledItems)
    if not bundledItems then
        return nil
    end
    local var1 = table.create(#bundledItems)
    for _, bundledItem in bundledItems do
        table.insert(var1, {
            id = bundledItem.id,
            assetType = if bundledItem.assetType ~= nil then bundledItem.assetType else bundledItem.asset_type,
            type = bundledItem.type
        })
    end
    return var1
end

local function normalizeBundle(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1.taxonomy or arg1.bundledItems) then
        return arg1
    end
    local var1 = table.clone(arg1)
    if arg1.taxonomy then
        var1.taxonomy = normalizeTaxonomy(arg1.taxonomy)
    end
    if arg1.bundledItems then
        var1.bundledItems = normalizeBundledItems(arg1.bundledItems)
    end
    return var1
end

local function createMarketplaceBundleStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getMarketplaceBundleInfo = dataResolver.getCachedItem,
        getMarketplaceBundleInfos = dataResolver.getCachedItems,
        getNormalizedMarketplaceBundleInfo = function(str1: string)
            local cachedItem = dataResolver.getCachedItem(str1)
            return {
                data = function(arg1)
                    local var1 = cachedItem.data(arg1)
                    if var1 then
                        return normalizeBundle(var1)
                    end

                    return nil
                end,
                status = cachedItem.status
            }
        end,
        getCreatingUniverseId = function(str1: string)
            local data = dataResolver.getCachedItem(str1).data
            return function(arg1)
                local var1 = data(arg1)
                local creatingUniverseId = if var1 then var1.creatingUniverseId else nil

                if typeof(creatingUniverseId) == "number" then
                    return tostring(creatingUniverseId)
                end
                return if typeof(creatingUniverseId) == "string" and creatingUniverseId ~= "" then creatingUniverseId else nil
            end
        end,
        updateMarketplaceBundleInfo = cache.updateItem,
        updateMarketplaceBundleInfos = cache.updateItems,
        clear = cache.clear,
        dispose = cache.dispose
    }
end

return createMarketplaceBundleStore

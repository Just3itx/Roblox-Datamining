-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Dash = require(DataHydrationParent.Dash)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchGameIcons = require(script.Parent.fetchGameIcons)
local _GameIconStoreTypes = require(script.Parent.GameIconStoreTypes)
local GameIconSize = require(script.Parent.GameIconSize)
local GameIconConstants = require(script.Parent.GameIconConstants)
local sizeString = GameIconConstants.sizeString

local FIntGameIconSmallSizePx = GameIconConstants.FIntGameIconSmallSizePx
local FIntGameIconLargeSizePx = GameIconConstants.FIntGameIconLargeSizePx

local function toId(arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return tostring(arg1)
end

local function toIds(tbl1): {string} -- Luacid: Inlined by compiler; 3 call sites recovered
    local result = {}
    for _, value in tbl1 do
        table.insert(result, tostring(value))
    end
    return result
end

local function createResolver(size: string)
    local cache = createDataCache()
    return cache, (createDataResolver({
        cache = cache,
        queueProcessDelaySec = 0,
        requestBatchSize = 100,
        fetchFn = function(tbl1)
            local var1 = Dash.keys(tbl1)
            return fetchGameIcons(var1, size):andThen(function(tbl2)
                local result = ({})
                for _, value in tbl2 do
                    if type(value) ~= "table" or type(value.targetId) ~= "number" or value.state == "Pending" then
                        continue
                    end
                    local universeId = tostring(value.targetId)
                    result[universeId] = {
                        universeId = universeId,
                        state = value.state,
                        url = value.imageUrl,
                        size = size
                    }
                end

                return result
            end)
        end
    }))
end

local function createGameIconStore()
    local var1, var2 = createResolver(sizeString(FIntGameIconSmallSizePx))
    local var3, var4 = createResolver(sizeString(FIntGameIconLargeSizePx))

    local function resolverFor(large) -- Luacid: Inlined by compiler; 6 call sites recovered
        return if large == GameIconSize.Large then var4 else var2
    end

    local function cacheFor(large) -- Luacid: Inlined by compiler; 1 call site recovered
        return if large == GameIconSize.Large then var3 else var1
    end

    return {
        fetchGameIcon = function(arg1, large)
            return resolverFor(large).fetchItem((toId(arg1)))
        end,
        fetchGameIcons = function(arg1, large)
            return resolverFor(large).fetchItems((toIds(arg1)))
        end,
        getGameIcon = function(arg1, large)
            return resolverFor(large).getCachedItem((toId(arg1)))
        end,
        getGameIcons = function(arg1, large)
            return resolverFor(large).getCachedItems((toIds(arg1)))
        end,
        getAndFetchGameIcon = function(arg1, large, arg2)
            return resolverFor(large).getAndFetchItem(toId(arg1), arg2)
        end,
        getAndFetchGameIcons = function(arg1, large, arg2)
            return resolverFor(large).getAndFetchItems(toIds(arg1), arg2)
        end,
        updateGameIcons = function(arg1, large)
            cacheFor(large).updateItems(arg1)
        end,
        clear = function()
            var2.clear()
            var4.clear()
        end,
        dispose = function()
            var2.dispose()
            var4.dispose()
        end
    }
end

return createGameIconStore

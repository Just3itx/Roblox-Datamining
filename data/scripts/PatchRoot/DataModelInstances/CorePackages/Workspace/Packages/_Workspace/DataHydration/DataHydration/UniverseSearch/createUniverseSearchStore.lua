-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchUniverseSearch = require(script.Parent.fetchUniverseSearch)
local _UniverseSearchStoreTypes = require(script.Parent.UniverseSearchStoreTypes)

local function paramsKey(input): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return HttpService:JSONEncode(input)
end

local function createUniverseSearchStore(tbl1)
    local tbl2 = tbl1 or {}

    local tbl3 = ({})
    local tbl4 = ({})
    local tbl5 = ({})

    local function applyItemPatches(arg1)
        local data = arg1.data
        if data == nil or next(tbl5) == nil then
            return arg1
        end

        local bool1 = false
        local var1 = table.create(#data)
        for value, value2 in data do
            local var2 = tbl5[value2.id]
            if var2 ~= nil then
                var1[value] = Cryo.Dictionary.join(value2, var2)
                bool1 = true
            else
                var1[value] = value2
            end
        end

        if not bool1 then
            return arg1
        end

        return Cryo.Dictionary.join(arg1, { data = var1 })
    end

    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(str1: string, _)
            local var1 = tbl3[str1]
            return fetchUniverseSearch(var1, { network = tbl2.network, baseUrl = tbl2.baseUrl }):andThen(applyItemPatches)
        end
    })

    return {
        getSearch = function(arg1)
            local str1 = paramsKey(arg1)

            tbl3[str1] = arg1
            return dataResolver.getCachedItem(str1)
        end,
        fetchSearch = function(arg1)
            local str1 = paramsKey(arg1)

            tbl3[str1] = arg1
            return dataResolver.fetchItem(str1)
        end,
        refreshSearch = function(arg1)
            local str1 = paramsKey(arg1)

            tbl3[str1] = arg1
            local var1 = (tbl4[str1] or 0) + 1
            tbl4[str1] = var1
            cache.resetFailedItem(str1)

            return fetchUniverseSearch(arg1, { network = tbl2.network, baseUrl = tbl2.baseUrl }):andThen(applyItemPatches):andThen(
                function<T>(arg2: T): T
                    if tbl4[str1] == var1 then
                        cache.replaceItem(str1, arg2)
                    end
                    return arg2
                end
            ):catch(
                function(arg2)
                    if tbl4[str1] == var1 then
                        cache.markItemsAsFailed({ str1 })
                    end
                    error(arg2)
                end
            )
        end,
        getAndFetchSearch = function(arg1)
            local str1 = paramsKey(arg1)

            tbl3[str1] = arg1
            return dataResolver.getAndFetchItem(str1)
        end,
        updateSearchItem = function(num1: number, tbl6)
            tbl5[num1] = Cryo.Dictionary.join(tbl5[num1] or {}, tbl6)

            for value in tbl3 do
                local var1 = dataResolver.getCachedItem(value).data(false)
                if var1 == nil then
                    continue
                end

                local var2 = applyItemPatches(var1)
                if var2 ~= var1 then
                    cache.updateItem(value, var2)
                end
            end
        end,
        invalidateAll = function()
            tbl3 = {}
            tbl4 = {}
            dataResolver.clear()
        end,
        dispose = function()
            tbl3 = {}
            tbl4 = {}
            tbl5 = {}
            dataResolver.dispose()
        end
    }
end
return createUniverseSearchStore

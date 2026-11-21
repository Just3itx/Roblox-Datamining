-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")
local CatalogNetworkingParent = CatalogNetworking.Parent

local Signals = require(CatalogNetworkingParent.Signals)
local Promise = require(CatalogNetworkingParent.Promise)

local fetchCollectibleProductIds = require(CatalogNetworking.networkRequests.fetchCollectibleProductIds)

local getCache, var2 = Signals.createSignal({})

return {
    getCache = getCache,
    fetchAndCache = function(arg1, tbl1)
        local var3 = getCache(false)
        local tbl2 = {}
        for _, value in tbl1 do
            if not var3[value] then
                table.insert(tbl2, value)
            end
        end
        if #tbl2 == 0 then
            return Promise.resolve()
        end

        return fetchCollectibleProductIds(arg1, tbl2):andThen(function(arg2)
            local var4 = table.clone(getCache(false))
            for _, value in arg2 do
                local collectibleItemId = value.collectibleItemId
                var4[collectibleItemId] = {
                    productId = value.collectibleProductId,
                    resaleProductId = value.resaleProductId
                }
            end
            var2(var4)
        end)
    end,
    getProductId = function(str1: string)
        local var3 = getCache(false)[str1]
        return if var3 then var3.productId else nil
    end,
    getResaleProductId = function(str1: string)
        local var3 = getCache(false)[str1]
        return if var3 then var3.resaleProductId else nil
    end,
    clear = function()
        var2({})
    end
}

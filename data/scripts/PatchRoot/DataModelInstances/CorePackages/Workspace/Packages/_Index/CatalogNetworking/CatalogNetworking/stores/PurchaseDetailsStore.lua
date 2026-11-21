-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")
local CatalogNetworkingParent = CatalogNetworking.Parent

local Signals = require(CatalogNetworkingParent.Signals)
local Promise = require(CatalogNetworkingParent.Promise)
local Dash = require(CatalogNetworkingParent.Dash)

local _Types = require(CatalogNetworking.Types)
local fetchPurchaseDetails = require(CatalogNetworking.networkRequests.fetchPurchaseDetails)

local getCache, var2 = Signals.createSignal({})

local function mergeResponse(arg1)
    if arg1 and arg1.look and arg1.look.items then
        local var3 = table.clone(getCache(false))
        for _, item in arg1.look.items do
            local id = item.id
            var3[tostring(id)] = item
        end
        var2(var3)
    end
    return arg1
end

return {
    getCache = getCache,
    fetchAndCache = function(arg1, tbl1)
        local var3 = getCache(false)
        local var4 = Dash.filter(tbl1, function(arg2): boolean
            return not var3[tostring(arg2.id)]
        end)
        if #var4 == 0 then
            return Promise.resolve()
        end
        return fetchPurchaseDetails(arg1, var4):andThen(mergeResponse)
    end,
    fetchAll = function(arg1, tbl1)
        return fetchPurchaseDetails(arg1, tbl1):andThen(mergeResponse)
    end,
    getItem = function(str1: string)
        return getCache(false)[str1]
    end,
    clear = function()
        var2({})
    end,
    markItemsOwned = function(tbl1)
        local var3 = table.clone(getCache(false))
        for _, value in tbl1 do
            if var3[value] then
                local var4 = table.clone(var3[value])
                var4.quantityOwned = (var4.quantityOwned or 0) + 1
                var4.isPurchasable = false
                var3[value] = var4
            end
        end
        var2(var3)
    end
}

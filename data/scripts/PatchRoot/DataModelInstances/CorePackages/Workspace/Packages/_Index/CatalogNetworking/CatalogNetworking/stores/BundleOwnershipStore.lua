-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")
local CatalogNetworkingParent = CatalogNetworking.Parent

local Signals = require(CatalogNetworkingParent.Signals)
local Promise = require(CatalogNetworkingParent.Promise)
local Dash = require(CatalogNetworkingParent.Dash)

local fetchBundleOwnership = require(CatalogNetworking.networkRequests.fetchBundleOwnership)

local getCache, var2 = Signals.createSignal({})

return {
    getCache = getCache,
    fetchAndCache = function(arg1, tbl1)
        local var3 = getCache(false)
        local tbl2 = {}
        for _, value in tbl1 do
            if var3[tostring(value)] == nil then
                table.insert(tbl2, value)
            end
        end
        if #tbl2 == 0 then
            return Promise.resolve()
        end

        local var4 = Dash.map(tbl2, function(arg2)
            return fetchBundleOwnership(arg1, arg2)
        end)

        return Promise.all(var4):andThen(function(arg2)
            local var5 = table.clone(getCache(false))
            for _, value in arg2 do
                if value then
                    var5[value.id] = value.owned
                end
            end
            var2(var5)
        end)
    end,
    isOwned = function(str1: string)
        return getCache(false)[str1]
    end,
    clear = function()
        var2({})
    end,
    markOwned = function(tbl1)
        local var3 = table.clone(getCache(false))
        for _, value in tbl1 do
            var3[value] = true
        end
        var2(var3)
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")
local CatalogNetworkingParent = CatalogNetworking.Parent

local Signals = require(CatalogNetworkingParent.Signals)
local Promise = require(CatalogNetworkingParent.Promise)

local _Types = require(CatalogNetworking.Types)
local fetchItemDetails = require(CatalogNetworking.networkRequests.fetchItemDetails)

local getCache, var2 = Signals.createSignal({})

return {
    getCache = getCache,
    fetchAndCache = function(arg1, tbl1)
        local var3 = getCache(false)
        local tbl2 = {}
        for _, value in tbl1 do
            if not var3[tostring(value.id)] then
                table.insert(tbl2, value)
            end
        end
        if #tbl2 == 0 then
            return Promise.resolve()
        end

        return fetchItemDetails(arg1, tbl2):andThen(function(arg2)
            if not arg2 or not arg2.data then
                return
            end

            local var4 = table.clone(getCache(false))
            for _, value in arg2.data do
                local id = value.id
                var4[tostring(id)] = value
            end
            var2(var4)
        end)
    end,
    getItem = function(str1: string)
        return getCache(false)[str1]
    end,
    clear = function()
        var2({})
    end
}

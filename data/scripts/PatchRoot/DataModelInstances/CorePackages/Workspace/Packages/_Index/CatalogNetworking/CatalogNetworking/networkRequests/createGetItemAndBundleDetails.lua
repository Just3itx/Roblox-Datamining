-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")
local CatalogNetworkingParent = CatalogNetworking.Parent
local Cryo = require(CatalogNetworkingParent.Cryo)

local CATALOG_URL = require(CatalogNetworking.CATALOG_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("GetItemDetails", function(arg1, tbl2)
        return arg1(CATALOG_URL):path("v1"):path("catalog"):path("items"):path("details"):body({
            items = Cryo.List.map(tbl2, function(arg2)
                return {
                    itemType = arg2.itemType,
                    id = arg2.assetId
                }
            end)
        })
    end)
end

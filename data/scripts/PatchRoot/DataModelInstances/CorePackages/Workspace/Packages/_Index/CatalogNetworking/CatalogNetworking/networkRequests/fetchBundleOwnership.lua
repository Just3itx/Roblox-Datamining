-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")

local CATALOG_URL = require(CatalogNetworking.CATALOG_URL)

local function fetchBundleOwnership(arg1, num1: number)
    return arg1(`{CATALOG_URL}/v1/catalog/items/{num1}/details?itemType=bundle`, "GET", {}):andThen(function(arg2)
        local responseBody = arg2.responseBody

        if responseBody then
            return {
                id = tostring(num1),
                owned = responseBody.owned == true
            }
        end

        return nil
    end):catch(function(arg2)
        warn("[CatalogNetworking] fetchBundleOwnership failed for bundle", num1, ":", tostring(arg2))
        return nil
    end)
end

return fetchBundleOwnership

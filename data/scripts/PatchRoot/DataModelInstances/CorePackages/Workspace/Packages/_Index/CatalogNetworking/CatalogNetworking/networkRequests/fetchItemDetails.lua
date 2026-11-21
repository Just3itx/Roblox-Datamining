-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")

local CATALOG_URL = require(CatalogNetworking.CATALOG_URL)

local function fetchItemDetails(arg1, items)
    local postBody = HttpService:JSONEncode({ items = items })

    return arg1(`{CATALOG_URL}/v1/catalog/items/details`, "POST", { postBody = postBody }):andThen(function(arg2)
        return arg2.responseBody
    end):catch(function(arg2)
        warn("[CatalogNetworking] fetchItemDetails failed:", tostring(arg2))
        return nil
    end)
end

return fetchItemDetails

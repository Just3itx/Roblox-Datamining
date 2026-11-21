-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local CatalogNetworking = script:FindFirstAncestor("CatalogNetworking")

local LOOK_API_URL = require(CatalogNetworking.LOOK_API_URL)

local function fetchPurchaseDetails(arg1, assets)
    local postBody = HttpService:JSONEncode({ assets = assets })
    return arg1(LOOK_API_URL, "POST", { postBody = postBody }):andThen(function(arg2)
        return arg2.responseBody
    end):catch(function(arg2)
        warn("[CatalogNetworking] fetchPurchaseDetails failed:", tostring(arg2))
        return nil
    end)
end

return fetchPurchaseDetails

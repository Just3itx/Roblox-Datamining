-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local CatalogNetworkingParent = script:FindFirstAncestor("CatalogNetworking").Parent

local buildApiSiteUrl = require(CatalogNetworkingParent.SocialCommon).Utils.buildApiSiteUrl
local Dash = require(CatalogNetworkingParent.Dash)

local var1 = buildApiSiteUrl("apis") .. "/marketplace-items/v1/items/details"

local function fetchCollectibleProductIds(arg1, itemIds)
    local postBody = HttpService:JSONEncode({ itemIds = itemIds })
    return arg1(var1, "POST", { postBody = postBody }):andThen(function(arg2)
        return Dash.collectArray(arg2.responseBody or {}, function(_, arg3)
            if not (arg3.collectibleItemId and arg3.collectibleProductId) then
                return nil
            end

            return {
                collectibleItemId = arg3.collectibleItemId,
                collectibleProductId = arg3.collectibleProductId,
                resaleProductId = arg3.lowestAvailableResaleProductId
            }
        end)
    end):catch(function(arg2)
        warn("[CatalogNetworking] fetchCollectibleProductIds failed:", tostring(arg2))
        return {}
    end)
end

return fetchCollectibleProductIds

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)
local Promise = require(DataHydrationParent.Promise)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local _MarketplaceItemFavoriteStoreTypes = require(script.Parent.MarketplaceItemFavoriteStoreTypes)
local MarketplaceItemFavoriteUrlBuilder = require(script.Parent.MarketplaceItemFavoriteUrlBuilder)

local function fetchMarketplaceItemFavorite(arg1, str1: string)
    local localPlayerUserId = getLocalPlayerUserId()
    if not localPlayerUserId then
        return Promise.reject({
            ClientError = "Missing or invalid local player ID",
            message = "Cannot fetch favorite status: missing or invalid local player ID"
        })
    end

    local favoriteUrl = MarketplaceItemFavoriteUrlBuilder.buildFavoriteUrl(tostring(localPlayerUserId), arg1, str1)

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg2)
            return HttpRequest.requestFunctions.HttpRbxApi(str2, str3, arg2)
        end
    })(favoriteUrl, "GET")
end

return fetchMarketplaceItemFavorite

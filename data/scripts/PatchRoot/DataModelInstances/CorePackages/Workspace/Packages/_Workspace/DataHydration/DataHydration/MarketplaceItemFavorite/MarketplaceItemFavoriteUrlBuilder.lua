-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder
local _MarketplaceItemFavoriteStoreTypes = require(script.Parent.MarketplaceItemFavoriteStoreTypes)

local Url = Http.Url

local tbl1 = { Asset = "assets", Bundle = "bundles" }

local tbl2 = {
    Asset = "catalog/v1/favorites/users/assets/favorite",
    Bundle = "catalog/v1/favorites/users/bundles/favorite"
}

return {
    buildFavoriteUrl = function(userId: string, arg1, itemId: string)
        return UrlBuilder.new({ base = Url.CATALOG_URL, path = "v1/favorites/users/{userId}/{itemPath}/{itemId}/favorite" })(
            {
                userId = userId,
                itemPath = tbl1[arg1],
                itemId = itemId
            }
        )
    end,
    getEndpointName = function(arg1)
        return tbl2[arg1]
    end
}

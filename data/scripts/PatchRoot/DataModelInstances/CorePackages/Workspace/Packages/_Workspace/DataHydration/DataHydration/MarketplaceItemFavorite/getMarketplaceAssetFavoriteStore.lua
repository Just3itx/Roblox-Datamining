-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Signals = require(DataHydrationParent.Signals)

local createMarketplaceItemFavoriteStore = require(script.Parent.createMarketplaceItemFavoriteStore)
local getMarketplaceAssetStore = require(DataHydration.MarketplaceAsset.getMarketplaceAssetStore)

return Signals.createComputed(function()
    return createMarketplaceItemFavoriteStore({
        itemType = "Asset",
        getFavoriteCount = function(str1: string)
            local var1 = getMarketplaceAssetStore(false).getMarketplaceAssetInfo(str1).data(false)
            return if var1 then var1.favoriteCount else nil
        end,
        setFavoriteCount = function(str1: string, favoriteCount: number)
            getMarketplaceAssetStore(false).updateMarketplaceAssetInfo(str1, { favoriteCount = favoriteCount })
        end
    })
end)

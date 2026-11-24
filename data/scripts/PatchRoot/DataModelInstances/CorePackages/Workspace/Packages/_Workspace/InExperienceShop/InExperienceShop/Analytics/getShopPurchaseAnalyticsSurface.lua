-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local ProductPurchaseSurface = require(InExperienceShopParent.PurchasePromptLite).Enums.ProductPurchaseSurface

local Constants = require(script.Parent.Constants)

local function getShopPurchaseAnalyticsSurface(str1: string)
    if str1 == Constants.ShopPageType.Home then
        return ProductPurchaseSurface.InExperienceShopHome
    end

    if str1 == Constants.ShopPageType.Search then
        return ProductPurchaseSurface.InExperienceShopSearch
    end

    return ProductPurchaseSurface.InExperienceShopDetails
end

return getShopPurchaseAnalyticsSurface

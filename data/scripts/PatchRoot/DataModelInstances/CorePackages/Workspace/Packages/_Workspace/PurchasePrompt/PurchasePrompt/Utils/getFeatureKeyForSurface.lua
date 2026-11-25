-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local ProductPurchaseSurface = require(PurchasePromptParent.PurchasePromptLite).Enums.ProductPurchaseSurface

local FFlagEnforceRobloxShopForAllSurfaces = require(PurchasePrompt.Flags.FFlagEnforceRobloxShopForAllSurfaces)

local tbl1 = { ProductPurchaseSurface.InExperienceShopHome, ProductPurchaseSurface.InExperienceShopSearch, ProductPurchaseSurface.InExperienceShopDetails }

local function getFeatureKeyForSurface(arg1): string
    if FFlagEnforceRobloxShopForAllSurfaces then
        return "ROBLOX_SHOP"
    end

    if arg1 == nil or table.find(tbl1, arg1) == nil then
        return "DEVELOPER_SHOP"
    end

    return "ROBLOX_SHOP"
end

return getFeatureKeyForSurface

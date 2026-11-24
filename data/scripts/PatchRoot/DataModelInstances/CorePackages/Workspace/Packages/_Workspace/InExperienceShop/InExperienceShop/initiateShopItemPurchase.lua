-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local PurchasePrompt = require(InExperienceShopParent.PurchasePrompt)
local SharedFlags = require(InExperienceShopParent.SharedFlags)

local getShopPurchasePayload = require(InExperienceShop.Utils.getShopPurchasePayload)
local FFlagCategoryLoggingInShopPurchase = require(InExperienceShop.Flags.FFlagCategoryLoggingInShopPurchase)

local FFlagEnablePurchasePayloadInExperienceShop = SharedFlags.FFlagEnablePurchasePayloadInExperienceShop
local FFlagPassShopPurchaseSurfaceToBuyModal = SharedFlags.FFlagPassShopPurchaseSurfaceToBuyModal
local FFlagSkipBuyDelayForExperienceShop = SharedFlags.FFlagSkipBuyDelayForExperienceShop

local _Types = require(InExperienceShop.Types)

local function initiateShopItemPurchase(id: string, arg1, str2: string?, arg2)
    if tonumber(id) == nil then
        return
    end

    local var1

    if FFlagEnablePurchasePayloadInExperienceShop then
        local var2 = getShopPurchasePayload

        if not FFlagCategoryLoggingInShopPurchase then
            arg2 = nil
        end

        var1 = var2(arg2)
    else
        var1 = nil
    end

    local initiatePurchaseForProductPayload = PurchasePrompt.initiatePurchaseForProductPayload
    if FFlagPassShopPurchaseSurfaceToBuyModal and str2 ~= nil then
        local tbl1 = {
            surface = require(InExperienceShop.Analytics.getShopPurchaseAnalyticsSurface)(str2)
        }
        initiatePurchaseForProductPayload = function(arg3)
            PurchasePrompt.initiatePurchaseForProductPayload(arg3, tbl1)
        end
    end

    if arg1 == "GamePass" then
        initiatePurchaseForProductPayload({
            id = id,
            kind = "Gamepass",
            purchasePayload = var1,
            isFromInExperienceShop = if FFlagSkipBuyDelayForExperienceShop then true else nil
        })
        return
    end
    if arg1 ~= "Product" then
        return
    end

    initiatePurchaseForProductPayload({
        id = id,
        kind = "Product",
        equipIfPurchased = false,
        purchasePayload = var1,
        isFromInExperienceShop = if FFlagSkipBuyDelayForExperienceShop then true else nil
    })
end

return initiateShopItemPurchase

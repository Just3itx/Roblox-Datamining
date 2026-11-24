-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local _Types = require(InExperienceShop.Types)

local initiateShopItemPurchase = require(InExperienceShop.initiateShopItemPurchase)
local FFlagCategoryLoggingInShopPurchase = require(InExperienceShop.Flags.FFlagCategoryLoggingInShopPurchase)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)

local tbl1 = {
    owned = "Feature.Catalog.Label.Owned",
    buy = "Feature.Catalog.Action.Buy",
    try = "Feature.Catalog.Action.Try"
}

return React.memo(function(tbl2) -- name: ShopItemFooter
    local var1 = useLocalization(tbl1)
    local isOwned = tbl2.isOwned or false

    local purchaseCategoryLocation = tbl2.purchaseCategoryLocation
    local onActivated = React.useCallback(function()
        if FFlagCategoryLoggingInShopPurchase and purchaseCategoryLocation ~= nil then
            initiateShopItemPurchase(tbl2.itemId, tbl2.itemType, tbl2.shopPageType, purchaseCategoryLocation)
            return
        end
        initiateShopItemPurchase(tbl2.itemId, tbl2.itemType, tbl2.shopPageType)
    end, {
        tbl2.itemId,
        tbl2.itemType,
        tbl2.shopPageType,
        purchaseCategoryLocation
    })
    if isOwned then
        return React.createElement(Button, {
            text = var1.owned,
            variant = ButtonVariant.Standard,
            size = InputSize.Small,
            width = UDim.new(1, 0),
            isDisabled = true,
            LayoutOrder = tbl2.LayoutOrder,
            onActivated = function() end
        })
    end

    if not (FFlagLuaAppEnableGamePassFreeTrials and tbl2.showTry) then
        return React.createElement(Button, {
            text = var1.buy,
            variant = ButtonVariant.Standard,
            size = InputSize.Small,
            width = UDim.new(1, 0),
            onActivated = onActivated,
            isDisabled = tbl2.isActionDisabled == true,
            LayoutOrder = tbl2.LayoutOrder
        })
    end

    return React.createElement(Button, {
        text = var1.try,
        variant = ButtonVariant.Standard,
        size = InputSize.Small,
        width = UDim.new(1, 0),
        onActivated = tbl2.onTryActivated or function() end,
        isLoading = tbl2.isActionLoading,
        isDisabled = tbl2.isActionDisabled == true and tbl2.isActionLoading ~= true,
        LayoutOrder = tbl2.LayoutOrder
    })
end)

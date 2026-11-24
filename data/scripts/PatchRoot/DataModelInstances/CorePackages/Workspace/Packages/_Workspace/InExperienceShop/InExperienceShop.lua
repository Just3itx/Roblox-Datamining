-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FFlagEnableExperienceShopGlobalIcon = require(script.Flags.FFlagEnableExperienceShopGlobalIcon)
local FFlagEnableFreeTrialTopBarChip = require(script.Flags.FFlagEnableFreeTrialTopBarChip)

return {
    ["jest.config"] = script["jest.config"],
    ["jest.main.config"] = script["jest.main.config"],
    ["jest.mockDataModel.config"] = script["jest.mockDataModel.config"],
    ShopContainer = require(script.Components.ShopContainerWrapper.ShopContainer),
    ShopGlobalIcon = if FFlagEnableExperienceShopGlobalIcon then require(script.Components.ShopGlobalIcon) else nil,
    initiateShopItemPurchase = require(script.initiateShopItemPurchase),
    initShopGlobalIcon = if FFlagEnableExperienceShopGlobalIcon then require(script.initShopGlobalIcon) else nil,
    GetShopGlobalIconStore = if FFlagEnableExperienceShopGlobalIcon then require(script.Stores.GetShopGlobalIconStore) else nil,
    requestOpenToRobuxTab = require(script.Utils.requestOpenToRobuxTab),
    setOpenedFromBuyRobux = require(script.Utils.setOpenedFromBuyRobux),
    FFlagEnableExperienceShopGlobalIcon = FFlagEnableExperienceShopGlobalIcon,
    FFlagEnableShopPrefetch = require(script.Flags.FFlagEnableShopPrefetch),
    FFlagHideShopMenuOnFailure = require(script.Flags.FFlagHideShopMenuOnFailure),
    FFlagCenterInExperienceShopWindow = require(script.Flags.FFlagCenterInExperienceShopWindow),
    FFlagFixInExperienceShopCursorLock = require(script.Flags.FFlagFixInExperienceShopCursorLock),
    FFlagExperienceShopNewIconography = require(script.Flags.FFlagExperienceShopNewIconography),
    FFlagEnableFreeTrialShopMenuBadge = require(script.Flags.FFlagEnableFreeTrialShopMenuBadge),
    FFlagMenuBadgePreferFreeTrialOverOffer = require(script.Flags.FFlagMenuBadgePreferFreeTrialOverOffer),
    FFlagEnableFreeTrialBlueDot = require(script.Flags.FFlagEnableFreeTrialBlueDot),
    FFlagEnableFreeTrialTopBarChip = FFlagEnableFreeTrialTopBarChip,
    FreeTrialTopBarSlot = if FFlagEnableFreeTrialTopBarChip then require(script.Components.FreeTrialTopBarSlot) else nil
}

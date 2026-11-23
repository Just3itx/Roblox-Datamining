-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local _Types = require(script.Types)
local PriceStatus = require(script.Enums.PriceStatus)
local useViewBreakpoints = require(script.Hooks.useViewBreakpoints)
local useResponsivePanelLayoutProps = require(script.Components.useResponsivePanelLayoutProps)
local useInspectAndBuyFocusNavigation = require(script.Hooks.useInspectAndBuyFocusNavigation)
local ViewType = require(script.Enums.ViewType)
local InspectAndBuyVersion = require(script.Enums.InspectAndBuyVersion)
local Constants = require(script.Constants)
local BuyActionBar = require(script.Components.Common.BuyActionBar)
local FFlagSocialEnableProfileInspectAndBuy = require(scriptParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy
local FFlagAXIaBEnableShopContext = require(scriptParent.AvatarExperienceFlags).FFlagAXIaBEnableShopContext

local var1 = FFlagSocialEnableProfileInspectAndBuy or FFlagAXIaBEnableShopContext

local _createItemSelectionStore = require(script.Stores.createItemSelectionStore)

local getTryOnItemsTotalPrice = require(script.Utils.getTryOnItemsTotalPrice)

local selectItemDataForTryOnItems = require(script.Utils.selectItemDataForTryOnItems)

return {
    Enums = {
        PriceStatus = PriceStatus,
        ViewType = ViewType,
        InspectAndBuyVersion = InspectAndBuyVersion
    },
    Utils = {
        getPriceStatus = require(script.Utils.getPriceStatus),
        getPriceStatusInShop = if var1 then require(script.Utils.getPriceStatusInShop) else nil,
        getPriceLineContent = if var1 then require(script.Utils.getPriceLineContent) else nil,
        getViewType = require(script.Utils.getViewType),
        applyTryOnItemToHumanoidDescription = require(script.Utils.applyTryOnItemToHumanoidDescription),
        convertAssetInfoToItemData = require(script.Utils.convertAssetInfoToItemData),
        convertBundleInfoToItemData = require(script.Utils.convertBundleInfoToItemData),
        itemDetailsUtils = require(script.Utils.itemDetailsUtils),
        buildBulkPurchaseAnalyticsPayload = require(script.Utils.buildBulkPurchaseAnalyticsPayload),
        buildItemDataFromAXRodux = require(script.Utils.buildItemDataFromAXRodux),
        getTryOnItemsTotalPrice = getTryOnItemsTotalPrice,
        selectItemDataForTryOnItems = selectItemDataForTryOnItems,
        formatNumber = require(script.Utils.formatNumber)
    },
    Hooks = {
        useViewBreakpoints = useViewBreakpoints,
        useResponsivePanelLayoutProps = useResponsivePanelLayoutProps,
        useInspectAndBuyFocusNavigation = useInspectAndBuyFocusNavigation
    },
    Components = {
        BuyActionBar = BuyActionBar,
        ResponsivePanelLayout = require(script.Components.Common.ResponsivePanelLayout),
        SelectableItemCardRow = require(script.Components.Common.SelectableItemCardRow.SelectableCardRowContainer),
        SelectableItemCardList = require(script.Components.Common.SelectableItemCardList.SelectableItemCardList)
    },
    Contexts = {
        ItemSelectionStoreContext = require(script.Contexts.ItemSelectionStoreContext)
    },
    Constants = Constants,
    ["jest.config"] = script["jest.config"]
}

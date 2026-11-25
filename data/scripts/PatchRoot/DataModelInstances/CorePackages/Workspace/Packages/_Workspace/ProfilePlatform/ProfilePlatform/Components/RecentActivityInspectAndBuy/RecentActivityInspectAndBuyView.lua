-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local Dash = require(ProfilePlatformParent.Dash)

local BuyActionBar = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy).Components.BuyActionBar

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local _Types = require(ProfilePlatform.Common.Types)
local InspectAvatarUtils = require(ProfilePlatform.Components.InspectAvatar.InspectAvatarUtils)
local ItemDisplayHelpers = require(ProfilePlatform.Components.InspectAvatar.ItemDisplayHelpers)
local CatalogItemRowCardContainer = require(ProfilePlatform.Components.InspectAvatar.CatalogItemRowCardContainer)

local RecentActivityPurchaseConfirmationDialog = require(script.Parent.RecentActivityPurchaseConfirmationDialog)
local RecentActivityInsufficientRobuxDialog = require(script.Parent.RecentActivityInsufficientRobuxDialog)

local Sheet = Foundation.Sheet
local View = Foundation.View
local FoundationText = Foundation.Text
local Skeleton = Foundation.Skeleton
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local isItemPurchasable = InspectAvatarUtils.isItemPurchasable

local function RecentActivityInspectAndBuyView(tbl1)
    local var1 = useLocalization({
        title = "Feature.Catalog.Label.BuyItems",
        buyHeader = {
            "Feature.Profile.Header.InspectAndBuy.BuySection",
            numberOfSelectedItems = tbl1.purchaseSummary.count,
            totalNumberOfItems = #tbl1.displayItems
        },
        buyWholeLook = "Feature.Profile.Header.BuyWholeLook",
        bundle = "Feature.Catalog.Label.Bundle"
    })

    local priceStatusLocalized = useLocalization(ItemDisplayHelpers.PRICE_STATUS_LOCALIZATION_KEYS)
    local var3 = useLocalization(ItemDisplayHelpers.ASSET_TYPE_LOCALIZATION_KEYS)
    local var4 = useLocalization(ItemDisplayHelpers.BUNDLE_TYPE_LOCALIZATION_KEYS)

    local localizedStrings = React.useMemo(function()
        return {
            bundle = var1.bundle,
            bundleParts = nil,
            assetTypeNames = Dash.join(var3, var4)
        }
    end, { var1.bundle, var3, var4 })

    local tbl2 = ({})
    for index, asset in tbl1.displayItems do
        local id = asset.id
        local str1 = `item_{id}`
        tbl2[str1] = React.createElement(CatalogItemRowCardContainer, {
            asset = asset,
            index = index,
            isChecked = tbl1.selectedItems[id] == true,
            isPurchasable = isItemPurchasable(asset),
            rowHeight = 72,
            localizedStrings = localizedStrings,
            priceStatusLocalized = priceStatusLocalized,
            onToggleItem = tbl1.onToggleItem,
            openItemDetails = tbl1.openItemDetails
        })
    end

    local var6 = React.useMemo(function()
        local result = ({})
        for layoutOrder = 1, 4 do
            local str1 = `Shimmer{layoutOrder}`
            result[str1] = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 72), LayoutOrder = layoutOrder })
        end

        return result
    end, {})

    local createElement = React.createElement
    local fragment = React.Fragment
    local var7 = nil
    local tbl3 = { SheetRoot = 0, PurchaseConfirmation = 0, InsufficientRobux = 0 }
    local createElement2 = React.createElement
    local root = Sheet.Root
    local tbl4 = {
        onClose = tbl1.onClose,
        snapPoints = { 1 },
        size = DialogSize.Large
    }
    local tbl5 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            HeaderTitle = React.createElement(
                FoundationText,
                {
                    tag = "size-full-0 auto-y text-title-large text-align-x-center",
                    Text = var1.title
                }
            )
        }),
        Content = React.createElement(Sheet.Content, nil, {
            ItemList = if tbl1.isLoading then nil else React.createElement(View, { tag = "col gap-large size-full-0 auto-y padding-bottom-large padding-top-medium" }, tbl2),
            LoadingShimmer = if tbl1.isLoading then React.createElement(View, { tag = "col size-full-0 auto-y" }, var6) else nil
        }),
        Actions = 0
    }

    local createElement3 = React.createElement
    local actions = Sheet.Actions
    local tbl6 = { ActionBar = 0 }
    local createElement4 = React.createElement
    local var8 = View

    local tbl7 = {
        BuyBar = React.createElement(BuyActionBar, {
            priceLabel = {
                leftLabel = var1.buyHeader,
                priceInRobux = tostring(tbl1.purchaseSummary.totalPrice)
            },
            purchaseButtonProps = {
                purchaseButtonText = var1.buyWholeLook,
                onPurchase = tbl1.onBuyAll,
                isDisabled = tbl1.isLoading or tbl1.purchaseSummary.count == 0,
                variant = ButtonVariant.Emphasis
            }
        })
    }
    tbl6.ActionBar = createElement4(var8, { tag = "size-full-2500" }, tbl7)
    tbl5.Actions = createElement3(actions, nil, tbl6)
    tbl3.SheetRoot = createElement2(root, tbl4, tbl5)

    tbl3.PurchaseConfirmation = if tbl1.isConfirmingPurchase then React.createElement(
        RecentActivityPurchaseConfirmationDialog,
        {
            totalPrice = tbl1.purchaseSummary.totalPrice,
            isPurchasing = tbl1.isPurchasing,
            onConfirm = tbl1.onConfirmPurchase,
            onCancel = tbl1.onCancelPurchase
        }
    ) else nil

    tbl3.InsufficientRobux = if tbl1.isShowingInsufficientRobux then React.createElement(
        RecentActivityInsufficientRobuxDialog,
        {
            totalPrice = tbl1.purchaseSummary.totalPrice,
            robuxBalance = tbl1.robuxBalance,
            onClose = tbl1.onDismissInsufficientRobux
        }
    ) else nil
    return createElement(fragment, var7, tbl3)
end

return RecentActivityInspectAndBuyView

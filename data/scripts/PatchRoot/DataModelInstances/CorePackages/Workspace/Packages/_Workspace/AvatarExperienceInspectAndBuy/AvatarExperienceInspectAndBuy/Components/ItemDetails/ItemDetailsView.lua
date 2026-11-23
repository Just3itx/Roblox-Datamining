-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local LocalizationService = game:GetService("LocalizationService")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local BundleAssetsList = require(AvatarExperienceInspectAndBuy.Components.ItemDetails.BundleAssetsList)
local Enums = Foundation.Enums
local ItemHeader = require(AvatarExperienceInspectAndBuy.Components.Common.ItemHeader)
local useConvertedItemData = require(AvatarExperienceInspectAndBuy.Hooks.useConvertedItemData)
local useItemExperienceInfo = require(AvatarExperienceInspectAndBuy.Hooks.useItemExperienceInfo)
local ControlBar = require(AvatarExperienceInspectAndBuy.Components.ItemDetails.ControlBar)
local ResellableInstancesLabel = require(AvatarExperienceInspectAndBuy.Components.ItemDetails.ResellableInstancesLabel)
local ItemInfoLabels = require(AvatarExperienceInspectAndBuy.Components.ItemDetails.ItemInfoLabels)
local NumberLocalization = require(AvatarExperienceInspectAndBuyParent.Localization).NumberLocalization
local useItemStatusLocalization = require(AvatarExperienceInspectAndBuy.Hooks.useItemStatusLocalization)
local itemDetailsUtils = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils)
local isCollectible = itemDetailsUtils.isCollectible
local isInExperienceCreationPlayable = itemDetailsUtils.isInExperienceCreationPlayable
local isTradeable = itemDetailsUtils.isTradeable
local getCreatorName = itemDetailsUtils.getCreatorName
local getOriginalPrice = itemDetailsUtils.getOriginalPrice
local getQuantitySold = itemDetailsUtils.getQuantitySold
local ViewportLayout = require(AvatarExperienceInspectAndBuy.Components.ItemsView.ViewportLayout)
local getItemThumbnailUrl = require(AvatarExperienceInspectAndBuy.Utils.getItemThumbnailUrl)
local SubheaderLabelPrice = require(AvatarExperienceInspectAndBuy.Components.Common.SubheaderLabelPrice)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local getPriceInRobux = itemDetailsUtils.getPriceInRobux
local isItemAvailableForTryOn = require(AvatarExperienceInspectAndBuy.Utils.isItemAvailableForTryOn)
local BackButton = require(AvatarExperienceInspectAndBuy.Components.Common.BackButton)
local formatNumber = require(AvatarExperienceInspectAndBuy.Utils.formatNumber)

local _Types = require(AvatarExperienceInspectAndBuy.Types)
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local useTokens = Foundation.Hooks.useTokens
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)

local _PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)

local function func1(view, arg1)
    if view == ViewType.WideLandscape then
        return {
            PaddingTop = UDim.new(0, arg1.Padding.XSmall),
            PaddingLeft = UDim.new(0, arg1.Padding.Medium),
            PaddingRight = UDim.new(0, arg1.Padding.Medium),
            PaddingBottom = UDim.new(0, arg1.Padding.XXLarge)
        }
    end

    if view == ViewType.Wide then
        return {
            PaddingTop = UDim.new(0, arg1.Padding.XSmall),
            PaddingBottom = UDim.new(0, arg1.Padding.XLarge),
            PaddingLeft = UDim.new(0, arg1.Margin.Large * 2),
            PaddingRight = UDim.new(0, arg1.Margin.Large * 2)
        }
    end

    return {
        PaddingTop = UDim.new(0, arg1.Padding.XSmall),
        PaddingBottom = UDim.new(0, arg1.Padding.XLarge),
        PaddingLeft = UDim.new(0, arg1.Padding.XXLarge),
        PaddingRight = UDim.new(0, arg1.Padding.XXLarge)
    }
end

local function func2(wideLandscape, arg1)
    if wideLandscape ~= ViewType.WideLandscape then
        return {
            bottom = UDim.new(0, arg1.Padding.XXLarge)
        }
    end

    return {
        left = UDim.new(0, arg1.Padding.Large),
        right = UDim.new(0, arg1.Padding.Large),
        bottom = UDim.new(0, arg1.Padding.XXLarge)
    }
end

local function func3(compact, tbl1, arg1): UDim2
    if compact == ViewType.Compact then
        return UDim2.new(1, 0, 1, -tbl1.buyActionBarOffset - tbl1.backButtonOffset - arg1.Padding.Small)
    end
    return UDim2.new(1, 0, 1, -tbl1.backButtonOffset - arg1.Padding.Small)
end

local function func4(wide): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if wide == ViewType.Wide then 2.5 else 2
end

local function ItemDetailsView(tbl1)
    local var1 = useTokens()
    local itemData = useConvertedItemData(tbl1.item)
    local creatingUniverseId = if itemData then itemData.creatingUniverseId else nil
    local var3 = useItemExperienceInfo(creatingUniverseId)
    local priceStatus = getPriceStatus(itemData)
    local bool1 = tbl1.view == ViewType.WideLandscape
    local bool2 = tbl1.view == ViewType.Compact
    local bool3 = tbl1.view == ViewType.Wide
    local var4 = useItemStatusLocalization(itemData)
    local tbl2 = func1(tbl1.view, var1)
    local buyActionBarOffset = tbl1.buyActionBarOffset or 0
    local size1000 = var1.Size.Size_1000

    local itemInfoLabels = {
        {
            key = "Category",
            isVisible = true,
            labelProps = {
                leftLabel = var4.category,
                rightLabel = if itemData then var4[itemData.itemSubType] else ""
            }
        },
        {
            key = "QuantitySold",
            isVisible = isCollectible(itemData),
            labelProps = {
                leftLabel = var4.quantitySold,
                rightLabel = getQuantitySold(itemData, tbl1.formatNumber)
            }
        },
        {
            key = "OriginalPrice",
            isVisible = isCollectible(itemData),
            labelProps = {
                leftLabel = var4.originalPrice,
                rightLabel = getOriginalPrice(itemData, var4.na, tbl1.formatNumber)
            }
        },
        {
            key = "Tradeable",
            isVisible = isCollectible(itemData),
            labelProps = {
                leftLabel = var4.tradeable,
                rightLabel = if isTradeable(itemData) then var4.yes else var4.no
            }
        }
    }

    local tbl4 = {
        key = "MadeIn",
        isVisible = isInExperienceCreationPlayable(var3),
        labelProps = 0
    }
    local labelProps = {
        leftLabel = var4.madein,
        rightLabel = 0
    }
    local createElement = React.createElement
    local view = Foundation.View

    local tbl6 = {
        LayoutOrder = 2,
        tag = "auto-xy",
        onActivated = function()
            if tbl1.openAttributionOverlay then
                tbl1.openAttributionOverlay(var3)
            end
        end
    }

    local tbl7 = {
        AttributionLabel = React.createElement(Foundation.View, {
            tag = "auto-xy row gap-small align-y-center"
        }, {
            ExperienceName = if var3 then React.createElement(
                Foundation.Text,
                {
                    LayoutOrder = 1,
                    tag = "auto-xy text-title-medium content-default",
                    Text = var3.name
                }
            )
                or nil else nil,
            ArrowIcon = if var3 then React.createElement(Foundation.Icon, {
                LayoutOrder = 2,
                name = Enums.IconName.ArrowSmallRight,
                variant = Enums.IconVariant.Filled,
                size = Enums.IconSize.Medium,
                style = var1.Color.Content.Default
            })
                or nil else nil
        })
    }
    labelProps.rightLabel = createElement(view, tbl6, tbl7)
    tbl4.labelProps = labelProps
    table.insert(itemInfoLabels, tbl4)

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl8 = { tag = "size-full" }

    local tbl9 = {
        ButtonContainer = React.createElement(Foundation.View, {}, {
            BackButton = React.createElement(BackButton, {
                onBackButtonClick = tbl1.onItemDetailsClosed,
                Size = UDim2.new(0, size1000, 1, 0),
                Position = UDim2.new(0, var1.Padding.Small, 0, var1.Padding.Small)
            })
        }),
        ScrollingFrame = 0
    }

    local createElement3 = React.createElement
    local str1 = "ScrollingFrame"
    local tbl10 = {
        Size = func3(tbl1.view, { buyActionBarOffset = buyActionBarOffset, backButtonOffset = size1000 }, var1),
        Position = UDim2.new(0, 0, 0, size1000 + var1.Padding.Medium),
        CanvasSize = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarThickness = 0,
        BorderSizePixel = 0
    }

    local tbl11 = {
        UIPadding = React.createElement("UIPadding", tbl2),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, var1.Padding.Small)
        }),
        ViewportLayout = 0,
        Header = 0,
        DetailsContainer = 0
    }
    local element

    if bool2 or bool3 then
        element = React.createElement(ViewportLayout, {
            view = tbl1.view,
            LayoutOrder = 1,
            thumbnailUrl = getItemThumbnailUrl(tbl1.item) or "",
            viewportProps = {
                Size = UDim2.new(0, var1.Size.Size_3000 * func4(tbl1.view), 0, var1.Size.Size_3000 * func4(tbl1.view))
            },
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            renderTryOnViewport = tbl1.renderTryOnViewport,
            tryOnState = tbl1.tryOnState
        })
    else
        element = nil
    end

    tbl11.ViewportLayout = element

    tbl11.Header = React.createElement(ItemHeader, {
        LayoutOrder = 1,
        headerHeight = var1.Size.Size_1300,
        purchaseButtonProps = tbl1.purchaseButtonProps,
        padding = func2(tbl1.view, var1),
        header = React.createElement(Foundation.Text, {
            LayoutOrder = 1,
            tag = "auto-xy text-heading-small content-emphasis text-truncate-end",
            Text = itemData and itemData.name or ""
        }),
        subheader = if bool3 then React.createElement(SubheaderLabelPrice, {
            subheaderText = {
                leftSlotLabel = getCreatorName(itemData),
                rightSlotPrice = formatNumber(getPriceInRobux(itemData, priceStatus))
            },
            priceStatus = priceStatus,
            LayoutOrder = 2
        }) else React.createElement(
            Foundation.Text,
            {
                LayoutOrder = 2,
                tag = "auto-xy text-body-large content-emphasis text-truncate-end",
                Text = getCreatorName(itemData)
            }
        )
    })

    local createElement4 = React.createElement
    local view3 = Foundation.View
    local tbl12 = { tag = "auto-xy col align-x-left align-y-top gap-small", LayoutOrder = 2 }

    local tbl13 = {
        UIPadding = if bool1 then React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, var1.Padding.Large),
                PaddingRight = UDim.new(0, var1.Padding.Large)
            }
        ) else nil,
        ControlBar = 0,
        DescriptionLabel = 0,
        ResellableInstancesLabel = 0,
        ItemInfoLabels = 0,
        BundleAssetsList = 0
    }

    local createElement5 = React.createElement
    local var5 = ControlBar
    local tbl14 = { LayoutOrder = 1, favoritesBadge = 0, tryOnBadge = 0 }

    local favoritesBadge = {
        text = if itemData and itemData.favoritesDetails and itemData.favoritesDetails.numFavorites then NumberLocalization.abbreviate(itemData.favoritesDetails.numFavorites, LocalizationService.RobloxLocaleId) else nil,
        iconVariant = if itemData and itemData.favoritesDetails and itemData.favoritesDetails.isFavorited then Enums.IconVariant.Filled else Enums.IconVariant.Regular,
        onActivated = 0,
        LayoutOrder = 1
    }

    function favoritesBadge.onActivated()
        if itemData and itemData.favoritesDetails then
            tbl1.onToggleFavorite(tbl1.item, itemData.favoritesDetails.isFavorited or false)
        end
    end

    tbl14.favoritesBadge = favoritesBadge
    local tbl16

    if itemData and isItemAvailableForTryOn(tbl1.localPlayerModel, itemData) then
        tbl16 = {
            text = var4.tryOn,
            iconVariant = if tbl1.tryOnState.isTryOnEnabled then Enums.IconVariant.Filled else Enums.IconVariant.Regular,
            onActivated = 0,
            LayoutOrder = 2
        }

        function tbl16.onActivated()
            if not itemData then
                return
            end

            tbl1.onToggleTryOn({
                itemId = itemData.id,
                itemType = itemData.itemType,
                itemSubType = itemData.itemSubType,
                assetsInBundle = itemData.assetsInBundle
            })
        end
    else
        tbl16 = nil
    end

    tbl14.tryOnBadge = tbl16
    tbl13.ControlBar = createElement5(var5, tbl14)

    tbl13.DescriptionLabel = React.createElement(Foundation.Text, {
        LayoutOrder = 3,
        tag = "auto-xy text-body-medium content-emphasis text-truncate-end text-align-x-left text-wrap padding-bottom-large padding-top-large",
        Text = if itemData then itemData.description else ""
    })
    tbl13.ResellableInstancesLabel = if isCollectible(itemData)
        and itemData
        and itemData.collectibleItemDetails
        and itemData.collectibleItemDetails.resellableCount > 0 then React.createElement(
        ResellableInstancesLabel,
        {
            ownedItemsLabel = var4.ownedItems,
            padding = {
                top = UDim.new(0, var1.Padding.Large)
            },
            LayoutOrder = 3
        }
    ) else nil

    tbl13.ItemInfoLabels = React.createElement(ItemInfoLabels, { LayoutOrder = 5, itemInfoLabels = itemInfoLabels })

    tbl13.BundleAssetsList = if itemData and itemData.assetsInBundle and #itemData.assetsInBundle > 0 then React.createElement(
        BundleAssetsList,
        {
            itemData = itemData,
            headerLabel = var4.includedParts,
            view = tbl1.view,
            LayoutOrder = 6
        }
    ) else nil
    tbl11.DetailsContainer = createElement4(view3, tbl12, tbl13)
    tbl9.ScrollingFrame = createElement3(str1, tbl10, tbl11)
    return createElement2(view2, tbl8, tbl9)
end

return ItemDetailsView

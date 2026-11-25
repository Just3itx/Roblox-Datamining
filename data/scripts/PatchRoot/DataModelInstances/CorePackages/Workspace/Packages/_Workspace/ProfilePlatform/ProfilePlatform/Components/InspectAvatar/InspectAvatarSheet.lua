-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)

local DisplayBackground = require(ProfilePlatformParent.EditProfileBackground).DisplayBackground

local BuyActionBar = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy).Components.BuyActionBar
local Dash = require(ProfilePlatformParent.Dash)

local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(ProfilePlatformParent.InputHandlers)

local FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav
local FFlagProfileInspectAvatarBuyAll = require(ProfilePlatform.Flags.FFlagProfileInspectAvatarBuyAll)
local FFlagProfileInspectAvatarBackground = require(ProfilePlatform.Flags.FFlagProfileInspectAvatarBackground)

local View = Foundation.View
local Image = Foundation.Image
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local Divider = Foundation.Divider
local Skeleton = Foundation.Skeleton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local _Types = require(ProfilePlatform.Common.Types)
local ItemDisplayHelpers = require(script.Parent.ItemDisplayHelpers)
local InspectAvatarUtils = require(script.Parent.InspectAvatarUtils)
local CatalogItemRowCardContainer = require(script.Parent.CatalogItemRowCardContainer)

local isItemPurchasable = InspectAvatarUtils.isItemPurchasable

local function InspectAvatarSheet(tbl1)
    local var1 = useLocalization({
        title = {
            "Feature.Profile.Header.InspectAndBuy",
            username = tbl1.username
        },
        buyHeader = {
            "Feature.Profile.Header.InspectAndBuy.BuySection",
            numberOfSelectedItems = tbl1.purchaseSummary.count,
            totalNumberOfItems = #tbl1.displayItems
        },
        buyItems = "Feature.Catalog.Label.BuyItems",
        buyWholeLook = "Feature.Profile.Header.BuyWholeLook",
        bundle = "Feature.Catalog.Label.Bundle"
    })

    local priceStatusLocalized = useLocalization(ItemDisplayHelpers.PRICE_STATUS_LOCALIZATION_KEYS)
    local xLarge = if FFlagProfileInspectAvatarBackground then useTokens().Padding.XLarge else nil
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

    local handler = if FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav then React.useMemo(function()
        return InputHandlers.onRelease(function(arg1)
            arg1:cancel()
            tbl1.onClose()
        end)
    end, { tbl1.onClose }) else nil

    local tbl3 = {
        Scrim = React.createElement("TextButton", {
            Size = UDim2.new(1, -tbl1.cardWidth, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            Selectable = not FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav and nil,
            [React.Event.Activated] = tbl1.onDismiss
        }),
        Sheet = 0
    }
    local createElement = React.createElement
    local var7 = View
    local tbl4 = {
        tag = "col position-top-right anchor-top-right margin-bottom-small padding-x-xlarge bg-surface-0",
        Size = UDim2.new(0, tbl1.cardWidth, 1, 0)
    }
    local tbl5 = {
        StatusBarSpacer = if tbl1.topOffset > 0 then React.createElement(View, { tag = "bg-surface-0", Size = UDim2.new(1, 0, 0, tbl1.topOffset), LayoutOrder = 0 }) else nil,
        AvatarViewport = 0,
        Title = 0,
        ScrollWrapper = 0,
        FooterDivider = 0,
        Footer = 0
    }

    local createElement2 = React.createElement
    local var8 = View
    local tbl6 = {
        Size = UDim2.new(1, 0, 0, tbl1.avatarViewportHeight),
        LayoutOrder = 1
    }
    local tbl7 = { BackgroundClipper = 0, Background = 0, TopBar = 0 }
    local element

    if FFlagProfileInspectAvatarBackground and tbl1.avatarBackgroundImage ~= nil then
        element = React.createElement(
            View,
            {
                ClipsDescendants = true,
                Size = UDim2.new(1, xLarge * 2, 1, 0),
                Position = UDim2.new(0, -xLarge, 0, 0),
                ZIndex = 1
            },
            {
                BackgroundImage = React.createElement(Image, {
                    Size = UDim2.fromScale(1.35, 1.35),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Image = tbl1.avatarBackgroundImage,
                    ScaleType = Enum.ScaleType.Crop
                })
            }
        )
    else
        element = nil
    end

    tbl7.BackgroundClipper = element

    tbl7.Background = React.createElement(
        DisplayBackground,
        {
            height = tbl1.avatarViewportHeight,
            userId = tonumber(tbl1.profileId),
            userThumbnail = tbl1.avatarThumbnail
        }
    )
    local createElement3 = React.createElement
    local var9 = View
    local tbl8 = {
        tag = {
            ["row align-y-center"] = FFlagProfileInspectAvatarBackground,
            ["row align-y-center size-full-0 auto-y padding-small"] = not FFlagProfileInspectAvatarBackground
        },
        Size = if FFlagProfileInspectAvatarBackground then UDim2.new(1, 0, 0, 56) else nil,
        Position = if FFlagProfileInspectAvatarBackground then UDim2.new(0, 10 - xLarge, 0, 0) else nil,
        ZIndex = 2
    }

    local tbl9 = { BackButtonCircle = 0, BackButton = 0 }
    local element2

    if FFlagProfileInspectAvatarBackground then
        element2 = React.createElement(View, {
            tag = "radius-circle bg-over-media-0",
            Size = UDim2.fromOffset(36, 36)
        }, {
            BackButton = React.createElement(IconButton, {
                icon = IconName.ChevronLargeLeft,
                size = IconSize.Small,
                variant = ButtonVariant.Utility,
                onActivated = tbl1.onClose,
                isCircular = true,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            })
        })
    else
        element2 = nil
    end

    tbl9.BackButtonCircle = element2

    tbl9.BackButton = if FFlagProfileInspectAvatarBackground then nil else React.createElement(IconButton, {
        icon = IconName.ChevronLargeLeft,
        size = IconSize.Medium,
        variant = ButtonVariant.Utility,
        onActivated = tbl1.onClose,
        isCircular = true
    })
    tbl7.TopBar = createElement3(var9, tbl8, tbl9)
    tbl5.AvatarViewport = createElement2(var8, tbl6, tbl7)

    tbl5.Title = React.createElement(
        FoundationText,
        {
            tag = "size-full-0 auto-y padding-y-small text-heading-small text-align-x-left",
            Text = var1.title,
            LayoutOrder = 2
        }
    )
    local createElement4 = React.createElement
    local var10 = View
    local tbl10 = { tag = "fill size-full-0", LayoutOrder = 3 }

    local tbl11 = { ScrollContent = 0 }
    local createElement5 = React.createElement
    local str1 = "ScrollingFrame"
    local tbl12 = {
        Size = UDim2.fromScale(1, 1),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl13 = {
        ItemList = if tbl1.isLoading then nil else React.createElement(View, { tag = "col gap-large size-full-0 auto-y padding-bottom-large padding-top-medium" }, tbl2),
        LoadingShimmer = 0
    }
    local var11

    if tbl1.isLoading then
        local createElement6 = React.createElement
        local var12 = View
        local tbl14 = { tag = "col size-full-0 auto-y" }

        local tbl15 = ({})
        for layoutOrder = 1, 4 do
            local str2 = `Shimmer{layoutOrder}`
            tbl15[str2] = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 72), LayoutOrder = layoutOrder })
        end

        var11 = createElement6(var12, tbl14, tbl15)
    else
        var11 = nil
    end

    tbl13.LoadingShimmer = var11
    tbl11.ScrollContent = createElement5(str1, tbl12, tbl13)
    tbl5.ScrollWrapper = createElement4(var10, tbl10, tbl11)

    tbl5.FooterDivider = React.createElement(Divider, { Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 4 })

    local createElement6 = React.createElement
    local var12 = View
    local tbl14 = { tag = "size-full-2500 bg-surface-0", LayoutOrder = 5 }

    local tbl15 = {
        ActionBar = React.createElement(BuyActionBar, {
            priceLabel = {
                leftLabel = var1.buyHeader,
                priceInRobux = tostring(tbl1.purchaseSummary.totalPrice)
            },
            purchaseButtonProps = {
                purchaseButtonText = if FFlagProfileInspectAvatarBuyAll then var1.buyWholeLook else var1.buyItems,
                onPurchase = tbl1.onBuyAll,
                isDisabled = tbl1.isLoading or tbl1.purchaseSummary.count == 0,
                variant = ButtonVariant.Emphasis
            }
        })
    }
    tbl5.Footer = createElement6(var12, tbl14, tbl15)
    tbl3.Sheet = createElement(var7, tbl4, tbl5)

    if not FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav then
        return React.createElement(View, { Size = UDim2.fromScale(1, 1) }, tbl3)
    end

    return React.createElement(AppFocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        isIsolated = true,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = { handler = handler }
        }
    }, tbl3)
end

return InspectAvatarSheet

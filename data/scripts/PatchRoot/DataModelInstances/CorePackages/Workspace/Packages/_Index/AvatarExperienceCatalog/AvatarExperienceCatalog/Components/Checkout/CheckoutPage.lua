-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local Responsive = require(AvatarExperienceCatalogParent.Responsive)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local tutils = require(AvatarExperienceCatalogParent.tutils)
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local useSelector = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useSelector

local RobloxSubscriptionPurchaseApp = require(AvatarExperienceCatalogParent.RobloxSubscriptionPurchaseApp)
local BlackbirdUpsellBanner = RobloxSubscriptionPurchaseApp.Components.BlackbirdUpsellBanner
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext

local Constants = AvatarExperienceCommon.Constants
local OfferExpiryBadge = AvatarExperienceCommon.Components.OfferExpiryBadge

local CheckoutPageHeader = require(AvatarExperienceCatalog.Components.Checkout.CheckoutPageHeader)
local CheckoutPageBody = require(AvatarExperienceCatalog.Components.Checkout.CheckoutPageBody)
local CheckoutBuyButton = require(AvatarExperienceCatalog.Components.Checkout.CheckoutBuyButton)
local CheckoutTotalLines = require(AvatarExperienceCatalog.Components.Checkout.CheckoutTotalLines)
local CheckoutUnavailableButton = require(AvatarExperienceCatalog.Components.Checkout.CheckoutUnavailableButton)
local _CartPricingForOffersTypes = require(AvatarExperienceCatalog.Api.PostCartPricingForOffers.CartPricingForOffersTypes)
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local FFlagAXEnableExpiredUserLookCheckout = AvatarExperienceFlags.FFlagAXEnableExpiredUserLookCheckout
local FFlagAXMISSmallUIChanges = AvatarExperienceFlags.FFlagAXMISSmallUIChanges
local FFlagAXMISWithOffers = AvatarExperienceFlags.FFlagAXMISWithOffers
local FFlagAXDurables2Option = AvatarExperienceFlags.FFlagAXDurables2Option
local FFlagAXUpdateOffersEndsUIWithBadge = AvatarExperienceFlags.FFlagAXUpdateOffersEndsUIWithBadge
local SplitPaneStore = if FFlagEnableSplitPane then require(AvatarExperienceCatalogParent.SplitPane).SplitPaneStore else nil
local useSignalState = if FFlagEnableSplitPane then require(AvatarExperienceCatalogParent.SignalsReact).useSignalState else nil

local function selectDeviceOrientation(arg1)
    return arg1.DeviceOrientation
end

local function selectStatusBarHeight(arg1)
    return if arg1 and arg1.TopBar and arg1.TopBar.statusBarHeight then arg1.TopBar.statusBarHeight else 0
end

local function onActivated()
    RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
        { showBackButton = true },
        {
            onFlowComplete = function(_) end
        },
        nil,
        SurfaceName.CatalogMultiItemCheckoutPage,
        SurfaceContext.InApp,
        nil,
        nil
    )
end
return React.memo(function(arg1) -- name: CheckoutPage
    local iapExperience = require(AvatarExperienceCatalogParent.IAPExperience)
    local purchasePrompt = require(AvatarExperienceCatalogParent.PurchasePrompt)

    local var1 = Foundation.Hooks.useTokens()
    local var2 = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getIsBreakpointEnabled) else false
    local xScale = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getSupportWidthFraction) else nil
    local var3 = useSelector(selectDeviceOrientation)
    if FFlagEnableSplitPane and var2 then
        var3 = Responsive.Keys.Landscape
    end
    local bool1 = var3 == Responsive.Keys.Portrait

    local offset = useSelector(selectStatusBarHeight)

    local var4 = useLocalization({
        buyLabel = "Feature.Catalog.Action.Buy",
        wearAfterPurchaseLabel = "Feature.Catalog.Checkout.WearAfterPurchase",
        addToMyAvatarsLabel = "Feature.Avatar.Label.Title.AddToMyAvatars",
        addToMyMakeupLooksLabel = "Feature.Avatar.Label.Title.AddToMyMakeupLooks",
        saveOptionsLabel = if FFlagAXMISWithOffers then "Feature.Catalog.Label.SaveOptions" else nil
    })

    local var5 = React.useMemo(function()
        for _, cartItem in arg1.cartItems do
            if not Constants.MAKEUP_LOOK_ASSET_TYPES[cartItem.itemSubType] then
                return true
            end
        end
        return false
    end, { arg1.cartItems })

    local xScale2 = if FFlagEnableSplitPane and var2 then xScale else Constants.LANDSCAPE_SCENE_WIDTH_PERCENTAGE
    local xScale3 = if FFlagEnableSplitPane and var2 then 1 - xScale else Constants.LANDSCAPE_UI_WIDTH_PERCENTAGE
    local uDim2 = if bool1 then UDim2.fromScale(1, 1) else UDim2.fromScale(xScale2, 1)
    local uDim2_2 = if bool1 then UDim2.fromScale(0, 0) else UDim2.fromScale(xScale3, 0)

    local var6 = React.useMemo(function()
        if not FFlagAXMISWithOffers then
            return nil
        end
        local result = ({})

        if arg1.offersAvailable then
            for value, value2 in arg1.offersAvailable do
                local var6 = "Offer_" .. value
                local createElement = React.createElement
                local str1 = "TextButton"
                local tbl1 = {
                    Text = "",
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Selectable = false,
                    LayoutOrder = 0
                }

                tbl1[React.Event.Activated] = function()
                    if arg1.handleDeselectOfferId then
                        arg1.handleDeselectOfferId(value)
                    end
                end

                local tbl2 = { Content = 0 }
                local var7

                if FFlagAXUpdateOffersEndsUIWithBadge then
                    local createElement2 = React.createElement
                    local view = Foundation.View
                    local tbl3 = {
                        tag = "row gap-medium auto-xy align-y-center",
                        Position = UDim2.fromOffset(var1.Stroke.Standard, 0)
                    }
                    local tbl4 = { Checkbox = 0, ExpiryBadge = 0 }
                    local createElement3 = React.createElement
                    local checkbox = Foundation.Checkbox
                    local tbl5 = {
                        label = value2.localizedDescription,
                        isChecked = value2.selected,
                        onActivated = 0,
                        size = 0,
                        LayoutOrder = 1
                    }

                    function tbl5.onActivated()
                        if arg1.handleDeselectOfferId then
                            arg1.handleDeselectOfferId(value)
                        end
                    end
                    tbl5.size = Foundation.Enums.InputSize.Small
                    tbl4.Checkbox = createElement3(checkbox, tbl5)
                    local element = if value2.expirationTimeUtc then React.createElement(OfferExpiryBadge, { layoutOrder = 2, expirationTimeInUTC = value2.expirationTimeUtc }) else nil
                    tbl4.ExpiryBadge = element
                    var7 = createElement2(view, tbl3, tbl4)
                else
                    local createElement2 = React.createElement
                    local view = Foundation.View
                    local tbl3 = {
                        tag = "row gap-medium auto-xy align-y-center",
                        Position = UDim2.fromOffset(var1.Stroke.Standard, 0)
                    }
                    local tbl4 = { Checkbox = 0, Label = 0 }
                    local createElement3 = React.createElement
                    local checkbox = Foundation.Checkbox
                    local tbl5 = {
                        label = "",
                        isChecked = value2.selected,
                        onActivated = 0,
                        size = 0,
                        LayoutOrder = 1
                    }

                    function tbl5.onActivated()
                        if arg1.handleDeselectOfferId then
                            arg1.handleDeselectOfferId(value)
                        end
                    end
                    tbl5.size = Foundation.Enums.InputSize.Small
                    tbl4.Checkbox = createElement3(checkbox, tbl5)

                    tbl4.Label = React.createElement(Foundation.Text, {
                        Text = "<b>" .. value2.localizedDescription .. "</b>",
                        RichText = true,
                        tag = "text-body-small content-default auto-xy",
                        LayoutOrder = 2
                    })
                    var7 = createElement2(view, tbl3, tbl4)
                end

                tbl2.Content = var7
                result[var6] = createElement(str1, tbl1, tbl2)
            end
        end

        return result
    end, { arg1.offersAvailable, arg1.handleDeselectOfferId })

    if not FFlagAXMISWithBlackbird then
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl1 = {
            BackgroundTransparency = 0,
            BackgroundColor3 = var1.Color.Surface.Surface_0.Color3,
            BorderSizePixel = 0,
            Transparency = 1,
            [React.Tag] = if FFlagEnableSplitPane then "data-testid=CheckoutPage" else nil,
            Size = uDim2,
            Position = uDim2_2,
            Active = true,
            Visible = arg1.isVisible,
            SelectionGroup = true,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        }
        local tbl2 = {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, offset) }),
            ListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            CheckoutPageHeader = React.createElement(
                Foundation.View,
                {
                    tag = "size-full-0 auto-y",
                    isDisabled = not arg1.isVisible,
                    LayoutOrder = 1,
                    testId = "CheckoutPageHeaderContainer"
                },
                {
                    Header = React.createElement(CheckoutPageHeader)
                }
            ),
            CheckoutPageBodyScrollView = React.createElement(Foundation.ScrollView, {
                LayoutOrder = 2,
                isDisabled = arg1.isPurchasing,
                scroll = {
                    scrollBarVisibility = Foundation.Enums.Visibility.None,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.fromScale(0, 1)
                },
                flexItem = {
                    FlexMode = Enum.UIFlexMode.Fill
                },
                Size = UDim2.fromScale(1, 1),
                selection = { Selectable = false }
            }, {
                CheckoutPageBody = React.createElement(CheckoutPageBody, { cartItems = arg1.cartItems, erroredItemCount = arg1.erroredItemCount })
            }),
            CheckoutPageBuyOptions = 0,
            CheckoutPageBuyBorder = 0,
            CheckoutPageBuySection = 0
        }
        local var7

        if FFlagAXEnableExpiredUserLookCheckout and arg1.hideBuyOptions then
            var7 = nil
        else
            local createElement2 = React.createElement
            local view = Foundation.View
            local tbl3 = {
                tag = "size-full-0 auto-y col gap-medium padding-x-xxlarge padding-y-medium",
                LayoutOrder = 3
            }

            local tbl4 = {
                CheckoutPageWearAfterPurchase = React.createElement(Foundation.Checkbox, {
                    label = var4.wearAfterPurchaseLabel,
                    size = Foundation.Enums.InputSize.Small,
                    isChecked = arg1.isWearAfterPurchaseChecked,
                    onActivated = arg1.onWearAfterPurchaseToggle,
                    isDisabled = arg1.isPurchasing,
                    LayoutOrder = 1
                }),
                AddToMyAvatars = React.createElement(Foundation.Checkbox, {
                    label = if var5 then var4.addToMyAvatarsLabel else var4.addToMyMakeupLooksLabel,
                    size = Foundation.Enums.InputSize.Small,
                    isChecked = arg1.isAddToMyAvatarsChecked,
                    onActivated = arg1.onAddToMyAvatarsToggle,
                    isDisabled = arg1.isPurchasing,
                    LayoutOrder = 2
                })
            }
            var7 = createElement2(view, tbl3, tbl4)
        end

        tbl2.CheckoutPageBuyOptions = var7

        tbl2.CheckoutPageBuyBorder = React.createElement(
            Foundation.View,
            {
                Size = UDim2.new(1, 0, 0, 1),
                backgroundStyle = var1.Color.Stroke.Muted,
                LayoutOrder = 4
            }
        )

        tbl2.CheckoutPageBuySection = React.createElement(
            Foundation.View,
            {
                tag = "size-full-0 auto-y col gap-medium padding-xxlarge",
                LayoutOrder = 5,
                isDisabled = arg1.isPurchasing
            },
            {
                CheckoutTotalLines = React.createElement(CheckoutTotalLines, {
                    itemCount = tutils.fieldCount(arg1.cartItems),
                    totalPrice = arg1.purchasableItemsTotalPriceInRobux,
                    totalOriginalPrice = arg1.purchasableItemsTotalOriginalPriceInRobux,
                    userRobuxBalance = 0
                }),
                CheckoutBuyButton = if arg1.canPurchase then React.createElement(
                    CheckoutBuyButton,
                    {
                        onCheckoutButtonActivated = arg1.onCheckoutButtonActivated,
                        isPurchasing = arg1.isPurchasing,
                        label = var4.buyLabel
                    }
                ) else React.createElement(
                    CheckoutUnavailableButton,
                    {
                        onActivated = arg1.onUnavailableButtonActivated,
                        label = var4.buyLabel
                    }
                )
            }
        )
        return createElement(str1, tbl1, tbl2)
    end

    local productInfo = purchasePrompt.Utils.getBlackbirdUpsellBannerProductInfo(arg1.robloxSubscriptionProducts)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        BackgroundTransparency = 0,
        BackgroundColor3 = var1.Color.Surface.Surface_0.Color3,
        BorderSizePixel = 0,
        Transparency = 1,
        [React.Tag] = if FFlagEnableSplitPane then "data-testid=CheckoutPage" else nil,
        Size = uDim2,
        Position = uDim2_2,
        Active = true,
        Visible = arg1.isVisible,
        SelectionGroup = true,
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
        SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    }
    local tbl2 = {
        UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, offset) }),
        ListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        CheckoutPageHeader = React.createElement(
            Foundation.View,
            {
                tag = "size-full-0 auto-y",
                isDisabled = not arg1.isVisible,
                LayoutOrder = 1,
                testId = "CheckoutPageHeaderContainer"
            },
            {
                Header = React.createElement(CheckoutPageHeader)
            }
        ),
        CheckoutPageBodyScrollView = 0,
        CheckoutPageBuySection = 0
    }

    local createElement2 = React.createElement
    local scrollView = Foundation.ScrollView
    local tbl3 = {
        LayoutOrder = 2,
        isDisabled = arg1.isPurchasing,
        scroll = {
            scrollBarVisibility = Foundation.Enums.Visibility.None,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(0, 1)
        },
        flexItem = {
            FlexMode = Enum.UIFlexMode.Fill
        },
        Size = UDim2.fromScale(1, 1),
        selection = { Selectable = false }
    }

    local tbl4 = {
        ListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        CheckoutPageBody = React.createElement(Foundation.View, {
            tag = "size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Body = React.createElement(CheckoutPageBody, { cartItems = arg1.cartItems, erroredItemCount = arg1.erroredItemCount })
        }),
        CheckoutPageBuyOptions = 0
    }
    local element

    if FFlagAXEnableExpiredUserLookCheckout and arg1.hideBuyOptions then
        element = React.createElement(Foundation.View, {
            tag = if FFlagAXDurables2Option then "col gap-medium size-full-0 auto-y padding-x-xxlarge padding-bottom-medium" else "col gap-medium size-full-0 auto-y padding-x-xxlarge padding-bottom-medium padding-top-xxlarge",
            LayoutOrder = 3
        }, {
            OfferCheckboxes = if FFlagAXMISWithOffers and var6 and #Cryo.Dictionary.keys(var6) > 0 then React.createElement(React.Fragment, nil, var6) else nil
        })
    else
        local createElement3 = React.createElement
        local view = Foundation.View
        local tbl5 = {
            tag = if FFlagAXDurables2Option then "col gap-medium size-full-0 auto-y padding-x-xxlarge padding-bottom-medium" else "col gap-medium size-full-0 auto-y padding-x-xxlarge padding-bottom-medium padding-top-xxlarge",
            LayoutOrder = 3
        }

        local tbl6 = {
            OfferCheckboxes = if FFlagAXMISWithOffers and var6 and #Cryo.Dictionary.keys(var6) > 0 then React.createElement(React.Fragment, nil, var6) else nil,
            CheckoutPageWearAfterPurchase = if FFlagAXMISWithOffers then nil else React.createElement(Foundation.Checkbox, {
                label = var4.wearAfterPurchaseLabel,
                size = Foundation.Enums.InputSize.Small,
                isChecked = arg1.isWearAfterPurchaseChecked,
                onActivated = arg1.onWearAfterPurchaseToggle,
                isDisabled = arg1.isPurchasing,
                LayoutOrder = 1
            }),
            AddToMyAvatars = 0,
            SaveOptions = 0,
            WearAfterPurchaseCheckbox = 0,
            AddToMyAvatarsCheckbox = 0
        }
        local element2

        if FFlagAXMISWithOffers then
            element2 = nil
        else
            element2 = React.createElement(Foundation.Checkbox, {
                label = if var5 then var4.addToMyAvatarsLabel else var4.addToMyMakeupLooksLabel,
                size = Foundation.Enums.InputSize.Small,
                isChecked = arg1.isAddToMyAvatarsChecked,
                onActivated = arg1.onAddToMyAvatarsToggle,
                isDisabled = arg1.isPurchasing,
                LayoutOrder = 2
            })
        end

        tbl6.AddToMyAvatars = element2
        local var7

        if FFlagAXMISWithOffers then
            local createElement4 = React.createElement
            local view2 = Foundation.View
            local tbl7 = {
                tag = "row align-y-center auto-xy",
                onActivated = arg1.onSaveOptionsOpenToggle,
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.None
                },
                LayoutOrder = 1
            }

            local tbl8 = {
                Label = React.createElement(Foundation.Text, { Text = var4.saveOptionsLabel, tag = "auto-xy text-body-small", LayoutOrder = 1 }),
                Chevron = React.createElement(Foundation.Icon, {
                    name = if arg1.isSaveOptionsOpen then Foundation.Enums.IconName.ChevronSmallUp else Foundation.Enums.IconName.ChevronSmallDown,
                    size = Foundation.Enums.IconSize.Medium,
                    LayoutOrder = 2
                })
            }
            var7 = createElement4(view2, tbl7, tbl8)
        else
            var7 = nil
        end

        tbl6.SaveOptions = var7
        local element3

        if FFlagAXMISWithOffers and arg1.isSaveOptionsOpen then
            element3 = React.createElement(Foundation.Checkbox, {
                label = var4.wearAfterPurchaseLabel,
                size = Foundation.Enums.InputSize.Small,
                isChecked = arg1.isWearAfterPurchaseChecked,
                onActivated = arg1.onWearAfterPurchaseToggle,
                isDisabled = arg1.isPurchasing,
                LayoutOrder = 2
            })
        else
            element3 = nil
        end

        tbl6.WearAfterPurchaseCheckbox = element3
        local element4

        if FFlagAXMISWithOffers and arg1.isSaveOptionsOpen then
            element4 = React.createElement(Foundation.Checkbox, {
                label = if var5 then var4.addToMyAvatarsLabel else var4.addToMyMakeupLooksLabel,
                size = Foundation.Enums.InputSize.Small,
                isChecked = arg1.isAddToMyAvatarsChecked,
                onActivated = arg1.onAddToMyAvatarsToggle,
                isDisabled = arg1.isPurchasing,
                LayoutOrder = 3
            })
        else
            element4 = nil
        end

        tbl6.AddToMyAvatarsCheckbox = element4
        element = createElement3(view, tbl5, tbl6)
    end

    tbl4.CheckoutPageBuyOptions = element
    tbl2.CheckoutPageBodyScrollView = createElement2(scrollView, tbl3, tbl4)

    tbl2.CheckoutPageBuySection = React.createElement(Foundation.View, {
        tag = "col gap-medium size-full-0 auto-y padding-x-xxlarge padding-bottom-xxlarge padding-top-medium",
        LayoutOrder = 4,
        isDisabled = arg1.isPurchasing
    }, {
        CheckoutTotalLines = React.createElement(CheckoutTotalLines, {
            itemCount = tutils.fieldCount(arg1.cartItems),
            totalPrice = arg1.purchasableItemsTotalPriceInRobux,
            totalOriginalPrice = arg1.purchasableItemsTotalOriginalPriceInRobux,
            userRobuxBalance = 0,
            LayoutOrder = if FFlagAXMISSmallUIChanges then 2 else 1
        }),
        DiscountSummary = if arg1.discountSummaryProps then React.createElement(
            Foundation.View,
            {
                tag = "size-full-0 auto-y",
                LayoutOrder = if FFlagAXMISSmallUIChanges then 1 else 2
            },
            {
                Content = React.createElement(iapExperience.DiscountSummary, arg1.discountSummaryProps)
            }
        ) else nil,
        CheckoutBuyButton = if arg1.canPurchase then React.createElement(CheckoutBuyButton, {
            onCheckoutButtonActivated = arg1.onCheckoutButtonActivated,
            isPurchasing = arg1.isPurchasing,
            label = var4.buyLabel,
            LayoutOrder = 3
        }) else React.createElement(
            CheckoutUnavailableButton,
            {
                onActivated = arg1.onUnavailableButtonActivated,
                label = var4.buyLabel,
                LayoutOrder = 3
            }
        ),
        BlackbirdUpsellBanner = if arg1.shouldShowBlackbirdUpsellBanner and productInfo then React.createElement(BlackbirdUpsellBanner, { productInfo = productInfo, onActivated = onActivated, LayoutOrder = 4 }) else nil
    })
    return createElement(str1, tbl1, tbl2)
end, tutils.deepEqual)

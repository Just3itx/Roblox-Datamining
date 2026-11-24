-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local UnifiedPurchaseCompletionModal = require(InExperienceShopParent.IAPExperience).UnifiedPurchaseCompletionModal
local FFlagShopRobuxPurchaseCompletionModal = require(InExperienceShop.Flags.FFlagShopRobuxPurchaseCompletionModal)
local View = Foundation.View
local Tabs = Foundation.Tabs
local FillBehavior = Foundation.Enums.FillBehavior
local useTokens = Foundation.Hooks.useTokens

local SharedFlags = require(InExperienceShopParent.SharedFlags)
local isSubjectToDesktopPolicies = SharedFlags.isSubjectToDesktopPolicies
local FFlagHideHeaderForBuyRobuxInExperienceShop = SharedFlags.FFlagHideHeaderForBuyRobuxInExperienceShop

local TopBar = require(InExperienceShop.Components.TopBar)
local ShopAbuseReportOverlay = if SharedFlags.FFlagEnableReportingFlowForExperienceShop then require(InExperienceShop.Components.ShopAbuseReportOverlay) else nil
local SearchInputContainer = require(InExperienceShop.Components.SearchInput.SearchInputContainer)
local OfferDetailsDialog = require(InExperienceShop.Components.OfferDialogs.OfferDetailsDialog)
local OfferTermsDialog = require(InExperienceShop.Components.OfferDialogs.OfferTermsDialog)

local TrialRedemptionErrorDialogContainer = require(InExperienceShop.Components.TrialRedemptionErrorDialog.TrialRedemptionErrorDialogContainer)
local ShopHomePageContainer = require(InExperienceShop.Components.ShopHomePage.ShopHomePageContainer)
local CategoryPageContainer = require(InExperienceShop.Components.CategoryPage.CategoryPageContainer)
local SearchResultsContainer = require(InExperienceShop.Components.SearchResultsPage.SearchResultsContainer)
local ItemDetailsContainer = require(InExperienceShop.Components.ItemDetails.ItemDetailsContainer)
local CreatorEarlyAccessBanner = require(InExperienceShop.Components.CreatorEarlyAccessBanner)
local DesktopOfferBanner = require(InExperienceShop.Components.DesktopOfferBanner)
local _Types = require(InExperienceShop.Types)
local findSection = require(InExperienceShop.Utils.findSection)
local OfferDialogState = require(InExperienceShop.Components.OfferDialogs.OfferDialogState)
local _useShopOfferChip = require(InExperienceShop.Hooks.useShopOfferChip)

local FFlagEnableCreatorEarlyAccessBannerInShop = require(InExperienceShop.Flags.FFlagEnableCreatorEarlyAccessBannerInShop)
local FFlagRemoveBottomPaddingInExperienceShop = require(InExperienceShop.Flags.FFlagRemoveBottomPaddingInExperienceShop)
local FFlagShopBlockClickPassThrough = require(InExperienceShop.Flags.FFlagShopBlockClickPassThrough)
local FFlagShowLargerOfferBannerOnDesktop2 = require(InExperienceShop.Flags.FFlagShowLargerOfferBannerOnDesktop2)
local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)
local _useShopReportOverflow = require(InExperienceShop.Hooks.useShopReportOverflow)

local function ShopView(tbl1)
    local isSearchOpen = tbl1.isSearchOpen
    local bool1 = not isSearchOpen and #tbl1.tabs > 0
    if FFlagHideHeaderForBuyRobuxInExperienceShop then
        bool1 = bool1 and not tbl1.hideTabs
    end
    local selectedItem = tbl1.selectedItem

    local bool2 = tbl1.selectedCategoryId == "home" or findSection(tbl1.sections, tbl1.selectedCategoryId) == nil

    local offerModal = tbl1.offer.offerModal
    local var1 = FFlagShowLargerOfferBannerOnDesktop2 and isSubjectToDesktopPolicies()
    local var2 = var1 and not isSearchOpen and bool2 and tbl1.offer.showOfferChip and offerModal ~= nil

    local createElement = React.createElement
    local var3 = View
    local tbl2 = { tag = "row align-y-center size-full-1200", LayoutOrder = 1 }

    local tbl3 = {
        Search = if isSearchOpen then React.createElement(SearchInputContainer, {
            text = tbl1.searchQuery,
            onTextChanged = tbl1.onSearchQueryChanged,
            onSearchSubmit = tbl1.onSearchSubmit,
            onBack = tbl1.onSearchCancel
        }) else nil,
        TopBar = 0
    }
    local element

    if isSearchOpen then
        element = nil
    else
        element = React.createElement(TopBar, {
            onClose = tbl1.onClose,
            onSearchOpen = tbl1.onSearchOpen,
            isReportingEnabled = tbl1.isReportingEnabled,
            isOverflowMenuOpen = tbl1.isOverflowMenuOpen,
            onOverflowActivated = tbl1.onOverflowActivated,
            onOverflowMenuClosed = tbl1.onOverflowMenuClosed,
            onMenuItemActivated = tbl1.onMenuItemActivated,
            showOfferChip = tbl1.offer.showOfferChip and not var1,
            offerChipText = tbl1.offer.offerChipText,
            offerChipIcon = tbl1.offer.offerChipIcon,
            onOfferChipActivated = tbl1.offer.onOfferChipActivated
        })
    end

    tbl3.TopBar = element
    local topRow = createElement(var3, tbl2, tbl3)
    local element3

    if var2 and offerModal ~= nil then
        element3 = React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-x-xlarge padding-top-medium", LayoutOrder = 4 },
            {
                Banner = React.createElement(DesktopOfferBanner, {
                    text = tbl1.offer.offerBodyText,
                    icon = tbl1.offer.offerChipIcon,
                    link = offerModal.termsAndConditions ~= nil
                        and {
                            text = tbl1.offer.offerViewTermsText,
                            onActivated = tbl1.offer.onOfferViewTerms
                        }
                        or nil,
                    testId = "DesktopOfferBanner"
                })
            }
        )
    else
        element3 = nil
    end

    local var4 = FFlagRemoveBottomPaddingInExperienceShop()
    local var5 = FFlagShopBlockClickPassThrough()
    local var6 = if var5 then useTokens() else nil
    local createElement2 = React.createElement
    local var7 = View
    local tbl4 = {
        tag = {
            ["data-testid=ShopView"] = true,
            ["size-full"] = true,
            ["padding-x-large padding-top-medium"] = tbl1.fullScreen and var4,
            ["padding-x-large padding-bottom-xlarge padding-top-medium"] = tbl1.fullScreen and not var4
        }
    }
    local tbl5 = {
        Content = 0,
        RobuxPurchaseSuccess = 0,
        ReportOverlay = 0,
        OfferDetails = 0,
        OfferTerms = 0,
        TrialRedemptionError = 0
    }
    local createElement3 = React.createElement
    local var8 = if var5 then "Frame" else View
    local var9 = var5
        and {
            Active = true,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = tbl1.overMediaColor,
            BackgroundTransparency = tbl1.overMediaTransparency,
            ClipsDescendants = true
        }
        or {
            tag = "size-full radius-medium clip",
            backgroundStyle = {
                Color3 = tbl1.overMediaColor,
                Transparency = tbl1.overMediaTransparency
            }
        }
    local tbl6 = {
        Corner = if var5 then React.createElement("UICorner", { CornerRadius = UDim.new(0, var6.Radius.Medium) }) else nil,
        ShopLayer = 0,
        Details = 0
    }

    local createElement4 = React.createElement
    local var10 = View
    local tbl7 = {
        tag = "col size-full",
        Visible = selectedItem == nil
    }
    local tbl8 = {
        TopRow = topRow,
        EarlyAccessBanner = if FFlagEnableCreatorEarlyAccessBannerInShop() and not isSearchOpen then React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-x-xlarge", LayoutOrder = 2 },
            {
                Banner = React.createElement(CreatorEarlyAccessBanner)
            }
        ) else nil,
        Categories = if bool1 then React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-x-xlarge", LayoutOrder = 3 },
            {
                Tabs = React.createElement(Tabs, {
                    activeTabId = tbl1.selectedCategoryId,
                    onActivated = tbl1.onCategorySelected,
                    fillBehavior = FillBehavior.Fit,
                    tabs = tbl1.tabs
                })
            }
        ) else nil,
        OfferBanner = element3,
        PageSlot = React.createElement(View, {
            tag = "col fill size-full-0 padding-top-medium",
            LayoutOrder = if FFlagShowLargerOfferBannerOnDesktop2 then 5 else 4,
            onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
        }, {
            Search = if isSearchOpen then React.createElement(SearchResultsContainer, {
                sections = tbl1.sections,
                committedQuery = tbl1.committedQuery,
                itemsPerRow = tbl1.itemsPerRow,
                onItemActivated = tbl1.onItemActivated
            }) else nil,
            Home = if isSearchOpen then nil else React.createElement(ShopHomePageContainer, {
                sections = tbl1.sections,
                itemsPerRow = tbl1.itemsPerRow,
                onCategoryActivated = tbl1.onCategorySelected,
                onItemActivated = tbl1.onItemActivated,
                Visible = bool2
            }),
            Category = if isSearchOpen or bool2 then nil else React.createElement(CategoryPageContainer, {
                sections = tbl1.sections,
                sectionId = tbl1.selectedCategoryId,
                itemsPerRow = tbl1.itemsPerRow,
                onItemActivated = tbl1.onItemActivated
            })
        })
    }
    tbl6.ShopLayer = createElement4(var10, tbl7, tbl8)

    tbl6.Details = if selectedItem == nil then nil else React.createElement(
        ItemDetailsContainer,
        {
            item = selectedItem,
            disableBuy = tbl1.selectedItemDisableBuy,
            onClose = tbl1.onDetailsClose
        }
    )
    tbl5.Content = createElement3(var8, var9, tbl6)

    tbl5.RobuxPurchaseSuccess = if FFlagShopRobuxPurchaseCompletionModal and tbl1.robuxPurchaseSuccess ~= nil then React.createElement(
        UnifiedPurchaseCompletionModal,
        {
            bodyText = tbl1.robuxPurchaseSuccess.bodyText,
            buttons = {
                onActivated = tbl1.robuxPurchaseSuccess.onClose,
                onClose = tbl1.robuxPurchaseSuccess.onClose
            }
        }
    ) else nil

    tbl5.ReportOverlay = if tbl1.topBarReportSession and ShopAbuseReportOverlay then React.createElement(
        ShopAbuseReportOverlay,
        {
            abuseVector = tbl1.topBarReportSession.abuseVector,
            targetId = tbl1.topBarReportSession.targetId,
            onClose = tbl1.onTopBarReportClose
        }
    ) else nil
    local element4

    if tbl1.offer.offerDialog == OfferDialogState.Details and tbl1.offer.offerModal ~= nil then
        element4 = React.createElement(OfferDetailsDialog, {
            modal = tbl1.offer.offerModal,
            expirationTimeInUTC = tbl1.offer.offerExpirationTimeInUTC,
            onShopNow = tbl1.offer.onOfferShopNow,
            onViewTerms = tbl1.offer.onOfferViewTerms,
            onClose = tbl1.offer.onOfferDetailsClose
        })
    else
        element4 = nil
    end

    tbl5.OfferDetails = element4
    local element5

    if tbl1.offer.offerDialog == OfferDialogState.Terms
        and tbl1.offer.offerModal ~= nil
        and tbl1.offer.offerModal.termsAndConditions ~= nil
    then
        element5 = React.createElement(
            OfferTermsDialog,
            {
                terms = tbl1.offer.offerModal.termsAndConditions,
                onClose = tbl1.offer.onOfferTermsClose
            }
        )
    else
        element5 = nil
    end

    tbl5.OfferTerms = element5

    tbl5.TrialRedemptionError = if FFlagLuaAppEnableGamePassFreeTrials then React.createElement(TrialRedemptionErrorDialogContainer) else nil
    return createElement2(var7, tbl4, tbl5)
end

return ShopView

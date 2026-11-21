-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local SignalsReact = require(AvatarExperienceCatalogParent.SignalsReact)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local useNetworking = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Hooks.useNetworking
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local sendUnifiedEventLog = AvatarExperienceAnalytics.sendUnifiedEventLog
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingElementNameEnums = AvatarExperienceAnalytics.Enums.UnifiedLoggingElementNameEnums
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface

local _MarketplaceOffersBannerTypes = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.MarketplaceOffersBannerTypes)
local marketplaceOffersBannerDisplay = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.marketplaceOffersBannerDisplay)
local useAXCatalogStoreContext = require(AvatarExperienceCatalog.Context.useAXCatalogStoreContext)
local _createCatalogOffersBannerStore = require(AvatarExperienceCatalog.Stores.createCatalogOffersBannerStore)
local catalogOffersBannerImpressionsStore = require(AvatarExperienceCatalog.Stores.catalogOffersBannerImpressionsStore)
local useCatalogOffersBannerDismissHydration = require(AvatarExperienceCatalog.Hooks.useCatalogOffersBannerDismissHydration)
local useCatalogOffersBannerOffersFetch = require(AvatarExperienceCatalog.Hooks.useCatalogOffersBannerOffersFetch)
local catalogOffersBannerAppStorage = require(AvatarExperienceCatalog.Utils.catalogOffersBannerAppStorage)

local _CatalogOffersBannerView = require(script.Parent.CatalogOffersBannerView)
local CatalogOffersBannerOfferModals = require(script.Parent.CatalogOffersBannerOfferModals)

local getMarketplaceOffersBannerOfferDisplayId = marketplaceOffersBannerDisplay.getMarketplaceOffersBannerOfferDisplayId
local getMarketplaceOffersBannerOfferDisplayTitle = marketplaceOffersBannerDisplay.getMarketplaceOffersBannerOfferDisplayTitle

local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXCatalogOffersAutoOpenFTUXSheet = AvatarExperienceFlags.FFlagAXCatalogOffersAutoOpenFTUXSheet
local FFlagAXUpdateOffersEndsUIWithBadge = AvatarExperienceFlags.FFlagAXUpdateOffersEndsUIWithBadge

local function blendShiftFillForOpaqueGuiObject(shift200, color3: Color3): Color3
    local num1 = 1 - math.clamp(shift200.Transparency, 0, 1)
    return Color3.new(
        shift200.Color3.R * num1 + color3.R * (1 - num1),
        shift200.Color3.G * num1 + color3.G * (1 - num1),
        shift200.Color3.B * num1 + color3.B * (1 - num1)
    )
end

local function useCatalogOffersBannerViewModel(tbl1)
    local catalogOffersBannerStore = useAXCatalogStoreContext().catalogOffersBannerStore

    local var1 = useNetworking()
    local var2 = useTokens()

    local var3, var4 = React.useState(nil)

    local modal, var6 = React.useState(nil)
    local offersModalOpen, var8 = React.useState(false)
    local termsModalOpen, var10 = React.useState(false)

    local var11 = useLocalization({ okModalButton = "CommonUI.Controls.Action.OK" })

    local onCloseOffersModal = React.useCallback(function()
        var10(false)
        var8(false)
        var6(nil)
    end, {})

    local var13 = React.useCallback(function()
        if var3 and var3.modal then
            catalogOffersBannerAppStorage.writeSeenOfferSheetForCurrentOffer(getMarketplaceOffersBannerOfferDisplayId(var3))
            var6(var3.modal)
            var8(true)
        end
    end, { var3 })

    local onOpenTermsModal = React.useCallback(function()
        var10(true)
    end, {})

    local onCloseTermsModal = React.useCallback(function()
        var10(false)
    end, {})

    local var16 = useSignalState(catalogOffersBannerStore.getPayload)
    local var17 = useSignalState(catalogOffersBannerStore.getDismissed)

    React.useLayoutEffect(function()
        local var18 = if var16 == nil then nil else catalogOffersBannerAppStorage.resolveVisibleOffer(var16)
        var4(var18)
    end, { var16 })

    local marketplaceOffersBannerOfferDisplayId = if var3 then getMarketplaceOffersBannerOfferDisplayId(var3) else nil

    React.useEffect(function()
        if var3 == nil or var3.modal == nil or modal ~= nil then
            return
        end

        local marketplaceOffersBannerOfferDisplayId2 = getMarketplaceOffersBannerOfferDisplayId(var3)

        if FFlagAXCatalogOffersAutoOpenFTUXSheet
            and catalogOffersBannerAppStorage.shouldAutoOpenOfferSheetForCurrentOffer(marketplaceOffersBannerOfferDisplayId2)
        then
            catalogOffersBannerAppStorage.writeSeenOfferSheetForCurrentOffer(marketplaceOffersBannerOfferDisplayId2)
            var6(var3.modal)
            var8(true)
        end
    end, { modal, var3, marketplaceOffersBannerOfferDisplayId })

    useCatalogOffersBannerDismissHydration(catalogOffersBannerStore, var16)

    useCatalogOffersBannerOffersFetch(catalogOffersBannerStore, var1)
    local titleText = if var3 == nil then nil else getMarketplaceOffersBannerOfferDisplayTitle(var3)

    React.useEffect(function()
        local onBannerVisibleChanged = tbl1.onBannerVisibleChanged
        if onBannerVisibleChanged then
            onBannerVisibleChanged(not (titleText == nil) and not var17)
        end
    end, { var17, titleText, tbl1.onBannerVisibleChanged })

    React.useEffect(function()
        if var17
            or not var3
            or not titleText
            or not var3.offerId
            or catalogOffersBannerImpressionsStore.hasSeenOfferId(var3.offerId)
        then
            return
        end
        catalogOffersBannerImpressionsStore.addOfferId(var3.offerId)
        sendUnifiedEventLog({
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION,
            surface = UnifiedLoggingSurface.CATALOG,
            elementName = UnifiedLoggingElementNameEnums.CATALOG_OFFERS_BANNER,
            elementMetadata = HttpService:JSONEncode({ offerId = var3.offerId })
        })
    end, { var17, var3, titleText })

    if var17 or var16 == nil or var3 == nil or titleText == nil then
        return { status = "hidden" }
    end

    local offerModalTapAreaEnabled = var3.modal ~= nil
    local modals = if modal then React.createElement(CatalogOffersBannerOfferModals, {
        modal = modal,
        offersModalOpen = offersModalOpen,
        termsModalOpen = termsModalOpen,
        okButtonText = var11.okModalButton,
        onCloseOffersModal = onCloseOffersModal,
        onOpenTermsModal = onOpenTermsModal,
        onCloseTermsModal = onCloseTermsModal
    }) else nil

    local function onCloseActivated()
        catalogOffersBannerAppStorage.writeDismissedForCurrentOffer(getMarketplaceOffersBannerOfferDisplayId(var3))
        local var18 = catalogOffersBannerAppStorage.resolveVisibleOffer(var16)
        var4(var18)
        if var18 == nil then
            catalogOffersBannerStore.setDismissed(true)
        end
    end

    local var18 = FFlagAXUpdateOffersEndsUIWithBadge
        and {
            Color3 = blendShiftFillForOpaqueGuiObject(var2.Color.Shift.Shift_200, var2.Color.Surface.Surface_0.Color3),
            Transparency = 0
        }
        or nil

    local tbl2 = { status = "visible", viewProps = 0, modals = 0 }

    local viewProps = {
        rootTags = if FFlagAXUpdateOffersEndsUIWithBadge then "col auto-y size-full-0" else "col auto-y size-full-0 bg-shift-200",
        backgroundStyle = 0,
        Size = 0,
        Position = 0,
        iconName = 0,
        expirationTimeInUTC = 0,
        iconEmphasisStyle = 0,
        titleContentEmphasisStyle = 0,
        titleText = 0,
        onCloseActivated = 0,
        offerModalTapAreaEnabled = 0,
        onOfferBannerActivated = 0
    }

    if not FFlagAXUpdateOffersEndsUIWithBadge then
        var18 = nil
    end

    viewProps.backgroundStyle = var18
    viewProps.Size = tbl1.Size
    viewProps.Position = tbl1.Position
    viewProps.iconName = var3.icon
    viewProps.expirationTimeInUTC = if FFlagAXUpdateOffersEndsUIWithBadge then var3.expirationTimeInUTC else nil
    viewProps.iconEmphasisStyle = var2.Color.System.Emphasis
    viewProps.titleContentEmphasisStyle = var2.Color.Content.Emphasis
    viewProps.titleText = titleText
    viewProps.onCloseActivated = onCloseActivated
    viewProps.offerModalTapAreaEnabled = offerModalTapAreaEnabled
    if not offerModalTapAreaEnabled then
        var13 = nil
    end

    viewProps.onOfferBannerActivated = var13
    tbl2.viewProps = viewProps

    tbl2.modals = modals
    return tbl2
end

return useCatalogOffersBannerViewModel

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local React = require(AvatarExperienceCatalogParent.React)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState
local AvatarScreen = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).Enums.AvatarScreen
local SduiSharedUtilities = require(AvatarExperienceCatalogParent.SduiSharedUtilities)
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local _Foundation = require(AvatarExperienceCatalogParent.Foundation)
local fetchCatalogPage = require(script.Parent.fetchCatalogPage)
local useComponentBreakpointSize = require(script.Parent.Hooks.useComponentBreakpointSize)
local getCatalogConfigKey = require(script.Parent.Utils.getCatalogConfigKey)
local CatalogSduiPageContext = require(script.Parent.CatalogSduiPageContext)
local GetCatalogPageRequestIdStore = require(AvatarExperienceCatalog.Stores.GetCatalogPageRequestIdStore)

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXSduiFeedPublishesBreakpoint = AvatarExperienceFlags.FFlagAXSduiFeedPublishesBreakpoint
local FFlagAXMarketplaceBreakpointMismatchCounter = AvatarExperienceFlags.FFlagAXMarketplaceBreakpointMismatchCounter
local FFlagAXSduiFeedMaintainScrollOnSeeAll = AvatarExperienceFlags.FFlagAXSduiFeedMaintainScrollOnSeeAll
local FFlagAXSduiPageVariantRequestId = AvatarExperienceFlags.FFlagAXSduiPageVariantRequestId
local FFlagAXSduiPublishRequestIdWithResponse = AvatarExperienceFlags.FFlagAXSduiPublishRequestIdWithResponse
local FFlagAXScrollTelemetryIntegration2 = require(AvatarExperienceCatalogParent.SharedFlags).FFlagAXScrollTelemetryIntegration2

return React.forwardRef(function(tbl1, ref) -- name: CatalogSduiEntryPoint
    local screenSize, onAbsoluteSizeChange = useComponentBreakpointSize(
        nil,
        if FFlagAXSduiFeedPublishesBreakpoint or FFlagAXMarketplaceBreakpointMismatchCounter then tbl1.breakpointOptions else nil
    )

    local var3 = React.useMemo(function()
        return SduiLoadTimer.createLoadTimer(AvatarScreen.Catalog)
    end, {})

    if tbl1.loadTimer then
        var3 = tbl1.loadTimer
    end

    local appPage = if tbl1.appPage then tbl1.appPage else AvatarScreen.Catalog
    local catalogPageRequestIdStore = GetCatalogPageRequestIdStore(false)
    local var5 = useSignalState(catalogPageRequestIdStore.getPageRequestIdMap)[tbl1.identifier]

    local value = React.useMemo(function()
        return {
            identifier = tbl1.identifier,
            scrollPerformanceIntervalName = if FFlagAXScrollTelemetryIntegration2 then tbl1.scrollPerformanceIntervalName else nil,
            onScroll = tbl1.onScroll,
            requestImpressionsSignal = tbl1.requestImpressionsSignal,
            scrollPositionRef = if FFlagAXSduiFeedMaintainScrollOnSeeAll then tbl1.scrollPositionRef else nil,
            scrollRestoreRef = if FFlagAXSduiFeedMaintainScrollOnSeeAll then tbl1.scrollRestoreRef else nil
        }
    end, {
        tbl1.identifier,
        if FFlagAXScrollTelemetryIntegration2 then tbl1.scrollPerformanceIntervalName else nil,
        tbl1.onScroll,
        tbl1.requestImpressionsSignal,
        if FFlagAXSduiFeedMaintainScrollOnSeeAll then tbl1.scrollPositionRef else nil,
        if FFlagAXSduiFeedMaintainScrollOnSeeAll then tbl1.scrollRestoreRef else nil
    })

    React.useEffect(function()
        if FFlagAXSduiPublishRequestIdWithResponse then
            catalogPageRequestIdStore.activatePageVariant(tbl1.identifier, screenSize)
        end

        local requestId = if FFlagAXSduiPublishRequestIdWithResponse then catalogPageRequestIdStore.getPageVariantRequestIdToSend(tbl1.identifier, screenSize) elseif FFlagAXSduiPageVariantRequestId then catalogPageRequestIdStore.activatePageVariant(tbl1.identifier, screenSize) else catalogPageRequestIdStore.getOrCreatePageRequestId(tbl1.identifier)
        fetchCatalogPage({ requestId = requestId, context = tbl1.context, screenSize = screenSize }, var3)
    end, {
        var3,
        screenSize,
        tbl1.context,
        tbl1.identifier,
        var5,
        catalogPageRequestIdStore
    })

    local onRetry = React.useCallback(function()
        if FFlagAXSduiPageVariantRequestId then
            catalogPageRequestIdStore.resetPageVariantRequestId(tbl1.identifier, screenSize)
        else
            catalogPageRequestIdStore.resetPageRequestId(tbl1.identifier)
        end

        local requestId = if FFlagAXSduiPageVariantRequestId then catalogPageRequestIdStore.activatePageVariant(tbl1.identifier, screenSize) else catalogPageRequestIdStore.getOrCreatePageRequestId(tbl1.identifier)
        fetchCatalogPage(
            {
                requestId = requestId,
                context = tbl1.context,
                screenSize = screenSize
            },
            var3,
            { forceRefresh = true }
        )
    end, {
        var3,
        screenSize,
        tbl1.context,
        tbl1.identifier,
        catalogPageRequestIdStore
    })
    return React.createElement(
        CatalogSduiPageContext.Provider,
        { value = value },
        React.createElement(SduiFeatureEntryPoint, {
            configKey = getCatalogConfigKey(tbl1.context, screenSize),
            identifier = tbl1.identifier,
            appPage = appPage,
            loadTimer = var3,
            Size = tbl1.Size,
            AutomaticSize = tbl1.AutomaticSize,
            Position = tbl1.Position,
            onAbsoluteSizeChange = onAbsoluteSizeChange,
            onRetry = onRetry,
            shouldDisplayLoading = tbl1.shouldDisplayLoading,
            shouldDisplayError = tbl1.shouldDisplayError,
            loadingSlot = tbl1.loadingSlot,
            errorSlot = tbl1.errorSlot,
            ref = ref
        })
    )
end)

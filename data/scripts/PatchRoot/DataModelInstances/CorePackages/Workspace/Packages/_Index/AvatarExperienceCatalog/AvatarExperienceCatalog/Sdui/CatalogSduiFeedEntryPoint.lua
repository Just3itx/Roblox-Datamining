-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local React = require(AvatarExperienceCatalogParent.React)
local _Foundation = require(AvatarExperienceCatalogParent.Foundation)
local CatalogSduiEntryPoint = require(script.Parent.CatalogSduiEntryPoint)
local getCatalogPageIdentifier = require(script.Parent.Utils.getCatalogPageIdentifier)

local MarketplaceFeedSkeleton = require(AvatarExperienceCatalog.Components.MarketplaceFeedSkeleton.MarketplaceFeedSkeleton)
local CATALOG_RESULTS_HORIZONTAL_MARGIN = require(AvatarExperienceCatalog.Constants).CATALOG_RESULTS_HORIZONTAL_MARGIN

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXMarketplaceLoadingSkeleton = AvatarExperienceFlags.FFlagAXMarketplaceLoadingSkeleton
local FFlagAXSduiFeedPublishesBreakpoint = AvatarExperienceFlags.FFlagAXSduiFeedPublishesBreakpoint
local FFlagAXMarketplaceBreakpointMismatchCounter = AvatarExperienceFlags.FFlagAXMarketplaceBreakpointMismatchCounter
local FFlagAXSduiFeedMaintainScrollOnSeeAll = AvatarExperienceFlags.FFlagAXSduiFeedMaintainScrollOnSeeAll
local FFlagAXScrollTelemetryIntegration2 = require(AvatarExperienceCatalogParent.SharedFlags).FFlagAXScrollTelemetryIntegration2

return React.forwardRef(function(tbl1, ref) -- name: CatalogSduiFeedEntryPoint
    local loadingSlot = if FFlagAXMarketplaceLoadingSkeleton then React.createElement(MarketplaceFeedSkeleton) else nil
    local createElement = React.createElement
    local var1 = CatalogSduiEntryPoint
    local tbl2 = {
        context = tbl1.context,
        identifier = getCatalogPageIdentifier(tbl1.context),
        Size = tbl1.Size,
        AutomaticSize = tbl1.AutomaticSize,
        Position = tbl1.Position,
        loadingSlot = loadingSlot,
        onScroll = tbl1.onScroll,
        requestImpressionsSignal = tbl1.requestImpressionsSignal,
        breakpointOptions = if FFlagAXSduiFeedPublishesBreakpoint or FFlagAXMarketplaceBreakpointMismatchCounter then {
            horizontalInset = if FFlagAXSduiFeedPublishesBreakpoint then CATALOG_RESULTS_HORIZONTAL_MARGIN * 2 else nil,
            publishToStore = if FFlagAXSduiFeedPublishesBreakpoint then true else nil,
            measurementSource = if FFlagAXMarketplaceBreakpointMismatchCounter then "SduiFeed" else nil
        } else nil,
        scrollPositionRef = if FFlagAXSduiFeedMaintainScrollOnSeeAll then tbl1.scrollPositionRef else nil,
        scrollRestoreRef = if FFlagAXSduiFeedMaintainScrollOnSeeAll then tbl1.scrollRestoreRef else nil,
        scrollPerformanceIntervalName = if FFlagAXScrollTelemetryIntegration2 then tbl1.scrollPerformanceIntervalName else nil,
        ref = ref
    }
    return createElement(var1, tbl2)
end)

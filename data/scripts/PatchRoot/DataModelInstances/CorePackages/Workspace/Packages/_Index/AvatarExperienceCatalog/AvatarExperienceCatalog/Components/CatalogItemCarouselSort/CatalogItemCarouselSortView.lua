-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local useTokens = require(AvatarExperienceCatalogParent.Foundation).Hooks.useTokens
local AvatarExperienceUIKit = require(AvatarExperienceCatalogParent.AvatarExperienceUIKit)
local Impressions = require(AvatarExperienceCatalogParent.Impressions)
local useImpressionsTagger = Impressions.useImpressionsTagger
local ScreenSizeImpressionsDetector = Impressions.ScreenSizeImpressionsDetector
local _AppCommonLib = require(AvatarExperienceCatalogParent.AppCommonLib)
local ScrollingAppCarousel = require(AvatarExperienceCatalogParent.AppBlox).ScrollingAppCarousel

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXCatalogItemInformationPopover = AvatarExperienceFlags.FFlagAXCatalogItemInformationPopover
local FFlagAXCatalogUseFixedWidgetPadding = AvatarExperienceFlags.FFlagAXCatalogUseFixedWidgetPadding
local FFlagAXSduiSeeAllClickLogging = AvatarExperienceFlags.FFlagAXSduiSeeAllClickLogging
local FFlagAXSduiSortLegacyBottomPadding = AvatarExperienceFlags.FFlagAXSduiSortLegacyBottomPadding

local WidgetConstants = require(AvatarExperienceCatalog.WidgetConstants)
local resolveWidgetListItemBottomPaddingPx = require(AvatarExperienceCatalog.Utils.resolveWidgetListItemBottomPaddingPx)

local WidgetHeader = AvatarExperienceUIKit.WidgetComponents.WidgetHeader
local WidgetLayout = AvatarExperienceUIKit.WidgetComponents.WidgetLayout
local WidgetListItem = AvatarExperienceUIKit.WidgetComponents.WidgetListItem

return React.forwardRef(function(tbl1, ref) -- name: CatalogItemCarouselSortView
    useImpressionsTagger(tbl1.containerRef, WidgetConstants.WidgetExposureMetadata.TagName, tbl1.widgetRow)
    local var1 = useTokens()
    local bool1 = tbl1.headerText ~= nil and tbl1.headerText ~= ""
        or tbl1.headerDescription ~= nil and tbl1.headerDescription ~= ""
        or tbl1.seeAllCallback ~= nil

    local items = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, tbl1.itemGap),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        })
    }
    for _, visibleItem in tbl1.visibleItems do
        local str1 = `item-{visibleItem.absoluteIndex}`
        items[str1] = tbl1.renderTile(
            {
                id = visibleItem.id,
                type = visibleItem.type,
                gridInformation = visibleItem.gridInformation
            },
            visibleItem.absoluteIndex
        )
    end
    local createElement = React.createElement
    local var2 = WidgetListItem
    local tbl3 = {
        ref = ref,
        padding = {
            bottom = UDim.new(
                0,
                if FFlagAXSduiSortLegacyBottomPadding then var1.Size.Size_600 elseif FFlagAXCatalogUseFixedWidgetPadding then var1.Size.Size_800 else resolveWidgetListItemBottomPaddingPx(var1)
            )
        },
        horizontalMargin = tbl1.horizontalMargin
    }
    local tbl4 = { Widget = 0 }
    local createElement2 = React.createElement
    local var3 = WidgetLayout
    local tbl5 = { headerSlot = 0, contentSlot = 0 }
    local element

    if bool1 then
        element = React.createElement(WidgetHeader, {
            titleText = tbl1.headerText,
            descriptionText = tbl1.headerDescription,
            informationPopoverText = if FFlagAXCatalogItemInformationPopover then tbl1.informationPopoverText else nil,
            onInformationIconActivated = if FFlagAXCatalogItemInformationPopover then tbl1.onInformationIconActivated else nil,
            seeAllCallback = tbl1.seeAllCallback,
            seeAllRef = if FFlagAXSduiSeeAllClickLogging then tbl1.seeAllRef else nil,
            LayoutOrder = 1
        })
    else
        element = nil
    end

    tbl5.headerSlot = element

    local createElement3 = React.createElement
    local fragment = React.Fragment

    local tbl6 = {
        ["Widget_" .. tbl1.widgetId] = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ref = tbl1.containerRef,
                [React.Tag] = "data-testid=CatalogItemCarouselSortView"
            },
            React.createElement(ScrollingAppCarousel, {
                items = items,
                index = math.max(1, math.min(tbl1.carouselIndex, math.max(1, tbl1.carouselItemCount))),
                styleProps = tbl1.carouselArrowStyleProps,
                itemCount = tbl1.carouselItemCount,
                itemWidth = math.max(1, tbl1.itemWidth),
                itemPadding = tbl1.itemGap,
                carouselMargin = tbl1.carouselMargin,
                carouselHeight = 0,
                canvasWidth = math.max(1, tbl1.canvasWidth),
                onChangeCanvasPosition = tbl1.onScrollChanged,
                onRefCallback = tbl1.onScrollChanged,
                shouldExpandToFitContentHeight = true
            })
        ),
        ImpressionsDetector = React.createElement(ScreenSizeImpressionsDetector, {
            onRequestImpressionsSignal = tbl1.onItemsUpdatedSignal,
            onImpressionsDetected = tbl1.onImpressionsDetected,
            filterImpressionFunc = tbl1.filterImpressionFunc,
            impressionsTag = tbl1.impressionsKey
        })
    }
    tbl5.contentSlot = createElement3(fragment, nil, tbl6)
    tbl4.Widget = createElement2(var3, tbl5)
    return createElement(var2, tbl3, tbl4)
end)

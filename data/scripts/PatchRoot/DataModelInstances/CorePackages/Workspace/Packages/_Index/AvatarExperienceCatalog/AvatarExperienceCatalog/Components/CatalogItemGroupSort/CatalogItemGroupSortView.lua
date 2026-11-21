-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:43Z
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
local Grid = AvatarExperienceUIKit.GridComponents.Grid

return React.forwardRef(function(tbl1, ref) -- name: CatalogItemGroupSortView
    useImpressionsTagger(tbl1.containerRef, WidgetConstants.WidgetExposureMetadata.TagName, tbl1.widgetRow)
    local var1 = useTokens()
    local bool1 = tbl1.headerText ~= nil and tbl1.headerText ~= ""
        or tbl1.headerDescription ~= nil and tbl1.headerDescription ~= ""
        or tbl1.seeAllCallback ~= nil

    local function renderItem(arg1)
        local item = arg1.item
        return tbl1.renderTile({ id = item.id, type = item.type, gridInformation = arg1.gridInformation }, arg1.index)
    end

    local function getItemId(arg1): string
        return tostring(arg1.id) .. "_" .. tostring(tbl1.itemsPerRow)
    end

    local createElement = React.createElement
    local var2 = WidgetListItem
    local tbl2 = {
        ref = ref,
        padding = {
            bottom = UDim.new(
                0,
                if FFlagAXSduiSortLegacyBottomPadding then var1.Size.Size_600 elseif FFlagAXCatalogUseFixedWidgetPadding then var1.Size.Size_800 else resolveWidgetListItemBottomPaddingPx(var1)
            )
        },
        horizontalMargin = tbl1.horizontalMargin
    }
    local tbl3 = { Widget = 0 }
    local createElement2 = React.createElement
    local var3 = WidgetLayout
    local tbl4 = { headerSlot = 0, contentSlot = 0 }
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

    tbl4.headerSlot = element

    local createElement3 = React.createElement
    local fragment = React.Fragment

    local tbl5 = {
        ["Widget_" .. tbl1.widgetId] = React.createElement(Grid, {
            itemsPerRow = tbl1.itemsPerRow,
            renderItem = renderItem,
            getItemId = getItemId,
            items = tbl1.gridItems,
            gapVertical = tbl1.itemGap,
            gapHorizontal = tbl1.itemGap,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ref = tbl1.containerRef,
            [React.Tag] = "data-testid=CatalogItemGroupSortView"
        }),
        ImpressionsDetector = React.createElement(ScreenSizeImpressionsDetector, {
            onRequestImpressionsSignal = tbl1.onItemsUpdatedSignal,
            onImpressionsDetected = tbl1.onImpressionsDetected,
            filterImpressionFunc = tbl1.filterImpressionFunc,
            impressionsTag = tbl1.impressionsKey
        })
    }
    tbl4.contentSlot = createElement3(fragment, nil, tbl5)
    tbl3.Widget = createElement2(var3, tbl4)
    return createElement(var2, tbl2, tbl3)
end)

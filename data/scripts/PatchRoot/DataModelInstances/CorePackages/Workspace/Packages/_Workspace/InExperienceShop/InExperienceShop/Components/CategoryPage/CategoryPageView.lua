-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)

local View = Foundation.View
local ScrollView = Foundation.ScrollView

local ItemGrid = require(InExperienceShop.Components.ItemGrid)
local _ItemRow = require(InExperienceShop.Components.ItemRow)
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local RobuxTermsDisclosure = if require(InExperienceShop.Flags.FFlagShopRobuxTermsDisclosure) then require(InExperienceShop.Components.RobuxTermsDisclosure) else nil
local isSubjectToDesktopPolicies = require(InExperienceShopParent.SharedFlags).isSubjectToDesktopPolicies
local Analytics = if FFlagEnableInExperienceShopUnifiedLogging then require(InExperienceShop.Analytics) else nil
local ShopPageType = if Analytics then Analytics.Constants.ShopPageType else nil
local useShopImpressionsDetector = require(InExperienceShop.Hooks.useShopImpressionsDetector)

local _Types = require(InExperienceShop.Types)

local function CategoryPageView(tbl1)
    local bool1 = tbl1.showRobuxTermsDisclosure == true
    local isMobile = not isSubjectToDesktopPolicies()

    local var1 = useShopImpressionsDetector(
        {
            pageType = if ShopPageType then ShopPageType.Category else "",
            isPageActive = true,
            externalScrollSignal = nil
        }
    )

    local var2 = React.useCallback(function(_)
        if FFlagEnableInExperienceShopUnifiedLogging then
            var1.onLayoutChange()
        end
    end, { var1.onLayoutChange })

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "fill size-full-0",
        testId = "CategoryPageView",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Scroll = 0, ImpressionsDetector = 0 }
    local createElement2 = React.createElement
    local var4 = ScrollView
    local tbl4 = {
        Size = UDim2.fromScale(1, 1),
        onCanvasPositionChanged = 0,
        scroll = 0
    }

    if not FFlagEnableInExperienceShopUnifiedLogging then
        var2 = nil
    end

    tbl4.onCanvasPositionChanged = var2

    tbl4.scroll = {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.fromScale(1, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        scrollBarVisibility = Foundation.Enums.Visibility.None
    }
    local tbl5 = { Content = 0 }

    local createElement3 = React.createElement
    local var5 = View

    local tbl6 = {
        tag = if bool1 then "col gap-medium size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge" else "size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge padding-top-medium",
        ref = if FFlagEnableInExperienceShopUnifiedLogging then var1.gridRef else nil,
        onAbsoluteSizeChanged = FFlagEnableInExperienceShopUnifiedLogging and function(_)
            var1.onLayoutChange()
        end or nil
    }

    local tbl7 = {
        Disclosure = if bool1 and RobuxTermsDisclosure then React.createElement(RobuxTermsDisclosure, { isMobile = isMobile, LayoutOrder = 1 }) else nil,
        Grid = React.createElement(ItemGrid, {
            LayoutOrder = if bool1 then 2 else nil,
            items = tbl1.items,
            itemsPerRow = tbl1.itemsPerRow,
            sectionId = tbl1.sectionId,
            onItemActivated = tbl1.onItemActivated,
            renderTile = tbl1.renderTile,
            isFeaturedDoubleWidthRobux = tbl1.isFeaturedDoubleWidthRobux,
            gap = "gap-large",
            onGridLayoutChange = if FFlagEnableInExperienceShopUnifiedLogging then var1.onLayoutChange else nil
        })
    }
    tbl5.Content = createElement3(var5, tbl6, tbl7)
    tbl3.Scroll = createElement2(var4, tbl4, tbl5)

    tbl3.ImpressionsDetector = if FFlagEnableInExperienceShopUnifiedLogging then var1.impressionsDetector else nil
    return createElement(var3, tbl2, tbl3)
end

return CategoryPageView

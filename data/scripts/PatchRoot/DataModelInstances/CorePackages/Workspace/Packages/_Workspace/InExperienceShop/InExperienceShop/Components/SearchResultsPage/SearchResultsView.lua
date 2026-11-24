-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local ScrollView = Foundation.ScrollView

local ItemRow = require(InExperienceShop.Components.ItemRow)
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagPassShopPurchaseSurfaceToBuyModal = require(InExperienceShopParent.SharedFlags).FFlagPassShopPurchaseSurfaceToBuyModal
local Analytics = if FFlagEnableInExperienceShopUnifiedLogging then require(InExperienceShop.Analytics) else nil
local ShopPageType = if Analytics then Analytics.Constants.ShopPageType else nil
local ShopPageType2 = if FFlagPassShopPurchaseSurfaceToBuyModal then require(InExperienceShop.Analytics.Constants).ShopPageType else nil
local useShopImpressionsDetector = require(InExperienceShop.Hooks.useShopImpressionsDetector)

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)

local str1 = string.format("Type at least %d characters to search", Constants.SEARCH_MIN_LENGTH)

local tbl1 = { emptyText = "CommonUI.Messages.Response.NoResults" }

local function SearchResultsView(tbl2)
    local var1 = useLocalization(tbl1)

    local var2 = useShopImpressionsDetector(
        {
            pageType = if ShopPageType then ShopPageType.Search else "",
            isPageActive = true,
            externalScrollSignal = nil
        }
    )

    local var3 = React.useCallback(function(_)
        if FFlagEnableInExperienceShopUnifiedLogging then
            var2.onLayoutChange()
        end
    end, { var2.onLayoutChange })

    local var4 = React.useMemo(function()
        if tbl2.state ~= "results" then
            return {}
        end
        local result = ({})
        for k, items in tbl2.rows do
            local var4 = "Row" .. k
            result[var4] = React.createElement(ItemRow, {
                items = items,
                columnCount = tbl2.columnCount,
                rowIndex = k,
                onItemActivated = tbl2.onItemActivated,
                shopPageType = if ShopPageType2 then ShopPageType2.Search else nil,
                LayoutOrder = k
            })
        end
        return result
    end, {
        tbl2.rows,
        tbl2.columnCount,
        tbl2.onItemActivated,
        tbl2.state
    })

    local var5 = if tbl2.state == "hint" then str1 elseif tbl2.state == "empty" then var1.emptyText else nil
    local createElement = React.createElement
    local var6 = View
    local tbl3 = {
        tag = "fill size-full-0",
        testId = "SearchResultsView",
        LayoutOrder = tbl2.LayoutOrder
    }
    local tbl4 = { Scroll = 0, ImpressionsDetector = 0, Message = 0 }
    local var7

    if var5 == nil then
        local createElement2 = React.createElement
        local var8 = ScrollView
        local tbl5 = {
            Size = UDim2.fromScale(1, 1),
            onCanvasPositionChanged = 0,
            scroll = 0
        }

        if not FFlagEnableInExperienceShopUnifiedLogging then
            var3 = nil
        end

        tbl5.onCanvasPositionChanged = var3

        tbl5.scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(1, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = Foundation.Enums.Visibility.None
        }
        local tbl6 = { Content = 0 }
        local createElement3 = React.createElement
        local var9 = View

        local tbl7 = {
            tag = "col gap-medium size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge padding-top-medium",
            ref = if FFlagEnableInExperienceShopUnifiedLogging then var2.gridRef else nil,
            onAbsoluteSizeChanged = FFlagEnableInExperienceShopUnifiedLogging and function(_)
                var2.onLayoutChange()
            end or nil
        }

        tbl6.Content = createElement3(var9, tbl7, var4)
        var7 = createElement2(var8, tbl5, tbl6)
    else
        var7 = nil
    end

    tbl4.Scroll = var7

    tbl4.ImpressionsDetector = if FFlagEnableInExperienceShopUnifiedLogging then var2.impressionsDetector else nil

    tbl4.Message = if var5 == nil then nil else React.createElement(View, {
        tag = "col align-x-center align-y-center size-full padding-x-xlarge padding-y-xlarge",
        testId = "SearchResultsMessage"
    }, {
        Label = React.createElement(
            FoundationText,
            { tag = "auto-xy text-body-medium text-align-x-center content-default", Text = var5 }
        )
    })
    return createElement(var6, tbl3, tbl4)
end

return SearchResultsView

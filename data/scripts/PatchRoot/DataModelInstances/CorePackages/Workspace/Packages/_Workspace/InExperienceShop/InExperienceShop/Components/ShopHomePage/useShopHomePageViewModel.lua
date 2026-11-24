-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Signal = require(InExperienceShopParent.AppCommonLib).Signal

local CategorySection = require(InExperienceShop.Components.CategorySection)
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagEnableCategoryLoggingInShop = require(InExperienceShop.Flags.FFlagEnableCategoryLoggingInShop)
local FFlagEnableShopRobuxBuyTelemetry = require(InExperienceShop.Flags.FFlagEnableShopRobuxBuyTelemetry)
local _Types = require(InExperienceShop.Types)

local _ShopHomePageView = require(script.Parent.ShopHomePageView)

local function useShopHomePageViewModel(tbl1)
    local itemsPerRow = tbl1.itemsPerRow
    local var1 = React.useMemo(function()
        if not FFlagEnableInExperienceShopUnifiedLogging then
            return nil
        end
        return Signal.new()
    end, {})

    local var2 = React.useCallback(function(_)
        if FFlagEnableInExperienceShopUnifiedLogging and var1 then
            var1:fire()
        end
    end, { var1 })

    local renderItem = React.useCallback(function(arg1)
        local item = arg1.item
        return React.createElement(CategorySection, {
            sectionId = item.id,
            categoryType = if FFlagEnableCategoryLoggingInShop or FFlagEnableShopRobuxBuyTelemetry then item.categoryType else nil,
            stableCategoryId = if FFlagEnableCategoryLoggingInShop then item.stableCategoryId else nil,
            categoryGroup = if FFlagEnableCategoryLoggingInShop then item.categoryGroup else nil,
            categoryName = if FFlagEnableCategoryLoggingInShop then item.name else nil,
            title = item.name,
            items = item.items,
            robuxPackages = item.robuxPackages,
            featuredRobuxPackage = item.featuredRobuxPackage,
            paymentSessionId = item.paymentSessionId,
            bonusJwt = item.bonusJwt,
            itemsPerRow = itemsPerRow,
            onCategoryActivated = tbl1.onCategoryActivated,
            onItemActivated = tbl1.onItemActivated,
            isPageVisible = tbl1.Visible ~= false,
            scrollImpressionsSignal = if FFlagEnableInExperienceShopUnifiedLogging then var1 else nil,
            LayoutOrder = arg1.index
        })
    end, {
        itemsPerRow,
        tbl1.onCategoryActivated,
        tbl1.onItemActivated,
        tbl1.Visible,
        var1
    })

    local keyExtractor = React.useCallback(function(arg1)
        return arg1.id
    end, {})

    local tbl2 = {
        data = tbl1.sections,
        renderItem = renderItem,
        keyExtractor = keyExtractor,
        LayoutOrder = tbl1.LayoutOrder,
        Visible = tbl1.Visible,
        onScroll = 0
    }

    if not FFlagEnableInExperienceShopUnifiedLogging then
        var2 = nil
    end

    tbl2.onScroll = var2
    return tbl2
end

return useShopHomePageViewModel

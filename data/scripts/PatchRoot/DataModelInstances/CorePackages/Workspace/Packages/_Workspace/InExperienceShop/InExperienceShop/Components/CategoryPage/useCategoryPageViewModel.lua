-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local View = require(InExperienceShopParent.Foundation).View
local ShopItemTile = require(InExperienceShop.Components.ShopItemTile)
local RobuxPackageTileContainer = require(InExperienceShop.Components.RobuxPackageTileContainer)
local _ItemRow = require(InExperienceShop.Components.ItemRow)
local computeRobuxPackageMediaHeightScale = require(InExperienceShop.Components.computeShopRowTileWidths).computeRobuxPackageMediaHeightScale
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagEnableCategoryLoggingInShop = require(InExperienceShop.Flags.FFlagEnableCategoryLoggingInShop)
local FFlagEnableShopRobuxBuyTelemetry = require(InExperienceShop.Flags.FFlagEnableShopRobuxBuyTelemetry)
local FFlagShopRobuxTermsDisclosure = require(InExperienceShop.Flags.FFlagShopRobuxTermsDisclosure)
local Constants = require(InExperienceShop.Analytics.Constants)

local FFlagPassShopPurchaseSurfaceToBuyModal = require(InExperienceShopParent.SharedFlags).FFlagPassShopPurchaseSurfaceToBuyModal

local _Types = require(InExperienceShop.Types)
local findSection = require(InExperienceShop.Utils.findSection)
local ShopPageType = if FFlagPassShopPurchaseSurfaceToBuyModal then Constants.ShopPageType else nil
local ShopPageType2 = if FFlagEnableInExperienceShopUnifiedLogging then Constants.ShopPageType else nil
local _CategoryPageView = require(script.Parent.CategoryPageView)

local tbl1 = {}

local function shopItemTileFlexItem(growRatio: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        FlexMode = Enum.UIFlexMode.Custom,
        GrowRatio = growRatio,
        ShrinkRatio = 1,
        ItemLineAlignment = Enum.ItemLineAlignment.Stretch
    }
end

local function explicitWidthFlexItem() -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        FlexMode = Enum.UIFlexMode.None,
        GrowRatio = 0,
        ShrinkRatio = 0,
        ItemLineAlignment = Enum.ItemLineAlignment.Stretch
    }
end

local function resolveTileWidth(arg1, layoutOrder: number, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg2 == nil or arg2.rowWidth <= 0 then
        return nil
    end

    if arg2.isFeaturedDoubleWidthRobux(arg1, layoutOrder) and arg2.featuredRobuxWidth ~= nil then
        return arg2.featuredRobuxWidth
    end

    return arg2.shopWidth
end

local function resolveRobuxMediaHeightScale(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil or arg1.shopWidth <= 0 then
        return nil
    end

    return computeRobuxPackageMediaHeightScale(arg1.shopWidth, arg1.gap)
end

local function tileWrapperProps(xOffset: number?, growRatio: number)
    if xOffset == nil or not (xOffset > 0) then
        return {
            tag = "size-full-0 auto-y",
            Size = UDim2.fromOffset(0, 0),
            flexItem = shopItemTileFlexItem(growRatio)
        }
    end

    return {
        tag = "size-full-0 auto-y",
        Size = UDim2.fromOffset(xOffset, 0),
        flexItem = explicitWidthFlexItem()
    }
end

local function shopItemFromRobuxPackage(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        id = arg1.id,
        name = tostring(arg1.robuxAmount),
        thumbnail = arg1.robuxImage
    }
end

local function getTileLoggingProps(gridPositionColumn: number, arg1, categoryId: string, categoryType: string?, stableCategoryId: string?, categoryGroup: string?, categoryName: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        categoryId = categoryId,
        categoryType = categoryType,
        stableCategoryId = stableCategoryId,
        categoryGroup = categoryGroup,
        categoryName = categoryName,
        gridPositionRow = if arg1 then arg1.gridPositionRow else nil,
        gridPositionColumn = gridPositionColumn
    }
end

local function useCategoryPageViewModel(tbl2)
    local var1 = React.useMemo(function()
        return findSection(tbl2.sections, tbl2.sectionId)
    end, { tbl2.sections, tbl2.sectionId })

    local var2 = if var1 ~= nil then var1.items else tbl1
    local categoryType = if FFlagEnableCategoryLoggingInShop and var1 ~= nil then var1.categoryType else nil
    local stableCategoryId = if FFlagEnableCategoryLoggingInShop and var1 ~= nil then var1.stableCategoryId else nil
    local categoryGroup = if FFlagEnableCategoryLoggingInShop and var1 ~= nil then var1.categoryGroup else nil
    local name = if FFlagEnableCategoryLoggingInShop and var1 ~= nil then var1.name else nil
    local robuxPackages = if var1 == nil then nil else var1.robuxPackages
    local featuredRobuxPackage = if var1 == nil then nil else var1.featuredRobuxPackage
    local paymentSessionId = if var1 == nil then nil else var1.paymentSessionId
    local bonusJwt = if var1 == nil then nil else var1.bonusJwt
    local categoryType2 = if FFlagEnableShopRobuxBuyTelemetry and var1 ~= nil then var1.categoryType else nil
    local bool1 = not (robuxPackages == nil) and #robuxPackages > 0
    local bool2 = featuredRobuxPackage ~= nil

    local onItemActivated = tbl2.onItemActivated

    local items = React.useMemo(function()
        if bool1 then
            local var3 = robuxPackages
            local var4 = table.create(#var3)
            for i = 1, #var3 do
                local tbl3 = shopItemFromRobuxPackage(var3[i])

                var4[i] = tbl3
            end
            return var4
        end

        if featuredRobuxPackage == nil then
            return var2
        end

        local var3 = table.create(#var2 + 1)
        var3[1] = shopItemFromRobuxPackage(featuredRobuxPackage)
        for i = 1, #var2 do
            var3[i + 1] = var2[i]
        end
        return var3
    end, {
        var2,
        robuxPackages,
        featuredRobuxPackage,
        bool1
    })
    local var4 = React.useMemo(function()
        if bool1 then
            local result = {}
            for _, value in robuxPackages do
                result[value.id] = value
            end
            return result
        end

        if featuredRobuxPackage == nil then
            return nil
        end

        local var4 = featuredRobuxPackage
        return {
            [var4.id] = var4
        }
    end, { robuxPackages, featuredRobuxPackage, bool1 })

    local var5 = React.useCallback(function(arg1, layoutOrder: number, arg2)
        local tileLoggingProps = getTileLoggingProps(layoutOrder, arg2, tbl2.sectionId, categoryType, stableCategoryId, categoryGroup, name)
        local pkg = if var4 == nil then nil else var4[arg1.id]

        if pkg == nil then
            local tbl3 = tileWrapperProps(resolveTileWidth(arg1, layoutOrder, arg2), 1)

            local createElement = React.createElement
            local var6 = View
            local tbl4 = {
                tag = tbl3.tag,
                Size = tbl3.Size,
                flexItem = tbl3.flexItem,
                LayoutOrder = layoutOrder
            }
            local tbl5 = {
                Tile = React.createElement(ShopItemTile, {
                    itemId = arg1.id,
                    itemType = arg1.itemType,
                    name = arg1.name,
                    thumbnail = arg1.thumbnail,
                    price = arg1.price,
                    userBasePriceInRobux = arg1.userBasePriceInRobux,
                    universeId = arg1.universeId,
                    categoryId = tileLoggingProps.categoryId,
                    categoryType = tileLoggingProps.categoryType,
                    stableCategoryId = tileLoggingProps.stableCategoryId,
                    categoryGroup = tileLoggingProps.categoryGroup,
                    categoryName = tileLoggingProps.categoryName,
                    gridPositionRow = tileLoggingProps.gridPositionRow,
                    gridPositionColumn = tileLoggingProps.gridPositionColumn,
                    onItemActivated = onItemActivated,
                    shopPageType = if ShopPageType then ShopPageType.Category else nil
                })
            }
            return createElement(var6, tbl4, tbl5)
        end

        local bool3 = bool1 or bool2 and layoutOrder == 1
        local tbl3 = tileWrapperProps(resolveTileWidth(arg1, layoutOrder, arg2), if bool3 then 2 else 1)

        local createElement = React.createElement
        local var6 = View
        local tbl4 = {
            tag = tbl3.tag,
            Size = tbl3.Size,
            flexItem = tbl3.flexItem,
            LayoutOrder = layoutOrder
        }
        local createElement2 = React.createElement
        local var7 = RobuxPackageTileContainer
        local tbl5 = {
            pkg = pkg,
            paymentSessionId = paymentSessionId,
            bonusJwt = bonusJwt,
            onBonusItemActivated = onItemActivated,
            mediaHeightScale = 0,
            categoryId = 0,
            categoryType = 0,
            stableCategoryId = 0,
            categoryGroup = 0,
            categoryName = 0,
            gridPositionRow = 0,
            gridPositionColumn = 0,
            shopPageType = 0
        }
        local mediaHeightScale = resolveRobuxMediaHeightScale(arg2)
        local tbl6 = { Tile = 0 }
        tbl5.mediaHeightScale = mediaHeightScale
        tbl5.categoryId = tileLoggingProps.categoryId
        tbl5.categoryType = if categoryType2 ~= nil then categoryType2 else tileLoggingProps.categoryType
        tbl5.stableCategoryId = tileLoggingProps.stableCategoryId
        tbl5.categoryGroup = tileLoggingProps.categoryGroup
        tbl5.categoryName = tileLoggingProps.categoryName
        tbl5.gridPositionRow = tileLoggingProps.gridPositionRow
        tbl5.gridPositionColumn = tileLoggingProps.gridPositionColumn
        tbl5.shopPageType = if ShopPageType2 then ShopPageType2.Category else nil
        tbl6.Tile = createElement2(var7, tbl5)
        return createElement(var6, tbl4, tbl6)
    end, {
        var4,
        onItemActivated,
        onItemActivated,
        bool1,
        bool2,
        paymentSessionId,
        bonusJwt,
        categoryType2,
        tbl2.sectionId,
        categoryType,
        stableCategoryId,
        categoryGroup,
        name
    })

    local isFeaturedDoubleWidthRobux = React.useMemo(function()
        if bool1 then
            return function(_, _: number): boolean
                return true
            end
        end

        if not bool2 then
            return nil
        end

        local id = featuredRobuxPackage.id
        return function(arg1, num1: number): boolean
            return num1 == 1 and arg1.id == id
        end
    end, { bool1, bool2, featuredRobuxPackage })

    local tbl3 = {
        items = items,
        itemsPerRow = tbl2.itemsPerRow,
        sectionId = tbl2.sectionId,
        onItemActivated = onItemActivated,
        renderTile = 0,
        isFeaturedDoubleWidthRobux = 0,
        showRobuxTermsDisclosure = 0,
        LayoutOrder = 0
    }

    if not FFlagEnableInExperienceShopUnifiedLogging and var4 == nil then
        var5 = nil
    end

    tbl3.renderTile = var5

    tbl3.isFeaturedDoubleWidthRobux = isFeaturedDoubleWidthRobux
    tbl3.showRobuxTermsDisclosure = FFlagShopRobuxTermsDisclosure and bool1
    tbl3.LayoutOrder = tbl2.LayoutOrder
    return tbl3
end

return useCategoryPageViewModel

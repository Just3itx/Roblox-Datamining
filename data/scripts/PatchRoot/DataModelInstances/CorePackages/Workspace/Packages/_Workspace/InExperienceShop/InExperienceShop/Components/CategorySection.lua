-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local View = require(InExperienceShopParent.Foundation).View
local SectionTitle = require(InExperienceShop.Components.SectionTitle)
local ItemGrid = require(InExperienceShop.Components.ItemGrid)
local ShopItemTile = require(InExperienceShop.Components.ShopItemTile)
local RobuxPackageTileContainer = require(InExperienceShop.Components.RobuxPackageTileContainer)
local _ItemRow = require(InExperienceShop.Components.ItemRow)
local Constants = require(InExperienceShop.Constants)
local computeRobuxPackageMediaHeightScale = require(InExperienceShop.Components.computeShopRowTileWidths).computeRobuxPackageMediaHeightScale
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagEnableCategoryLoggingInShop = require(InExperienceShop.Flags.FFlagEnableCategoryLoggingInShop)
local FFlagPassShopPurchaseSurfaceToBuyModal = require(InExperienceShopParent.SharedFlags).FFlagPassShopPurchaseSurfaceToBuyModal
local Analytics = if FFlagEnableInExperienceShopUnifiedLogging then require(InExperienceShop.Analytics) else nil
local ShopPageType = if Analytics then Analytics.Constants.ShopPageType else nil
local ShopPageType2 = if FFlagPassShopPurchaseSurfaceToBuyModal then require(InExperienceShop.Analytics.Constants).ShopPageType else nil
local useShopImpressionsDetector = require(InExperienceShop.Hooks.useShopImpressionsDetector)

local _Types = require(InExperienceShop.Types)

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

local function shopItemFromRobuxPackage(featuredRobuxPackage) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        id = featuredRobuxPackage.id,
        name = tostring(featuredRobuxPackage.robuxAmount),
        thumbnail = featuredRobuxPackage.robuxImage
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

return React.memo(function(tbl1) -- name: CategorySection
    local bool1 = not (tbl1.robuxPackages == nil) and #tbl1.robuxPackages > 0
    local featuredRobuxPackage = tbl1.featuredRobuxPackage
    local bool2 = featuredRobuxPackage ~= nil

    local onItemActivated = tbl1.onItemActivated

    local isPageActive = tbl1.isPageVisible ~= false

    local var1 = useShopImpressionsDetector({
        pageType = if ShopPageType then ShopPageType.Home else "",
        isPageActive = isPageActive,
        externalScrollSignal = tbl1.scrollImpressionsSignal
    })

    local items = React.useMemo(function()
        if bool1 then
            local robuxPackages = tbl1.robuxPackages

            local num1 = math.min(#robuxPackages, Constants.ITEMS_PER_SECTION, math.floor(tbl1.itemsPerRow / 2))
            local var2 = table.create(num1)
            for i = 1, num1 do
                local tbl2 = shopItemFromRobuxPackage(robuxPackages[i])

                var2[i] = tbl2
            end
            return var2
        end

        if tbl1.featuredRobuxPackage == nil then
            local num1 = math.min(#tbl1.items, Constants.ITEMS_PER_SECTION, tbl1.itemsPerRow)
            return table.move(tbl1.items, 1, num1, 1, {})
        end

        local num1 = math.min(#tbl1.items, Constants.ITEMS_PER_SECTION, math.max(tbl1.itemsPerRow - 2, 0))
        local var2 = table.create(num1 + 1)
        var2[1] = shopItemFromRobuxPackage(tbl1.featuredRobuxPackage)
        for i = 1, num1 do
            var2[i + 1] = tbl1.items[i]
        end
        return var2
    end, {
        tbl1.items,
        tbl1.robuxPackages,
        tbl1.featuredRobuxPackage,
        tbl1.itemsPerRow,
        bool1,
        bool2
    })

    local var3 = React.useMemo(function()
        if bool1 then
            local result = {}
            for _, value in tbl1.robuxPackages do
                result[value.id] = value
            end
            return result
        end

        if tbl1.featuredRobuxPackage == nil then
            return nil
        end

        local featuredRobuxPackage2 = tbl1.featuredRobuxPackage
        return {
            [featuredRobuxPackage2.id] = featuredRobuxPackage2
        }
    end, { tbl1.robuxPackages, tbl1.featuredRobuxPackage, bool1 })

    local var4 = React.useCallback(function(arg1, layoutOrder: number, arg2)
        local sectionId = tbl1.sectionId
        local categoryType = if FFlagEnableCategoryLoggingInShop then tbl1.categoryType else nil
        local stableCategoryId = if FFlagEnableCategoryLoggingInShop then tbl1.stableCategoryId else nil
        local categoryGroup = if FFlagEnableCategoryLoggingInShop then tbl1.categoryGroup else nil
        local categoryName = if FFlagEnableCategoryLoggingInShop then tbl1.categoryName else nil
        local tileLoggingProps = getTileLoggingProps(layoutOrder, arg2, sectionId, categoryType, stableCategoryId, categoryGroup, categoryName)
        local pkg = if var3 == nil then nil else var3[arg1.id]

        if pkg == nil then
            local tbl2 = tileWrapperProps(resolveTileWidth(arg1, layoutOrder, arg2), 1)

            local createElement = React.createElement
            local var5 = View
            local tbl3 = {
                tag = tbl2.tag,
                Size = tbl2.Size,
                flexItem = tbl2.flexItem,
                LayoutOrder = layoutOrder
            }
            local tbl4 = {
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
                    shopPageType = if ShopPageType2 then ShopPageType2.Home else nil
                })
            }
            return createElement(var5, tbl3, tbl4)
        end

        local bool4 = bool1 or bool2 and layoutOrder == 1
        local tbl2 = tileWrapperProps(resolveTileWidth(arg1, layoutOrder, arg2), if bool4 then 2 else 1)

        local createElement = React.createElement
        local var5 = View
        local tbl3 = {
            tag = tbl2.tag,
            Size = tbl2.Size,
            flexItem = tbl2.flexItem,
            LayoutOrder = layoutOrder
        }
        local createElement2 = React.createElement
        local var6 = RobuxPackageTileContainer
        local tbl4 = {
            pkg = pkg,
            paymentSessionId = tbl1.paymentSessionId,
            bonusJwt = tbl1.bonusJwt,
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
        local tbl5 = { Tile = 0 }
        tbl4.mediaHeightScale = mediaHeightScale
        tbl4.categoryId = tileLoggingProps.categoryId
        tbl4.categoryType = tbl1.categoryType
        tbl4.stableCategoryId = tileLoggingProps.stableCategoryId
        tbl4.categoryGroup = tileLoggingProps.categoryGroup
        tbl4.categoryName = tileLoggingProps.categoryName
        tbl4.gridPositionRow = tileLoggingProps.gridPositionRow
        tbl4.gridPositionColumn = tileLoggingProps.gridPositionColumn
        tbl4.shopPageType = if ShopPageType then ShopPageType.Home else nil
        tbl5.Tile = createElement2(var6, tbl4)
        return createElement(var5, tbl3, tbl5)
    end, {
        var3,
        onItemActivated,
        onItemActivated,
        bool1,
        bool2,
        tbl1.paymentSessionId,
        tbl1.bonusJwt,
        tbl1.sectionId,
        tbl1.categoryType,
        tbl1.stableCategoryId,
        tbl1.categoryGroup,
        tbl1.categoryName
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

    local var6 = React.useCallback(function()
        if tbl1.onCategoryActivated then
            tbl1.onCategoryActivated(tbl1.sectionId)
        end
    end, { tbl1.sectionId, tbl1.onCategoryActivated })

    local createElement = React.createElement
    local var7 = View
    local tbl2 = {
        tag = "col gap-medium size-full-0 auto-y padding-bottom-xlarge",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Title = 0, Grid = 0, ImpressionsDetector = 0 }
    local createElement2 = React.createElement
    local var8 = SectionTitle
    local tbl4 = {
        title = tbl1.title,
        onActivated = 0,
        LayoutOrder = 1
    }

    if not tbl1.onCategoryActivated then
        var6 = nil
    end

    tbl4.onActivated = var6
    tbl3.Title = createElement2(var8, tbl4)

    local createElement3 = React.createElement
    local var9 = ItemGrid
    local tbl5 = {
        items = items,
        itemsPerRow = tbl1.itemsPerRow,
        sectionId = tbl1.sectionId,
        onItemActivated = onItemActivated,
        renderTile = 0,
        isFeaturedDoubleWidthRobux = 0,
        gridRef = 0,
        onGridLayoutChange = 0,
        LayoutOrder = 2
    }

    if not FFlagEnableInExperienceShopUnifiedLogging and var3 == nil then
        var4 = nil
    end

    tbl5.renderTile = var4

    tbl5.isFeaturedDoubleWidthRobux = isFeaturedDoubleWidthRobux
    tbl5.gridRef = if FFlagEnableInExperienceShopUnifiedLogging then var1.gridRef else nil
    tbl5.onGridLayoutChange = if FFlagEnableInExperienceShopUnifiedLogging then var1.onLayoutChange else nil
    tbl3.Grid = createElement3(var9, tbl5)

    tbl3.ImpressionsDetector = if FFlagEnableInExperienceShopUnifiedLogging then var1.impressionsDetector else nil
    return createElement(var7, tbl2, tbl3)
end)

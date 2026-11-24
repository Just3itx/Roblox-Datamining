-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

local View = Foundation.View
local ShopItemTile = require(InExperienceShop.Components.ShopItemTile)
local computeShopRowTileWidths = require(InExperienceShop.Components.computeShopRowTileWidths)

local _Types = require(InExperienceShop.Types)

local computeShopRowTileWidths2 = computeShopRowTileWidths.computeShopRowTileWidths

local function defaultRenderTile(arg1, num1: number, _: number, tbl1, onItemActivated: ((...any) -> (...any))?, categoryId: string?, shopPageType: string?)
    local gridPositionRow = if tbl1 then tbl1.gridPositionRow else nil
    return React.createElement(ShopItemTile, {
        itemId = arg1.id,
        itemType = arg1.itemType,
        name = arg1.name,
        thumbnail = arg1.thumbnail,
        price = arg1.price,
        userBasePriceInRobux = arg1.userBasePriceInRobux,
        universeId = arg1.universeId,
        categoryId = categoryId,
        gridPositionRow = gridPositionRow,
        gridPositionColumn = num1,
        onItemActivated = onItemActivated,
        shopPageType = shopPageType,
        LayoutOrder = num1
    })
end

local function buildTileLayoutContext(items, columnCount: number, rowWidth: number, gap: number, gridPositionRow: number?, isFeaturedDoubleWidthRobux: (...any) -> (...any))
    local bool1 = false
    for k, item in items do
        if isFeaturedDoubleWidthRobux(item, k) then
            bool1 = true
            break
        end
    end

    local var1 = computeShopRowTileWidths2(rowWidth, gap, columnCount, bool1)

    return {
        rowWidth = rowWidth,
        gap = gap,
        shopWidth = var1.shopWidth,
        featuredRobuxWidth = var1.featuredRobuxWidth,
        gridPositionRow = gridPositionRow,
        isFeaturedDoubleWidthRobux = isFeaturedDoubleWidthRobux
    }
end

local function makeChildKey(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return "Item:" .. tostring(arg1.itemType) .. ":" .. arg1.id
end

return React.memo(function(tbl1) -- name: ItemRow
    local medium = useTokens().Gap.Medium
    local rowWidth, var1 = React.useState(0)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        if absoluteSizeX == 0 then
            return
        end
        var1(absoluteSizeX)
    end, {})

    local isFeaturedDoubleWidthRobux = tbl1.isFeaturedDoubleWidthRobux or function(_, _: number): boolean
        return false
    end

    local var3 = React.useMemo(function()
        return (buildTileLayoutContext(tbl1.items, tbl1.columnCount, rowWidth, medium, tbl1.rowIndex, isFeaturedDoubleWidthRobux))
    end, {
        tbl1.items,
        tbl1.columnCount,
        rowWidth,
        medium,
        tbl1.rowIndex,
        isFeaturedDoubleWidthRobux
    })

    local bool1 = not (tbl1.renderTile == nil) and rowWidth > 0
    local tbl2 = ({})

    for k, item in tbl1.items do
        local childKey = makeChildKey(item)

        if tbl1.renderTile then
            tbl2[childKey] = tbl1.renderTile(item, k, var3)
        else
            tbl2[childKey] = defaultRenderTile(item, k, tbl1.columnCount, var3, tbl1.onItemActivated, tbl1.sectionId, tbl1.shopPageType)
        end
    end

    if not bool1 then
        for layoutOrder = #tbl1.items + 1, tbl1.columnCount do
            tbl2["Filler" .. layoutOrder] = React.createElement(View, { tag = "size-full-0", LayoutOrder = layoutOrder })
        end
    end

    return React.createElement(View, {
        tag = "row flex-x-fill gap-medium size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, tbl2)
end)

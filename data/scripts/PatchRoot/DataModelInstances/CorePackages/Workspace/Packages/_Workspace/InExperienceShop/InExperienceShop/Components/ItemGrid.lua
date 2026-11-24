-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local View = require(InExperienceShopParent.Foundation).View
local ItemRow = require(InExperienceShop.Components.ItemRow)
local buildItemGridRows = require(InExperienceShop.Components.buildItemGridRows).buildItemGridRows

local _Types = require(InExperienceShop.Types)

local function ItemGrid(tbl1)
    local itemsPerRow = tbl1.itemsPerRow
    local gap = tbl1.gap or "gap-medium"

    local var1 = React.useMemo(function()
        return buildItemGridRows(tbl1.items, itemsPerRow, tbl1.isFeaturedDoubleWidthRobux)
    end, { tbl1.items, itemsPerRow, tbl1.isFeaturedDoubleWidthRobux })

    local var2 = React.useMemo(function()
        local result = ({})
        for value, items in var1 do
            local var2 = "Row" .. value
            result[var2] = React.createElement(ItemRow, {
                items = items,
                columnCount = itemsPerRow,
                sectionId = tbl1.sectionId,
                rowIndex = value,
                onItemActivated = tbl1.onItemActivated,
                renderTile = tbl1.renderTile,
                isFeaturedDoubleWidthRobux = tbl1.isFeaturedDoubleWidthRobux,
                LayoutOrder = value
            })
        end
        return result
    end, {
        var1,
        itemsPerRow,
        tbl1.sectionId,
        tbl1.onItemActivated,
        tbl1.renderTile,
        tbl1.isFeaturedDoubleWidthRobux
    })

    local var3 = React.useCallback(function()
        if tbl1.onGridLayoutChange then
            tbl1.onGridLayoutChange()
        end
    end, { tbl1.onGridLayoutChange })

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = `col size-full-0 auto-y {gap}`,
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.gridRef,
        onAbsoluteSizeChanged = 0
    }

    if tbl1.onGridLayoutChange == nil then
        var3 = nil
    end

    tbl2.onAbsoluteSizeChanged = var3
    return createElement(var4, tbl2, var2)
end

return ItemGrid

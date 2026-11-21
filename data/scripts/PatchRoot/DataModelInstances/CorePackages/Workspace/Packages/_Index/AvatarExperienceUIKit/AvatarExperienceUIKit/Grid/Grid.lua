-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local mutedError = require(AvatarExperienceUIKitParent.Loggers).mutedError

local bool1 = game:DefineFastFlag("AXDebugGridShouldErrorOnInvalidRowCount", false)

local function GridRow(tbl1)
    local tbl2 = {
        GridRowLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }
    for layoutOrder, item in tbl1.items do
        local str1 = `item-{tbl1.getItemId(item)}-{layoutOrder}`
        local createElement = React.createElement
        local tbl3 = {
            Size = UDim2.new(UDim.new(1 / tbl1.itemsPerRow, 0), UDim.new(0, 0)),
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        }
        local tbl4 = {
            Padding = React.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, tbl1.gapHorizontal / 2),
                    PaddingRight = UDim.new(0, tbl1.gapHorizontal / 2)
                }
            ),
            Content = tbl1.renderItem({
                item = item,
                index = (tbl1.rowIndex - 1) * tbl1.itemsPerRow + layoutOrder,
                gridInformation = {
                    row = tbl1.rowIndex,
                    column = (layoutOrder - 1) % tbl1.itemsPerRow + 1
                }
            })
        }
        tbl2[str1] = createElement("Frame", tbl3, tbl4)
    end

    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }, tbl2)
end

return (React.forwardRef(function(tbl1, ref)
    local itemsPerRow = if tbl1.itemsPerRow <= 0 then 1 else tbl1.itemsPerRow
    if bool1 and tbl1.itemsPerRow <= 0 then
        mutedError(`itemsPerRow must be a positive number greater than 0, received {itemsPerRow}`)
    end
    local gapVertical = tbl1.gapVertical or 0
    local gapHorizontal = tbl1.gapHorizontal or 0

    local num1 = math.ceil(#tbl1.items / itemsPerRow)

    local tbl2 = {
        GridLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, gapVertical)
        }),
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, -gapHorizontal / 2),
                PaddingRight = UDim.new(0, -gapHorizontal / 2)
            }
        )
    }

    for i = 1, num1 do
        local var2 = (i - 1) * itemsPerRow + 1
        local items = {}
        table.move(tbl1.items, var2, var2 + itemsPerRow - 1, var2, items)
        local str1 = "row-" .. tostring(i)
        tbl2[str1] = React.createElement(GridRow, {
            items = items,
            itemsPerRow = itemsPerRow,
            renderItem = tbl1.renderItem,
            getItemId = tbl1.getItemId,
            LayoutOrder = i,
            gapHorizontal = gapHorizontal,
            rowIndex = i
        })
    end

    return React.createElement("Frame", {
        Size = tbl1.Size or UDim2.fromScale(1, 1),
        AutomaticSize = tbl1.AutomaticSize,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        ref = ref
    }, tbl2)
end))

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local VirtualizedList = require(scriptParentParentParentParent.VirtualizedList).VirtualizedList
local Cryo = require(scriptParentParentParentParent.Cryo)
local withStyle = require(Core.Style.withStyle)

local tbl1 = {
    selectable = true,
    size = UDim2.fromScale(1, 1)
}

local function ScrollingListTable(tbl2)
    return withStyle(function(arg1)
        local var1 = Cryo.Dictionary.join(tbl1, tbl2)

        local tbl3 = ({})
        local cells = var1.cells
        for layoutOrder, content in ipairs(cells) do
            local var2 = "Cell " .. layoutOrder
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl4 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromScale(1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                Name = var2
            }
            local tbl5 = { Content = content, Divider = 0 }
            local element

            if layoutOrder < #cells then
                element = React.createElement("Frame", {
                    Size = UDim2.new(1, -24, 0, 1),
                    Position = UDim2.new(0, 24, 1, -1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = arg1.Theme.Divider.Color,
                    BackgroundTransparency = arg1.Theme.Divider.Transparency,
                    ZIndex = 100
                })
                    or nil
            else
                element = nil
            end

            tbl5.Divider = element
            tbl3[var2] = createElement(str1, tbl4, tbl5)
        end

        return React.createElement(VirtualizedList, {
            Size = var1.size,
            data = tbl3,
            renderItem = function(arg2)
                return arg2.item
            end,
            getItemCount = function(_): number
                return #cells
            end,
            getItem = function(arg2, num1: number)
                return arg2["Cell " .. tostring(num1)]
            end,
            keyExtractor = function(_, num1: number): string
                return "Cell " .. tostring(num1)
            end,
            style = {
                AnchorPoint = var1.anchorPoint,
                Position = var1.position,
                BackgroundTransparency = 1,
                LayoutOrder = var1.layoutOrder,
                Name = var1.Name or "ListTable",
                ScrollBarThickness = 0,
                Selectable = var1.selectable
            },
            contentContainerStyle = { BackgroundTransparency = 1 }
        })
    end)
end

return ScrollingListTable

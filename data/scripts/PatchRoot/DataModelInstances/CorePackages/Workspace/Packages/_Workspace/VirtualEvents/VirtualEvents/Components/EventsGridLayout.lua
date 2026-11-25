-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)

local tbl1 = {
    itemPadding = UDim.new(0, 12),
    numItemsShown = math.huge
}

local function EventsGridLayout(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = React.useMemo(function()
        local result = ({})
        for layoutOrder = 1, var1.numItemsShown do
            local content = var1.items[layoutOrder]

            local createElement = React.createElement
            local tbl3 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            }
            result[layoutOrder] = createElement("Frame", tbl3, { Content = content })
        end

        return result
    end, { var1.items, var1.numItemsShown })

    local var3 = React.useMemo(function()
        local result = {}

        for layoutOrder = 1, #var2, 2 do
            local var3 = var2[layoutOrder]
            local var4 = var2[layoutOrder + 1]

            local createElement = React.createElement
            local str1 = "Frame"
            local tbl3 = {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder
            }
            local tbl4 = {
                Layout = React.createElement("UIListLayout", {
                    Padding = var1.itemPadding,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left
                }),
                CellFrame1 = React.createElement("Frame", {
                    Size = UDim2.new(0.5, -var1.itemPadding.Offset / 2, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                }, {
                    Item = React.createElement(React.Fragment, nil, var3)
                }),
                CellFrame2 = 0
            }
            var4 = var4
                and React.createElement("Frame", {
                    Size = UDim2.new(0.5, -var1.itemPadding.Offset / 2, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                }, {
                    Item = React.createElement(React.Fragment, nil, var4)
                })
            tbl4.CellFrame2 = var4
            local element = createElement(str1, tbl3, tbl4)

            local num1 = layoutOrder / 2
            result["Row" .. math.ceil(num1)] = element
        end
        return result
    end, { var1.items, var2 })

    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        },
        {
            Layout = React.createElement(
                "UIListLayout",
                {
                    Padding = var1.itemPadding,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            ),
            Rows = React.createElement(React.Fragment, nil, var3)
        }
    )
end
return EventsGridLayout

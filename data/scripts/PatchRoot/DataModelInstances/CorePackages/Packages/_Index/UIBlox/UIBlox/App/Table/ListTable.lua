-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local t = require(scriptParentParentParentParent.t)
local Roact = require(scriptParentParentParentParent.Roact)
local withStyle = require(Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("ListTable")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    size = t.optional(t.UDim2),
    showDividers = t.optional(t.boolean),
    dividerStartOffset = t.optional(t.number),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    automaticSize = t.optional(t.enum(Enum.AutomaticSize)),
    cells = t.array(t.table)
})

var1.defaultProps = { showDividers = true, dividerStartOffset = 24 }

function var1.render(arg1)
    return withStyle(function(arg2)
        local size = arg1.props.size
        local automaticSize = arg1.props.automaticSize
        if not size then
            if automaticSize then
                if automaticSize == Enum.AutomaticSize.X then
                    size = UDim2.fromScale(0, 1)
                elseif automaticSize == Enum.AutomaticSize.Y then
                    size = UDim2.fromScale(1, 0)
                elseif automaticSize == Enum.AutomaticSize.XY then
                    size = UDim2.fromScale(0, 0)
                else
                    size = UDim2.fromScale(1, 1)
                end
            else
                size = UDim2.fromScale(1, 1)
            end
        end

        local tbl1 = {
            ListLayout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            )
        }
        local cells = arg1.props.cells
        for layoutOrder, content in ipairs(cells) do
            local var2 = "Cell " .. layoutOrder
            local var3 = arg1.props.showDividers and layoutOrder < #cells
            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl2 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromScale(1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y
            }
            local tbl3 = { Content = content, Divider = 0 }
            local element

            if var3 then
                element = Roact.createElement("Frame", {
                    Size = UDim2.new(1, -arg1.props.dividerStartOffset, 0, 1),
                    Position = UDim2.new(0, arg1.props.dividerStartOffset, 1, -1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = arg2.Theme.Divider.Color,
                    BackgroundTransparency = arg2.Theme.Divider.Transparency,
                    ZIndex = 100
                })
                    or nil
            else
                element = nil
            end

            tbl3.Divider = element
            tbl1[var2] = createElement(str1, tbl2, tbl3)
        end

        return Roact.createElement("Frame", {
            LayoutOrder = arg1.props.layoutOrder,
            Size = size,
            AutomaticSize = automaticSize,
            AnchorPoint = arg1.props.anchorPoint,
            Position = arg1.props.position,
            BackgroundTransparency = 1
        }, tbl1)
    end)
end

return var1

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)

local _LuauHeapTypes = require(script.Parent.LuauHeapTypes)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local StatEntryFrameHeight = Constants.LuauHeapFormatting.StatEntryFrameHeight
local _DepthIndent = Constants.LuauHeapFormatting.DepthIndent
local ValueCellWidth = Constants.LuauHeapFormatting.ValueCellWidth
local CellPadding = Constants.LuauHeapFormatting.CellPadding
local ValuePadding = Constants.LuauHeapFormatting.ValuePadding

local var1 = Roact.PureComponent:extend("LuauHeapViewStatEntry")

local function BorderedCellLabel(tbl1)
    return Roact.createFragment({
        Label = Roact.createElement(CellLabel, { text = tbl1.text, size = tbl1.size, pos = tbl1.pos, richText = true }),
        LeftBorder = Roact.createElement("Frame", {
            Size = UDim2.new(UDim.new(0, LineWidth), tbl1.size.Y),
            Position = UDim2.fromOffset(-ValuePadding, 0) + tbl1.pos,
            AnchorPoint = Vector2.new(0, 0),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    })
end

function var1.renderValues(_, arg1)
    local result = ({})
    local uDim2 = UDim2.new(ValueCellWidth, -ValuePadding, 0, StatEntryFrameHeight)
    local uDim2_2 = UDim2.new(1 - ValueCellWidth * #arg1, ValuePadding, 0, 0)
    for value, value2 in arg1 do
        local str1 = tostring(value)
        result[str1] = Roact.createElement(
            BorderedCellLabel,
            {
                text = tostring(value2),
                size = uDim2,
                pos = uDim2_2 + UDim2.fromScale(ValueCellWidth * (value - 1), 0)
            }
        )
    end

    return result
end

function var1.render(arg1)
    local props = arg1.props

    local var2 = props.size or UDim2.new(1, 0, 0, StatEntryFrameHeight)
    local layoutOrder = props.layoutOrder or 0
    local data = props.data
    local compare = props.compare

    local str1 = string.format("%.0f", data.Size)
    local str2 = string.format("%.0f", data.Count)

    if compare then
        if compare.Size ~= data.Size then
            str1 = string.format(
                "%d <font color=\"#%s\">(%s%d)</font>",
                data.Size,
                if compare.Size > data.Size then "0f0" else "f00",
                if compare.Size > data.Size then "" else "+",
                data.Size - compare.Size
            )
        end

        if compare.Count ~= data.Count then
            str2 = string.format(
                "%d <font color=\"#%s\">(%s%d)</font>",
                data.Count,
                if compare.Count > data.Count then "0f0" else "f00",
                if compare.Count > data.Count then "" else "+",
                data.Count - compare.Count
            )
        end
    end

    local tbl1 = { str1, str2 }

    local uDim = UDim.new(1 - ValueCellWidth * #tbl1, 0)

    return Roact.createElement(
        "Frame",
        {
            Size = var2,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            AutomaticSize = Enum.AutomaticSize.Y
        },
        {
            layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            button = Roact.createElement(BannerButton, {
                size = UDim2.new(1, 0, 0, StatEntryFrameHeight),
                inset = 0,
                isExpanded = false,
                isExpandable = false,
                layoutOrder = -1
            }, {
                name = Roact.createElement(
                    CellLabel,
                    {
                        text = data.Name,
                        size = UDim2.new(uDim, UDim.new(1, 0)),
                        pos = UDim2.new(0, CellPadding, 0, 0)
                    }
                ),
                values = Roact.createFragment(arg1:renderValues(tbl1))
            })
        }
    )
end
return var1

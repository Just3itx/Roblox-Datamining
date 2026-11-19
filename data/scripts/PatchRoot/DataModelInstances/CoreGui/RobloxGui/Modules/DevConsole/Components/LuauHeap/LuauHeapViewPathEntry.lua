-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)

local _LuauHeapTypes = require(script.Parent.LuauHeapTypes)

local Constants = require(script.Parent.Parent.Parent.Constants)
local _LineWidth = Constants.GeneralFormatting.LineWidth
local _LineColor = Constants.GeneralFormatting.LineColor

local PathEntryFrameHeight = Constants.LuauHeapFormatting.PathEntryFrameHeight
local DepthIndent = Constants.LuauHeapFormatting.DepthIndent
local _ValueCellWidth = Constants.LuauHeapFormatting.ValueCellWidth
local CellPadding = Constants.LuauHeapFormatting.CellPadding
local _ValuePadding = Constants.LuauHeapFormatting.ValuePadding

local var1 = Roact.PureComponent:extend("LuauHeapViewPathEntry")

function var1.init(arg1)
    arg1.state = { expanded = false }

    function arg1.onButtonPress()
        arg1:setState(function(arg2)
            return {
                expanded = not arg2.expanded
            }
        end)
    end
end

function var1.renderChildren(arg1, arg2)
    local result = ({})

    local xOffset = 2 * DepthIndent + CellPadding

    if arg1.state.expanded and arg2 and #arg2 then
        for layoutOrder, text in ipairs(arg2) do
            local createElement = Roact.createElement
            local var2 = CellLabel
            local tbl1 = {
                text = text,
                layoutOrder = layoutOrder,
                size = UDim2.new(UDim.new(1, -xOffset), UDim.new(0, PathEntryFrameHeight)),
                pos = UDim2.new(0, xOffset, 0, 0)
            }
            result[layoutOrder] = createElement(var2, tbl1)
        end
    end

    return result
end

function var1.render(arg1)
    local props = arg1.props

    local var2 = props.size or UDim2.new(1, 0, 0, PathEntryFrameHeight)
    local layoutOrder = props.layoutOrder or 0
    local name = props.name
    local data = props.data

    local inset = props.depth * DepthIndent

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
                size = UDim2.new(1, 0, 0, PathEntryFrameHeight),
                inset = inset,
                isExpanded = arg1.state.expanded,
                isExpandable = #data ~= 0,
                onButtonPress = arg1.onButtonPress,
                layoutOrder = -1
            }, {
                name = Roact.createElement(
                    CellLabel,
                    {
                        text = name,
                        size = UDim2.new(UDim.new(1, -inset), UDim.new(1, 0)),
                        pos = UDim2.new(0, CellPadding + inset, 0, 0)
                    }
                )
            }),
            children = Roact.createFragment(arg1:renderChildren(data))
        }
    )
end
return var1

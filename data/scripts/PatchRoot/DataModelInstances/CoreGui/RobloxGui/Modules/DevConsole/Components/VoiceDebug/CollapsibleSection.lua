-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)

local MainRowPadding = require(script.Parent.Parent.Parent.Constants).GeneralFormatting.MainRowPadding

local var1 = Roact.PureComponent:extend("CollapsibleSection")

function var1.init(arg1)
    arg1.state = {
        expanded = arg1.props.defaultExpanded == nil or arg1.props.defaultExpanded
    }

    function arg1.onButtonPress()
        arg1:setState(function(arg2)
            return {
                expanded = not arg2.expanded
            }
        end)
    end
end

function var1.render(arg1)
    local title = arg1.props.title
    local layoutOrder = arg1.props.layoutOrder
    local expanded = arg1.state.expanded
    local hideLines = arg1.props.hideLines

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    local tbl2 = {
        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) }),
        Header = Roact.createElement(BannerButton, {
            size = UDim2.new(1, 0, 0, 20),
            isExpanded = expanded,
            isExpandable = true,
            hideLines = hideLines,
            onButtonPress = arg1.onButtonPress,
            layoutOrder = 1
        }, {
            Label = Roact.createElement(
                CellLabel,
                {
                    text = title,
                    bold = true,
                    size = UDim2.new(1, -20, 1, 0),
                    pos = UDim2.new(0, 20, 0, 0)
                }
            )
        }),
        Content = 0
    }
    local element

    if expanded then
        element = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 2
            },
            {
                UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) }),
                Children = Roact.createFragment(arg1.props[Roact.Children] or {})
            }
        )
            or nil
    else
        element = nil
    end

    tbl2.Content = element
    return createElement(str1, tbl1, tbl2)
end

return var1

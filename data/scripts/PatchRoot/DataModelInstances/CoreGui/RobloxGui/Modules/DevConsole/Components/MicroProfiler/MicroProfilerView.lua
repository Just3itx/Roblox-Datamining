-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Immutable = require(script.Parent.Parent.Parent.Immutable)
local Roact = require(CorePackages.Packages.Roact)

local LocalActionsView = require(script.Parent.LocalActionsView)
local RecentlyCapturedDumpsView = require(script.Parent.RecentlyCapturedDumpsView)
local RecordAndDumpView = require(script.Parent.RecordAndDumpView)

local var1 = Roact.Component:extend("Column")
local var2 = Roact.Component:extend("MicroProfilerView")

function var1.render(arg1)
    local prop = arg1.props[Roact.Children]

    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder
        },
        Immutable.JoinDictionaries({
            UIListLayout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, 12),
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top
            })
        }, prop)
    )
end

function var2.render(arg1)
    return Roact.createElement("Frame", {
        Size = arg1.props.Size,
        BackgroundTransparency = arg1.props.BackgroundTransparency,
        LayoutOrder = arg1.props.LayoutOrder
    }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0, 8),
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            VerticalFlex = Enum.UIFlexAlignment.Fill
        }),
        UIPadding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 0),
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8)
        }),
        LeftColumn = Roact.createElement(var1, { LayoutOrder = 1 }, {
            LocalActionsView = Roact.createElement(LocalActionsView, { LayoutOrder = 1 }),
            RecordAndDumpView = Roact.createElement(RecordAndDumpView, { LayoutOrder = 2 })
        }),
        RightColumn = Roact.createElement(
            var1,
            { LayoutOrder = 2 },
            {
                RecentlyCapturedDumpsView = Roact.createElement(RecentlyCapturedDumpsView)
            }
        )
    })
end
return var2

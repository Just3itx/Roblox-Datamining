-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)
local LineGraph = require(Components.LineGraph)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local ValueCellWidth = Constants.MemoryFormatting.ValueCellWidth
local CellPadding = Constants.MemoryFormatting.CellPadding
local ValuePadding = Constants.MemoryFormatting.ValuePadding

local EntryFrameHeight = Constants.GeneralFormatting.EntryFrameHeight
local DepthIndent = Constants.MemoryFormatting.DepthIndent

local convertTimeStamp = require(script.Parent.Parent.Parent.Util.convertTimeStamp)

return function(arg1)
    local size = arg1.size
    local depth = arg1.depth
    local showGraph = arg1.showGraph
    local dataStats = arg1.dataStats
    local layoutOrder = arg1.layoutOrder

    local onButtonPress = arg1.onButtonPress
    local formatValueStr = arg1.formatValueStr
    local getX = arg1.getX
    local getY = arg1.getY

    local xOffset = depth * DepthIndent

    local name = arg1.name
    local value = arg1.value
    if dataStats then
        value = dataStats.dataSet:back().data
    end

    local uDim = UDim.new(1 - ValueCellWidth, -xOffset)

    return Roact.createElement("Frame", {
        Size = size,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        button = Roact.createElement(BannerButton, {
            size = UDim2.new(1, -xOffset, 0, EntryFrameHeight),
            pos = UDim2.new(0, xOffset, 0, 0),
            isExpanded = showGraph,
            onButtonPress = onButtonPress
        }, {
            name = Roact.createElement(
                CellLabel,
                {
                    text = name,
                    size = UDim2.new(uDim, UDim.new(1, 0)),
                    pos = UDim2.new(0, CellPadding, 0, 0)
                }
            ),
            horizonal1 = Roact.createElement("Frame", {
                Size = UDim2.new(1, -xOffset, 0, LineWidth),
                Position = UDim2.new(0, xOffset, 0, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }),
            horizonal2 = Roact.createElement("Frame", {
                Size = UDim2.new(1, -xOffset, 0, LineWidth),
                Position = UDim2.new(0, xOffset, 1, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })
        }),
        value = value
            and Roact.createElement(CellLabel, {
                text = formatValueStr(value),
                size = UDim2.new(ValueCellWidth, -ValuePadding, 0, EntryFrameHeight),
                pos = UDim2.new(1 - ValueCellWidth, ValuePadding, 0, 0)
            }),
        vertical = Roact.createElement("Frame", {
            Size = UDim2.new(0, 1, 0, EntryFrameHeight),
            Position = UDim2.new(1 - ValueCellWidth, 0, 0, 0),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        }),
        Graph = showGraph
            and Roact.createElement(LineGraph, {
                pos = UDim2.new(0, 0, 0, EntryFrameHeight),
                size = UDim2.new(1, 0, 1, -EntryFrameHeight),
                graphData = dataStats.dataSet,
                maxY = dataStats.max,
                minY = dataStats.min,
                getX = getX,
                getY = getY,
                stringFormatX = convertTimeStamp,
                stringFormatY = formatValueStr,
                axisLabelX = "Timestamp",
                axisLabelY = name
            })
    })
end

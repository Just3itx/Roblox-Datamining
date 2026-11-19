-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)
local LineGraph = require(Components.LineGraph)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local ChartHeaderNames = Constants.ServerStatsFormatting.ChartHeaderNames
local ValueCellWidth = Constants.ServerStatsFormatting.ValueCellWidth
local CellPadding = Constants.ServerStatsFormatting.CellPadding
local ExpandArrowPadding = Constants.ServerStatsFormatting.ExpandArrowPadding
local HeaderFrameHeight = Constants.ServerStatsFormatting.HeaderFrameHeight
local EntryFrameHeight = Constants.ServerStatsFormatting.EntryFrameHeight

local LineGraphHeight = Constants.GeneralFormatting.LineGraphHeight

local NoResultSearchStr = Constants.GeneralFormatting.NoResultSearchStr

local convertTimeStamp = require(script.Parent.Parent.Parent.Util.convertTimeStamp)

local var1 = Roact.Component:extend("ServerStats")

local function formatData(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%.3f", arg1)
end

local function getX(arg1)
    return arg1.time
end

local function getY(arg1)
    return arg1.value
end

function var1.init(arg1)
    local serverStatsData = arg1.props.ServerStatsData:getCurrentData()

    function arg1.getOnButtonPress(expandedEntry)
        return function(_, _)
            arg1:setState({ expandedEntry = not (arg1.state.expandedEntry == expandedEntry) and expandedEntry })
        end
    end

    arg1.state = { serverStatsData = serverStatsData }
end

function var1.didMount(arg1)
    arg1.statsConnector = arg1.props.ServerStatsData:Signal():Connect(function(serverStatsData)
        arg1:setState({ serverStatsData = serverStatsData })
    end)
end

function var1.willUnmount(arg1)
    arg1.statsConnector:Disconnect()
    arg1.statsConnector = nil
end

function var1.render(arg1)
    local tbl1 = ({})
    local searchTerm = arg1.props.searchTerm
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size

    local expandedEntry = arg1.state.expandedEntry
    local serverStatsData = arg1.state.serverStatsData

    local num1 = 1
    local num2 = 0
    local num3 = 0
    if serverStatsData then
        for k, value in pairs(serverStatsData) do
            num2 += 1
            if searchTerm and string.find(k:lower(), searchTerm:lower()) == nil then
                continue
            end

            num1 += 1

            local bool1 = expandedEntry == k
            local yOffset = bool1 and EntryFrameHeight + LineGraphHeight or EntryFrameHeight

            if bool1 then
                num3 = num3 + 1 or num3
            end
            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl2 = {
                Size = UDim2.new(1, 0, 0, yOffset),
                BackgroundTransparency = 1,
                LayoutOrder = num1
            }
            local tbl3 = { DataButton = 0, Graph = 0 }
            local createElement2 = Roact.createElement
            local var2 = BannerButton
            local tbl4 = {
                size = UDim2.new(1, 0, 0, EntryFrameHeight),
                pos = UDim2.new(),
                isExpanded = bool1,
                onButtonPress = arg1.getOnButtonPress(k)
            }
            local tbl5 = {}
            local createElement3 = Roact.createElement
            local var3 = CellLabel
            local tbl6 = {
                text = k,
                size = UDim2.new(1 - ValueCellWidth, -CellPadding - ExpandArrowPadding, 1, 0),
                pos = UDim2.new(0, CellPadding + ExpandArrowPadding, 0, 0)
            }
            tbl5[k] = createElement3(var3, tbl6)
            tbl5.Data = Roact.createElement(CellLabel, {
                text = formatData(value.dataSet:back().value),
                size = UDim2.new(ValueCellWidth, -CellPadding, 1, 0),
                pos = UDim2.new(1 - ValueCellWidth, CellPadding, 0, 0)
            })

            tbl5.VerticalLine = Roact.createElement("Frame", {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = UDim2.new(1 - ValueCellWidth, 0, 0, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })

            tbl5.HorizontalAlignment = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, LineWidth),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })
            tbl3.DataButton = createElement2(var2, tbl4, tbl5)

            bool1 = bool1
                and Roact.createElement(LineGraph, {
                    pos = UDim2.new(0, 0, 0, EntryFrameHeight),
                    size = UDim2.new(1, 0, 1, -EntryFrameHeight),
                    graphData = value.dataSet,
                    minY = value.min,
                    maxY = value.max,
                    getX = getX,
                    getY = getY,
                    axisLabelX = "Timestamp",
                    axisLabelY = k,
                    stringFormatX = convertTimeStamp,
                    stringFormatY = formatData
                })
            tbl3.Graph = bool1
            tbl1[k] = createElement(str1, tbl2, tbl3)
        end
    end

    if num1 == 1 then
        if num2 == 0 then
            return Roact.createElement("TextLabel", {
                Size = size,
                Position = UDim2.new(0, 0, 0, 0),
                Text = "Awaiting Server Stats",
                TextColor3 = Constants.Color.Text,
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder
            })
        end
        local str1 = string.format(NoResultSearchStr, searchTerm)
        tbl1.emptyResult = Roact.createElement(
            "TextLabel",
            {
                Size = size,
                Text = str1,
                TextColor3 = Constants.Color.Text,
                BackgroundTransparency = 1
            }
        )
    end

    tbl1.UIListLayout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local yOffset = num2 * EntryFrameHeight + num3 * LineGraphHeight

    local createElement = Roact.createElement

    local tbl2 = {
        Header = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, HeaderFrameHeight),
            BackgroundTransparency = 1
        }, {
            [ChartHeaderNames[1]] = Roact.createElement(CellLabel, {
                text = ChartHeaderNames[1],
                size = UDim2.new(1 - ValueCellWidth, -CellPadding - ExpandArrowPadding, 1, 0),
                pos = UDim2.new(0, CellPadding + ExpandArrowPadding, 0, 0)
            }),
            [ChartHeaderNames[2]] = Roact.createElement(CellLabel, {
                text = ChartHeaderNames[2],
                size = UDim2.new(ValueCellWidth, -CellPadding, 1, 0),
                pos = UDim2.new(1 - ValueCellWidth, CellPadding, 0, 0)
            }),
            upperHorizontalLine = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, LineWidth),
                    BackgroundColor3 = LineColor,
                    BorderSizePixel = 0
                }
            ),
            VerticalLine = Roact.createElement("Frame", {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = UDim2.new(1 - ValueCellWidth, 0, 0, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }),
            lowerHorizontalLine = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, LineWidth),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })
        }),
        mainFrame = Roact.createElement("ScrollingFrame", {
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight),
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            CanvasSize = UDim2.new(1, 0, 0, yOffset),
            ScrollBarThickness = 5,
            BackgroundTransparency = 1
        }, tbl1)
    }
    return createElement("Frame", { Size = size, BackgroundTransparency = 1, LayoutOrder = layoutOrder }, tbl2)
end

return DataConsumer(var1, "ServerStatsData")

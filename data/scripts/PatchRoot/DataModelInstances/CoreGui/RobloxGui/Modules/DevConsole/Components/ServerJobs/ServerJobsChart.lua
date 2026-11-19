-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local HeaderButton = require(Components.HeaderButton)
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)
local LineGraph = require(Components.LineGraph)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local ChartHeaderNames = Constants.ServerJobsFormatting.ChartHeaderNames
local ValueCellWidth = Constants.ServerJobsFormatting.ValueCellWidth
local EntryFrameHeight = Constants.ServerJobsFormatting.EntryFrameHeight
local HeaderFrameHeight = Constants.ServerJobsFormatting.HeaderFrameHeight
local CellPadding = Constants.ServerJobsFormatting.CellPadding
local MinFrameWidth = Constants.ServerJobsFormatting.MinFrameWidth

local LineGraphHeight = Constants.GeneralFormatting.LineGraphHeight

local convertTimeStamp = require(script.Parent.Parent.Parent.Util.convertTimeStamp)

local tbl1 = {
    function(arg1): string
        return arg1 and string.format("%.4f%%", arg1) or ""
    end,
    function(arg1): string
        return arg1 and string.format("%.4f/s", arg1) or ""
    end,
    function(arg1): string
        return arg1 and string.format("%.4fms", arg1) or ""
    end
}

local NoResultSearchStr = Constants.GeneralFormatting.NoResultSearchStr

local num1 = 0
local tbl2 = {}
local tbl3 = {}
local tbl4 = {}

local var1 = EntryFrameHeight - LineWidth

for _, value in ipairs(ValueCellWidth) do
    table.insert(tbl2, UDim2.new(num1, CellPadding, 0, 0))
    table.insert(tbl3, UDim2.new(value, -CellPadding, 0, HeaderFrameHeight))
    table.insert(tbl4, UDim2.new(value, -CellPadding, 0, var1))
    num1 += value
end

local tbl5 = ({})
for i, value in ipairs(tbl2) do
    tbl5[i] = UDim2.new(value.X.Scale, value.X.Offset - CellPadding, value.Y.Scale, value.Y.Offset)
end

local var2 = Roact.Component:extend("ServerJobsChart")

local function getX(arg1)
    return arg1.time
end

local function getDutyCycle(arg1)
    return arg1.data[1]
end

local function getStepsPerSec(arg1)
    return arg1.data[2]
end

local function getStepTime(arg1)
    return arg1.data[3]
end

function var2.init(arg1, arg2)
    local serverJobsList = arg2.ServerJobsData:getCurrentData()

    function arg1.getOnButtonPress(expandIndex)
        return function(_, _)
            arg1:setState({ expandIndex = not (arg1.state.expandIndex == expandIndex) and expandIndex })
        end
    end

    function arg1.onSortChanged(arg3)
        if arg3 == arg2.ServerJobsData:getSortType() then
            arg1:setState({ reverseSort = not arg1.state.reverseSort })
            return
        end

        arg2.ServerJobsData:setSortType(arg3)
        arg1:setState({ reverseSort = false })
    end

    function arg1.onCanvasPosChanged()
        local canvasPosition = arg1.scrollingRef.current.CanvasPosition
        if arg1.state.canvasPos ~= canvasPosition then
            arg1:setState({ canvasPos = canvasPosition })
        end
    end

    arg1.scrollingRef = Roact.createRef()

    arg1.state = { serverJobsList = serverJobsList, reverseSort = false, expandIndex = nil }
end

function var2.willUpdate(arg1)
    if arg1.canvasPosConnector then
        arg1.canvasPosConnector:Disconnect()
    end
end

function var2.didUpdate(arg1)
    if not arg1.scrollingRef.current then
        return
    end

    arg1.canvasPosConnector = arg1.scrollingRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasPosChanged)

    local absoluteSize = arg1.scrollingRef.current.AbsoluteSize
    local absScrollSize = arg1.state.absScrollSize
    if absoluteSize.X ~= absScrollSize.X or absoluteSize.Y ~= absScrollSize.Y then
        arg1:setState({ absScrollSize = absoluteSize })
    end
end

function var2.didMount(arg1)
    arg1.statsConnector = arg1.props.ServerJobsData:Signal():Connect(function(serverJobsList)
        arg1:setState({ serverJobsList = serverJobsList })
    end)

    if not arg1.scrollingRef.current then
        return
    end

    arg1.canvasPosConnector = arg1.scrollingRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasPosChanged)

    arg1:setState(
        {
            absScrollSize = arg1.scrollingRef.current.AbsoluteSize,
            canvasPos = arg1.scrollingRef.current.CanvasPosition
        }
    )
end

function var2.willUnmount(arg1)
    arg1.statsConnector:Disconnect()
    arg1.statsConnector = nil
    if arg1.canvasPosConnector then
        arg1.canvasPosConnector:Disconnect()
        arg1.canvasPosConnector = nil
    end
end

function var2.render(arg1)
    local tbl6 = ({})
    local searchTerm = arg1.props.searchTerm
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder

    local serverJobsList = arg1.state.serverJobsList
    local reverseSort = arg1.state.reverseSort
    local expandIndex = arg1.state.expandIndex
    local canvasPos = arg1.state.canvasPos
    local absScrollSize = arg1.state.absScrollSize

    local xOffset = absScrollSize and math.max(absScrollSize.X, MinFrameWidth) or MinFrameWidth

    local serverJobsListLen = #serverJobsList

    if serverJobsListLen == 0 then
        return Roact.createElement("TextLabel", {
            Size = size,
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Awaiting Server Jobs Information",
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        })
    end

    local yOffset = 0
    if absScrollSize then
        local yOffset2 = -1
        local num2 = 0

        for k, serverJob in pairs(serverJobsList) do
            local name = serverJob.name
            if searchTerm and string.find(name:lower(), searchTerm:lower()) == nil then
                continue
            end

            local dataStats = serverJob.dataStats
            local var3 = dataStats.dataSet:back()

            local bool1 = expandIndex == name
            local yOffset3 = bool1 and EntryFrameHeight + 3 * LineGraphHeight / 2 + CellPadding * 4 or EntryFrameHeight

            if yOffset + yOffset3 >= canvasPos.Y then
                if num2 < absScrollSize.Y then
                    if reverseSort then
                        k = serverJobsListLen - k or k
                    end
                    local tbl7 = ({})
                    tbl7[name] = Roact.createElement(CellLabel, { text = name, size = tbl3[1], pos = tbl2[1] })

                    for k2, value in pairs(var3.data) do
                        local var4 = ChartHeaderNames[k2]
                        tbl7[var4] = Roact.createElement(CellLabel, { text = tbl1[k2](value), size = tbl3[k2 + 1], pos = tbl2[k2 + 1] })
                    end

                    for i = 2, #tbl5 do
                        local str1 = string.format("VerticalLine_%d", i)
                        tbl7[str1] = Roact.createElement(
                            "Frame",
                            {
                                Size = UDim2.new(0, LineWidth, 1, 0),
                                Position = tbl5[i],
                                BackgroundColor3 = LineColor,
                                BorderSizePixel = 0
                            }
                        )
                    end

                    tbl7.lowerHorizontalLine = Roact.createElement("Frame", {
                        Size = UDim2.new(1, 0, 0, LineWidth),
                        Position = UDim2.new(0, 0, 1, 0),
                        BackgroundColor3 = LineColor,
                        BorderSizePixel = 0
                    })

                    local createElement = Roact.createElement
                    local str1 = "Frame"
                    local tbl8 = {
                        Size = UDim2.new(0, xOffset, 0, yOffset3),
                        BackgroundTransparency = 1,
                        LayoutOrder = k + 1
                    }
                    local tbl9 = {
                        Button = Roact.createElement(BannerButton, {
                            size = UDim2.new(1, 0, 0, EntryFrameHeight),
                            pos = UDim2.new(),
                            isExpanded = bool1,
                            onButtonPress = arg1.getOnButtonPress(name)
                        }, tbl7),
                        DutyCycleGraph = 0,
                        StepsPerSecGraph = 0,
                        StepTimeGraph = 0
                    }
                    local element

                    if bool1 then
                        element = Roact.createElement(LineGraph, {
                            pos = UDim2.new(0, 0, 0, EntryFrameHeight + CellPadding),
                            size = UDim2.new(0, xOffset, 0, LineGraphHeight / 2),
                            graphData = dataStats.dataSet,
                            maxY = dataStats.max[1],
                            minY = dataStats.min[1],
                            getX = getX,
                            getY = getDutyCycle,
                            stringFormatX = convertTimeStamp,
                            stringFormatY = tbl1[1],
                            axisLabelX = "Timestamp",
                            axisLabelY = name .. " " .. ChartHeaderNames[2]
                        })
                    else
                        element = bool1
                    end

                    tbl9.DutyCycleGraph = element
                    local element2

                    if bool1 then
                        element2 = Roact.createElement(LineGraph, {
                            pos = UDim2.new(0, 0, 0, EntryFrameHeight + LineGraphHeight / 2 + CellPadding * 2),
                            size = UDim2.new(0, xOffset, 0, LineGraphHeight / 2),
                            graphData = dataStats.dataSet,
                            maxY = dataStats.max[2],
                            minY = dataStats.min[2],
                            getX = getX,
                            getY = getStepsPerSec,
                            stringFormatX = convertTimeStamp,
                            stringFormatY = tbl1[2],
                            axisLabelX = "Timestamp",
                            axisLabelY = name .. " " .. ChartHeaderNames[3]
                        })
                    else
                        element2 = bool1
                    end

                    tbl9.StepsPerSecGraph = element2

                    if bool1 then
                        bool1 = Roact.createElement(LineGraph, {
                            pos = UDim2.new(0, 0, 0, EntryFrameHeight + LineGraphHeight + CellPadding * 3),
                            size = UDim2.new(0, xOffset, 0, LineGraphHeight / 2),
                            graphData = dataStats.dataSet,
                            maxY = dataStats.max[3],
                            minY = dataStats.min[3],
                            getX = getX,
                            getY = getStepTime,
                            stringFormatX = convertTimeStamp,
                            stringFormatY = tbl1[3],
                            axisLabelX = "Timestamp",
                            axisLabelY = name .. " " .. ChartHeaderNames[4]
                        })
                    end

                    tbl9.StepTimeGraph = bool1
                    tbl6[name] = createElement(str1, tbl8, tbl9)
                end

                if yOffset2 < 0 then
                    yOffset2 = yOffset
                else
                    num2 += yOffset3
                end
            end
            yOffset += yOffset3
        end

        if yOffset2 == -1 then
            local str1 = string.format(NoResultSearchStr, searchTerm)
            tbl6.emptyResult = Roact.createElement(
                "TextLabel",
                {
                    Size = size,
                    Text = str1,
                    TextColor3 = Constants.Color.Text,
                    BackgroundTransparency = 1
                }
            )
        else
            tbl6.WindowingPadding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset2), BackgroundTransparency = 1, LayoutOrder = 1 })
        end
    end

    local tbl7 = ({})
    for i = 1, #ChartHeaderNames do
        local var3 = ChartHeaderNames[i]
        tbl7[var3] = Roact.createElement(
            HeaderButton,
            {
                text = ChartHeaderNames[i],
                size = tbl3[i],
                pos = tbl2[i],
                sortfunction = arg1.onSortChanged
            }
        )
    end
    tbl7.upperHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    tbl7.lowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, -LineWidth),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    for i = 2, #tbl5 do
        local str1 = string.format("VerticalLine_%d", i)
        tbl7[str1] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = tbl5[i],
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }
        )
    end

    tbl6.UIListLayout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local createElement = Roact.createElement

    local tbl8 = {
        Header = Roact.createElement("Frame", { Size = UDim2.new(0, xOffset, 0, HeaderFrameHeight), BackgroundTransparency = 1 }, tbl7),
        MainChart = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight),
            BackgroundTransparency = 1,
            VerticalScrollBarInset = 1,
            ScrollBarThickness = 5,
            CanvasSize = UDim2.new(0, xOffset, 0, yOffset),
            [Roact.Ref] = arg1.scrollingRef
        }, tbl6)
    }
    return createElement(
        "Frame",
        {
            Size = size,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = layoutOrder
        },
        tbl8
    )
end

return DataConsumer(var2, "ServerJobsData")

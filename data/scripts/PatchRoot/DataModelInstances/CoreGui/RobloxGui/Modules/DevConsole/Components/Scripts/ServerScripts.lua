-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(script.Parent.Parent.Parent.Components.DataConsumer)
local HeaderButton = require(Components.HeaderButton)

local ServerScriptsEntry = require(script.Parent.ServerScriptsEntry)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local ChartCellWidths = Constants.ServerScriptsFormatting.ChartCellWidths
local ChartHeaderNames = Constants.ServerScriptsFormatting.ChartHeaderNames
local HeaderFrameHeight = Constants.ServerScriptsFormatting.HeaderFrameHeight
local EntryFrameHeight = Constants.ServerScriptsFormatting.EntryFrameHeight
local CellPadding = Constants.ServerScriptsFormatting.CellPadding

local LineGraphHeight = Constants.GeneralFormatting.LineGraphHeight

local NoResultSearchStr = Constants.GeneralFormatting.NoResultSearchStr

local cellOffset = {}
local tbl2 = {}
local entryCellSize = {}

local num1 = 0

for _, ChartCellWidth in ipairs(ChartCellWidths) do
    table.insert(cellOffset, UDim2.new(num1, CellPadding, 0, 0))
    table.insert(tbl2, UDim2.new(ChartCellWidth, -CellPadding, 0, HeaderFrameHeight))
    table.insert(entryCellSize, UDim2.new(ChartCellWidth, -CellPadding, 0, EntryFrameHeight))
    num1 += ChartCellWidth
end

local verticalOffsets = ({})
for i, value in ipairs(cellOffset) do
    verticalOffsets[i] = UDim2.new(value.X.Scale, value.X.Offset - CellPadding, value.Y.Scale, value.Y.Offset)
end

local var1 = Roact.Component:extend("ServerScripts")

local function constructHeader(sortfunction)
    local tbl5 = ({})

    for i = 1, #ChartHeaderNames do
        local var2 = ChartHeaderNames[i]
        tbl5[var2] = Roact.createElement(
            HeaderButton,
            {
                text = ChartHeaderNames[i],
                size = tbl2[i],
                pos = cellOffset[i],
                sortfunction = sortfunction
            }
        )
    end
    tbl5.upperHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    tbl5.verticalLine1 = Roact.createElement("Frame", {
        Size = UDim2.new(0, LineWidth, 1, 0),
        Position = verticalOffsets[2],
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    tbl5.verticalLine2 = Roact.createElement("Frame", {
        Size = UDim2.new(0, LineWidth, 1, 0),
        Position = verticalOffsets[3],
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    tbl5.lowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    return Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, HeaderFrameHeight), BackgroundTransparency = 1 }, tbl5)
end

local function getX(arg1)
    return arg1.time
end

local function getActivity(arg1)
    return arg1.data[1]
end

local function getRate(arg1)
    return arg1.data[2]
end

local function formatScriptsData(arg1): string
    return string.format("%.3f", arg1)
end

function var1.init(arg1, arg2)
    local serverScriptsData = arg2.ServerScriptsData:getCurrentData()

    function arg1.onSortChanged(arg3)
        if arg3 == arg2.ServerScriptsData:getSortType() then
            arg1:setState({ reverseSort = not arg1.state.reverseSort })
            return
        end

        arg2.ServerScriptsData:setSortType(arg3)
        arg1:setState({ reverseSort = false })
    end

    function arg1.getOnButtonPress(expandIndex)
        return function(_, _)
            arg1:setState({ expandIndex = not (arg1.state.expandIndex == expandIndex) and expandIndex })
        end
    end

    function arg1.onCanvasPosChanged()
        local canvasPosition = arg1.scrollingRef.current.CanvasPosition
        if arg1.state.canvasPos ~= canvasPosition then
            arg1:setState({ absScrollSize = arg1.scrollingRef.current.AbsoluteSize, canvasPos = canvasPosition })
        end
    end

    arg1.scrollingRef = Roact.createRef()

    arg1.state = { serverScriptsData = serverScriptsData, expandIndex = nil }
end

function var1.willUpdate(arg1)
    if arg1.canvasPosConnector then
        arg1.canvasPosConnector:Disconnect()
    end
end

function var1.didUpdate(arg1)
    if arg1.scrollingRef.current then
        arg1.canvasPosConnector = arg1.scrollingRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasPosChanged)
    end
end

function var1.didMount(arg1)
    arg1.statsConnector = arg1.props.ServerScriptsData:Signal():Connect(function(serverScriptsData)
        arg1:setState({ serverScriptsData = serverScriptsData })
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

function var1.willUnmount(arg1)
    arg1.statsConnector:Disconnect()
    arg1.statsConnector = nil
end

function var1.render(arg1)
    local searchTerm = arg1.props.searchTerm
    local scriptFilters = arg1.props.scriptFilters
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size

    local serverScriptsData = arg1.state.serverScriptsData
    local reverseSort = arg1.state.reverseSort
    local absScrollSize = arg1.state.absScrollSize
    local canvasPos = arg1.state.canvasPos

    local tbl5 = ({})
    local serverScriptsDataLen = #serverScriptsData

    if serverScriptsDataLen == 0 then
        return Roact.createElement("TextLabel", {
            Size = size,
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Awaiting Server Scripts Information.",
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        })
    end

    local yOffset = 0
    local yOffset2 = -1
    local num2 = 0
    local num3 = 0

    if canvasPos and absScrollSize then
        for k, scriptData in pairs(serverScriptsData) do
            if searchTerm and string.find(scriptData.name:lower(), searchTerm:lower()) == nil then
                continue
            end

            num3 += 1

            local active = scriptFilters.Active
            local inactive = scriptFilters.Inactive
            local var2 = scriptData.dataStats.dataSet:back()

            if active ~= inactive and (var2.data[1] > 0 and inactive or var2.data[1] == 0 and active) then
                continue
            end

            local showGraph = arg1.state.expandIndex == scriptData.name
            local frameHeight = showGraph and EntryFrameHeight + 2 * LineGraphHeight or EntryFrameHeight

            if yOffset + frameHeight >= canvasPos.Y then
                if num2 < absScrollSize.Y then
                    local activityBoxColor = var2.data[1] > 0 and Constants.Color.ActiveBox or Constants.Color.InactiveBox
                    local var3 = if reverseSort then serverScriptsDataLen - k or k else k
                    local createElement = Roact.createElement
                    local var6 = ServerScriptsEntry
                    local tbl6 = {
                        scriptData = scriptData,
                        frameHeight = frameHeight,
                        showGraph = showGraph,
                        layoutOrder = var3,
                        activityBoxColor = activityBoxColor,
                        entryCellSize = entryCellSize,
                        cellOffset = cellOffset,
                        verticalOffsets = verticalOffsets,
                        onButtonPress = arg1.getOnButtonPress(scriptData.name),
                        formatScriptsData = formatScriptsData,
                        getX = getX,
                        getActivity = getActivity,
                        getRate = getRate,
                        stringFormatY = formatScriptsData
                    }
                    tbl5[k] = createElement(var6, tbl6)
                end

                if yOffset2 < 0 then
                    yOffset2 = yOffset
                else
                    num2 += frameHeight
                end
            end
            yOffset += frameHeight
        end

        if num3 > 0 then
            tbl5.WindowingPadding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset2), BackgroundTransparency = 1, LayoutOrder = 1 })
        else
            local str1 = string.format(NoResultSearchStr, searchTerm)
            tbl5.emptySearch = Roact.createElement(
                "TextLabel",
                {
                    Size = size,
                    Text = str1,
                    TextColor3 = Constants.Color.Text,
                    BackgroundTransparency = 1
                }
            )
        end
    end

    tbl5.UIListLayout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local createElement = Roact.createElement

    local tbl6 = {
        Header = constructHeader(arg1.onSortChanged),
        Entries = Roact.createElement("ScrollingFrame", {
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight),
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            BackgroundTransparency = 1,
            VerticalScrollBarInset = 1,
            ScrollBarThickness = 5,
            CanvasSize = UDim2.new(1, 0, 0, yOffset),
            [Roact.Ref] = arg1.scrollingRef
        }, tbl5)
    }
    return createElement("Frame", { Size = size, BackgroundTransparency = 1, LayoutOrder = layoutOrder }, tbl6)
end

return DataConsumer(var1, "ServerScriptsData")

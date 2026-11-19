-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)

local ChartHeaderNames = Constants.NetworkFormatting.ChartHeaderNames
local ChartCellWidths = Constants.NetworkFormatting.ChartCellWidths
local CellPadding = Constants.NetworkFormatting.CellPadding
local HeaderFrameHeight = Constants.NetworkFormatting.HeaderFrameHeight
local EntryFrameHeight = Constants.NetworkFormatting.EntryFrameHeight
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local MainWindow = Constants.DefaultFontSize.MainWindow
local MainWindow2 = Constants.Font.MainWindow
local ResponseStrHeight = Constants.NetworkFormatting.ResponseStrHeight
local ResponseWidthRatio = Constants.NetworkFormatting.ResponseWidthRatio

local Components = script.Parent.Parent.Parent.Components
local HeaderButton = require(Components.HeaderButton)
local NetworkChartEntry = require(script.Parent.NetworkChartEntry)

local num1 = 0
for _, ChartCellWidth in pairs(ChartCellWidths) do
    num1 += ChartCellWidth
end

local num2 = 0
local cellOffset = {}
local tbl2 = {}
local entryCellSize = {}

for _, ChartCellWidth in ipairs(ChartCellWidths) do
    table.insert(cellOffset, UDim2.new(0, num2 + CellPadding, 0, 0))
    table.insert(tbl2, UDim2.new(0, ChartCellWidth - CellPadding, 0, HeaderFrameHeight))
    table.insert(entryCellSize, UDim2.new(0, ChartCellWidth - CellPadding, 0, EntryFrameHeight))
    num2 += ChartCellWidth
end

table.insert(cellOffset, UDim2.new(0, num2 + CellPadding, 0, 0))
table.insert(tbl2, UDim2.new(1, -num1 - CellPadding, 0, HeaderFrameHeight))
table.insert(entryCellSize, UDim2.new(1, -num1 - CellPadding, 0, EntryFrameHeight))

local verticalOffsets = ({})
for i, value in ipairs(cellOffset) do
    verticalOffsets[i] = UDim2.new(value.X.Scale, value.X.Offset - CellPadding, value.Y.Scale, value.Y.Offset)
end

local var1 = Roact.Component:extend("NetworkChart")

function var1.init(arg1)
    function arg1.getOnExpandEntry(expandIndex)
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

    arg1.ref = Roact.createRef()
    arg1.scrollingRef = Roact.createRef()

    arg1.state = { expandIndex = false }
end

function var1.willUpdate(arg1)
    if arg1.canvasPosConnector then
        arg1.canvasPosConnector:Disconnect()
    end
end

function var1.didUpdate(arg1)
    if not arg1.scrollingRef.current then
        return
    end

    arg1.canvasPosConnector = arg1.scrollingRef.current:GetPropertyChangedSignal("CanvasPosition"):Connect(arg1.onCanvasPosChanged)

    local absoluteSize = arg1.scrollingRef.current.AbsoluteSize
    if arg1.state.absScrollSize ~= absoluteSize then
        arg1:setState({ absScrollSize = absoluteSize })
    end
end

function var1.didMount(arg1)
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

function var1.render(arg1)
    local httpEntryList = arg1.props.httpEntryList or {}
    local chartHeight = arg1.props.chartHeight
    local width = arg1.props.width
    local searchTerm = arg1.props.searchTerm
    local layoutOrder = arg1.props.layoutOrder
    local reverseSort = arg1.props.reverseSort

    local onSortChanged = arg1.props.onSortChanged

    local expandIndex = arg1.state.expandIndex
    local absScrollSize = arg1.state.absScrollSize
    local canvasPos = arg1.state.canvasPos

    local tbl5 = ({})
    for i, text in ipairs(ChartHeaderNames) do
        local createElement = Roact.createElement
        local var2 = HeaderButton
        local tbl6 = {
            text = text,
            size = tbl2[i],
            pos = cellOffset[i],
            sortfunction = onSortChanged
        }
        tbl5[text] = createElement(var2, tbl6)
    end

    for i = 2, #verticalOffsets do
        local str1 = string.format("VerticalLine_%d", i)
        tbl5[str1] = Roact.createElement("Frame", {
            Size = UDim2.new(0, LineWidth, 0, HeaderFrameHeight),
            Position = verticalOffsets[i],
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    end

    local tbl6 = ({})
    local yOffset = 0
    local yOffset2 = -1
    local num3 = 0

    local httpEntryListLen = #httpEntryList
    local num4 = 0
    tbl6.UIListLayout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    if canvasPos and absScrollSize then
        for i, entry in ipairs(httpEntryList) do
            local bool1 = searchTerm == ""
                or string.find(entry.RequestType:lower(), searchTerm:lower()) ~= nil
                or string.find(entry.Url:lower(), searchTerm:lower()) ~= nil

            if entry.RequestType == "Default" or not bool1 then
                continue
            end

            num4 += 1

            local showResponse = expandIndex == entry.Num
            local yOffset3 = EntryFrameHeight
            local num5 = 0

            if showResponse then
                yOffset3 += ResponseStrHeight
                if arg1.ref.current then
                    local vector2 = Vector2.new(arg1.ref.current.AbsoluteSize.X * ResponseWidthRatio, 100000000)
                    local vector2_2 = TextService:GetTextSize(entry.Response, MainWindow, MainWindow2, vector2)

                    num5 = ResponseStrHeight + vector2_2.Y
                    yOffset3 += num5
                end
            end

            if yOffset + yOffset3 >= canvasPos.Y then
                if num3 < absScrollSize.Y then
                    local var2 = if reverseSort then httpEntryListLen - i or i else i
                    local createElement = Roact.createElement
                    local var3 = NetworkChartEntry
                    local tbl7 = {
                        size = UDim2.new(1, 0, 0, yOffset3),
                        entry = entry,
                        entryCellSize = entryCellSize,
                        cellOffset = cellOffset,
                        verticalOffsets = verticalOffsets,
                        showResponse = showResponse,
                        responseBodyHeight = num5,
                        layoutOrder = var2 + 1,
                        onButtonPress = arg1.getOnExpandEntry(entry.Num)
                    }
                    tbl6[i] = createElement(var3, tbl7)
                end

                if yOffset2 < 0 then
                    yOffset2 = yOffset
                else
                    num3 += yOffset3
                end
            end
            yOffset += yOffset3
        end

        if num4 > 0 then
            tbl6.WindowingPadding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset2), BackgroundTransparency = 1, LayoutOrder = 1 })
        end
    end

    if httpEntryListLen == 0 or num4 == 0 then
        tbl6["NONE FOUND"] = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, chartHeight),
            Text = "No Network Entries Found",
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1
        })
    end

    local createElement = Roact.createElement
    local tbl7 = {
        Size = UDim2.new(1, 0, 0, chartHeight),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        LayoutOrder = layoutOrder,
        [Roact.Ref] = arg1.ref
    }
    local tbl8 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Header = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, HeaderFrameHeight),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            tbl5
        ),
        HorizontalLine_1 = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, LineWidth),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0,
            BackgroundTransparency = 0,
            LayoutOrder = 2
        }),
        scrollingFrameEntries = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            CanvasSize = UDim2.new(0, width, 0, yOffset),
            ScrollBarThickness = 6,
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            [Roact.Ref] = arg1.scrollingRef
        }, tbl6)
    }
    return createElement("Frame", tbl7, tbl8)
end

return var1

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local HeaderButton = require(Components.HeaderButton)
local CellLabel = require(Components.CellLabel)

local Constants = require(script.Parent.Parent.Parent.Constants)
local GeneralFormatting = Constants.GeneralFormatting
local LineWidth = GeneralFormatting.LineWidth
local LineColor = GeneralFormatting.LineColor

local ActionBindingsFormatting = Constants.ActionBindingsFormatting
local ChartHeaderNames = ActionBindingsFormatting.ChartHeaderNames
local ChartCellWidths = ActionBindingsFormatting.ChartCellWidths
local HeaderFrameHeight = ActionBindingsFormatting.HeaderFrameHeight
local EntryFrameHeight = ActionBindingsFormatting.EntryFrameHeight
local CellPadding = ActionBindingsFormatting.CellPadding
local MinFrameWidth = ActionBindingsFormatting.MinFrameWidth

local num1 = 0
for _, ChartCellWidth in ipairs(ChartCellWidths) do
    num1 += ChartCellWidth
end

local tbl1 = {}
local tbl2 = {}
local tbl3 = {}
local var1 = -num1 / 2
table.insert(tbl1, UDim2.new(0, CellPadding, 0, 0))
table.insert(tbl2, UDim2.new(0.5, var1 - CellPadding, 0, HeaderFrameHeight))
table.insert(tbl3, UDim2.new(0.5, var1 - CellPadding, 0, EntryFrameHeight))

for _, ChartCellWidth in ipairs(ChartCellWidths) do
    table.insert(tbl1, UDim2.new(0.5, var1 + CellPadding, 0, 0))
    table.insert(tbl2, UDim2.new(0, ChartCellWidth - CellPadding, 0, HeaderFrameHeight))
    table.insert(tbl3, UDim2.new(0, ChartCellWidth - CellPadding, 0, EntryFrameHeight))
    var1 += ChartCellWidth
end

table.insert(tbl1, UDim2.new(0.5, var1 + CellPadding, 0, 0))
table.insert(tbl2, UDim2.new(0.5, -num1 / 2 - CellPadding, 0, HeaderFrameHeight))
table.insert(tbl3, UDim2.new(0.5, -num1 / 2 - CellPadding, 0, EntryFrameHeight))

local tbl4 = ({})
for i, value in ipairs(tbl1) do
    tbl4[i] = UDim2.new(value.X.Scale, value.X.Offset - CellPadding, value.Y.Scale, value.Y.Offset)
end

local var2 = Roact.Component:extend("ActionBindingsChart")

local function constructHeader(sortfunction, xOffset: number?)
    local tbl5 = ({})

    for i, text in ipairs(ChartHeaderNames) do
        local createElement = Roact.createElement
        local var3 = HeaderButton
        local tbl6 = {
            text = text,
            size = tbl2[i],
            pos = tbl1[i],
            sortfunction = sortfunction
        }
        tbl5[text] = createElement(var3, tbl6)
    end

    tbl5.upperHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    tbl5.lowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, -LineWidth),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    for i = 2, #tbl4 do
        local str1 = string.format("VerticalLine_%d", i)
        tbl5[str1] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = tbl4[i],
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }
        )
    end

    return Roact.createElement("Frame", { Size = UDim2.new(0, xOffset, 0, HeaderFrameHeight), BackgroundTransparency = 1 }, tbl5)
end

local function constructEntry(arg1, xOffset: number?, layoutOrder)
    local name = arg1.name
    local actionInfo = arg1.actionInfo

    local text = tostring(actionInfo.inputTypes[1])

    local str1 = if actionInfo.isCore then "Core" else "Developer"

    local tbl5 = {}
    for i = 2, #tbl4 do
        local str3 = string.format("line_%d", i)
        tbl5[str3] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = tbl4[i],
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }
        )
    end

    tbl5[name] = Roact.createElement(CellLabel, { text = text, size = tbl3[1], pos = tbl1[1] })

    tbl5.priorityLevel = Roact.createElement(CellLabel, { text = actionInfo.priorityLevel, size = tbl3[2], pos = tbl1[2] })

    tbl5.isCore = Roact.createElement(CellLabel, { text = str1, size = tbl3[3], pos = tbl1[3] })

    tbl5.actionName = Roact.createElement(CellLabel, { text = name, size = tbl3[4], pos = tbl1[4] })

    tbl5.inputTypes = Roact.createElement(CellLabel, { text = text, size = tbl3[5], pos = tbl1[5] })

    tbl5.lowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(0, xOffset, 0, EntryFrameHeight),
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        },
        tbl5
    )
end

function var2.init(arg1, arg2)
    local actionBindingEntries = arg2.ActionBindingsData:getCurrentData()

    function arg1.onSortChanged(arg3)
        if arg3 == arg2.ActionBindingsData:getSortType() then
            arg1:setState({ reverseSort = not arg1.state.reverseSort })
            return
        end

        arg2.ActionBindingsData:setSortType(arg3)
        arg1:setState({ reverseSort = false })
    end

    function arg1.onCanvasPosChanged()
        local canvasPosition = arg1.scrollingRef.current.CanvasPosition
        if arg1.state.canvasPos ~= canvasPosition then
            arg1:setState({ canvasPos = canvasPosition })
        end
    end

    arg1.scrollingRef = Roact.createRef()

    arg1.state = { actionBindingEntries = actionBindingEntries, reverseSort = false }
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
    arg1.bindingsUpdated = arg1.props.ActionBindingsData:Signal():Connect(function(actionBindingEntries)
        arg1:setState({ actionBindingEntries = actionBindingEntries })
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
    arg1.bindingsUpdated:Disconnect()
    arg1.bindingsUpdated = nil
    arg1.canvasPosConnector:Disconnect()
    arg1.canvasPosConnector = nil
end

function var2.render(arg1)
    local tbl5 = ({})
    local searchTerm = arg1.props.searchTerm
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder

    local actionBindingEntries = arg1.state.actionBindingEntries
    local reverseSort = arg1.state.reverseSort

    local canvasPos = arg1.state.canvasPos
    local absScrollSize = arg1.state.absScrollSize
    local xOffset = absScrollSize and math.max(absScrollSize.X, MinFrameWidth) or MinFrameWidth

    tbl5.UIListLayout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local actionBindingEntriesLen = #actionBindingEntries
    local yOffset = 0

    if absScrollSize and canvasPos then
        local yOffset2 = -1
        local num2 = 0
        local num3 = 0

        for i, value in ipairs(actionBindingEntries) do
            local bool1

            if searchTerm then
                local str1 = tostring(value.actionInfo.inputTypes[1])
                bool1 = string.find(str1:lower(), searchTerm:lower()) ~= nil or string.find(value.name:lower(), searchTerm:lower()) ~= nil
            else
                bool1 = false
            end

            if searchTerm and not bool1 then
                continue
            end

            if yOffset + EntryFrameHeight >= canvasPos.Y then
                if num2 < absScrollSize.Y then
                    local var3 = if reverseSort then actionBindingEntriesLen - i or i else i
                    tbl5[i] = constructEntry(value, xOffset, var3 + 1)
                end
                if yOffset2 < 0 then
                    yOffset2 = yOffset
                else
                    num2 += EntryFrameHeight
                end
                num3 += 1
            end

            yOffset += EntryFrameHeight
        end

        if num3 == 0 then
            tbl5.NoneFound = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Text = "No ActionBindings Found",
                TextColor3 = LineColor,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            })
        else
            tbl5.WindowingPadding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset2), BackgroundTransparency = 1, LayoutOrder = 1 })
        end
    end

    local createElement = Roact.createElement

    local tbl6 = {
        Header = constructHeader(arg1.onSortChanged, xOffset),
        MainChart = Roact.createElement("ScrollingFrame", {
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight),
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            CanvasSize = UDim2.new(0, xOffset, 0, yOffset),
            ScrollBarThickness = 6,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            [Roact.Ref] = arg1.scrollingRef
        }, tbl5)
    }
    return createElement(
        "Frame",
        {
            Size = size,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = layoutOrder
        },
        tbl6
    )
end

return DataConsumer(var2, "ActionBindingsData")

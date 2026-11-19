-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagDevConsoleKeyCollisionFix = require(script.Parent.Flags.FFlagDevConsoleKeyCollisionFix)

local CorePackages = game:GetService("CorePackages")
local TweenService = game:GetService("TweenService")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local HeaderButton = require(Components.HeaderButton)
local MemoryViewEntry = require(script.Parent.MemoryViewEntry)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local ChartHeaderNames = Constants.MemoryFormatting.ChartHeaderNames
local HeaderFrameHeight = Constants.GeneralFormatting.HeaderFrameHeight
local ValueCellWidth = Constants.MemoryFormatting.ValueCellWidth
local CellPadding = Constants.MemoryFormatting.CellPadding
local ValuePadding = Constants.MemoryFormatting.ValuePadding

local EntryFrameHeight = Constants.GeneralFormatting.EntryFrameHeight
local LineGraphHeight = Constants.GeneralFormatting.LineGraphHeight

local NoResultSearchStr = Constants.GeneralFormatting.NoResultSearchStr

local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0)

local var1 = Roact.Component:extend("MemoryView")

local function getX(arg1)
    return arg1.time
end

local function getY(arg1)
    return arg1.data
end

local function formatValueStr(arg1): string
    return string.format("%.3f", arg1)
end

function var1.init(arg1, arg2)
    function arg1.getOnButtonPress(expandIndex, arg3)
        return function(_, _)
            if arg1.state.expandIndex ~= expandIndex and expandIndex then
                local current = arg1.scrollingRef.current

                if current then
                    local y = (arg3 - 2.4) * EntryFrameHeight
                    TweenService:Create(current, tweenInfo, { CanvasPosition = Vector2.new(0, y) }):Play()
                end
            end

            arg1:setState({ expandIndex = not (arg1.state.expandIndex == expandIndex) and expandIndex })
        end
    end

    function arg1.onSortChanged(arg3)
        if arg3 == arg2.targetMemoryData:getSortType() then
            arg2.targetMemoryData:setSortType(arg3)
            arg1:setState({ reverseSort = not arg1.state.reverseSort })
            return
        end

        arg2.targetMemoryData:setSortType(arg3)
        arg1:setState({ reverseSort = false })
    end

    function arg1.onCanvasPosChanged()
        local canvasPosition = arg1.scrollingRef.current.CanvasPosition
        if arg1.state.canvasPos ~= canvasPosition then
            arg1:setState({ absScrollSize = arg1.scrollingRef.current.AbsoluteSize, canvasPos = canvasPosition })
        end
    end

    arg1.scrollingRef = Roact.createRef()

    arg1.state = {
        memoryData = arg2.targetMemoryData:getMemoryData(),
        reverseSort = false,
        expandIndex = false
    }
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
    arg1.treeViewItemConnector = arg1.props.targetMemoryData:treeUpdatedSignal():Connect(function(memoryData)
        arg1:setState({ memoryData = memoryData })
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
    arg1.treeViewItemConnector:Disconnect()
end

function var1.appendAdditionTabInformation(arg1, arg2, arg3, arg4, depth, arg5)
    local canvasPosition = arg1.scrollingRef.current.CanvasPosition
    local absoluteSize = arg1.scrollingRef.current.AbsoluteSize

    for i, value in ipairs(arg3) do
        local name = value.name
        local value2 = value.value
        local var2 = arg4 .. name
        if FFlagDevConsoleKeyCollisionFix then
            if value.id then
                var2 = `{arg4}_{value.id}`
            else
                var2 = `{arg4}_{name}_{i}`
            end
        end

        arg5.layoutOrder += 1

        if arg5.scrollingFrameHeight + EntryFrameHeight >= canvasPosition.Y and arg5.usedFrameSpace < absoluteSize.Y then
            if not FFlagDevConsoleKeyCollisionFix then
                var2 = arg4 .. name
            end

            local createElement = Roact.createElement
            local var3 = MemoryViewEntry
            local tbl1 = {
                size = UDim2.new(1, 0, 0, EntryFrameHeight),
                depth = depth,
                name = name,
                showGraph = false,
                value = value2,
                formatValueStr = formatValueStr,
                layoutOrder = arg5.layoutOrder
            }
            arg2[var2] = createElement(var3, tbl1)

            if arg5.paddingHeight < 0 then
                arg5.paddingHeight = arg5.scrollingFrameHeight
            else
                arg5.usedFrameSpace += EntryFrameHeight
            end
        end

        arg5.scrollingFrameHeight += EntryFrameHeight

        if value.moreInfo and type(value.moreInfo) == "table" then
            arg1:appendAdditionTabInformation(arg2, value.moreInfo, var2, depth + 1, arg5)
        end
    end
end

function var1.recursiveConstructEntries(arg1, arg2, arg3, depth, arg4, arg5)
    assert(arg1.scrollingRef.current, "ScrollingFrame not initialized yet")

    local expandIndex = arg1.state.expandIndex
    local searchTerm = arg1.props.searchTerm or ""
    local reverseSort = arg1.state.reverseSort
    local canvasPosition = arg1.scrollingRef.current.CanvasPosition
    local absoluteSize = arg1.scrollingRef.current.AbsoluteSize

    local name = arg3.name
    local var2 = if arg5 then `{arg5}/{name}` else name

    if string.find(name:lower(), searchTerm:lower()) then
        if FFlagDevConsoleKeyCollisionFix then
            name = var2
        end
        local showGraph = expandIndex == name
        local yOffset = showGraph and EntryFrameHeight + LineGraphHeight or EntryFrameHeight
        arg4.layoutOrder += 1

        if arg4.scrollingFrameHeight + yOffset >= canvasPosition.Y and arg4.usedFrameSpace < absoluteSize.Y then
            arg2[name] = Roact.createElement(MemoryViewEntry, {
                size = UDim2.new(1, 0, 0, yOffset),
                depth = depth,
                name = arg3.name,
                showGraph = showGraph,
                dataStats = arg3.dataStats,
                onButtonPress = arg1.getOnButtonPress(name, arg4.layoutOrder),
                formatValueStr = formatValueStr,
                getX = getX,
                getY = getY,
                layoutOrder = arg4.layoutOrder
            })
            if arg4.paddingHeight < 0 then
                arg4.paddingHeight = arg4.scrollingFrameHeight
            else
                arg4.usedFrameSpace += yOffset
            end
        end

        arg4.scrollingFrameHeight += yOffset

        if showGraph and arg3.dataStats.additionalInfoFunc then
            arg1:appendAdditionTabInformation(arg2, arg3.dataStats.additionalInfoFunc(), name, depth + 1, arg4)
        end
    end

    local sortedChildren = arg3.dataStats.sortedChildren
    if not sortedChildren then
        return
    end

    if reverseSort then
        local sortedChildrenLen = #sortedChildren
        for i = 1, sortedChildrenLen do
            arg1:recursiveConstructEntries(arg2, sortedChildren[sortedChildrenLen - i + 1], depth + 1, arg4, var2)
        end

        return
    end

    for _, sortedChild in ipairs(sortedChildren) do
        arg1:recursiveConstructEntries(arg2, sortedChild, depth + 1, arg4, var2)
    end
end

function var1.render(arg1)
    local tbl1 = ({})
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size
    local searchTerm = arg1.props.searchTerm or ""

    local tbl2 = {
        scrollingFrameHeight = 0,
        paddingHeight = -1,
        usedFrameSpace = 0,
        layoutOrder = 1
    }

    if arg1.scrollingRef.current then
        for _, value in ipairs(arg1.state.memoryData) do
            arg1:recursiveConstructEntries(tbl1, value, 0, tbl2)
        end

        tbl1.UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        tbl1.WindowingPadding = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, tbl2.paddingHeight),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            }
        )
    end

    if tbl2.layoutOrder == 1 then
        if searchTerm == "" then
            tbl1.noDataMessage = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Text = "Awaiting Memory Stats",
                TextColor3 = Constants.Color.Text,
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder
            })
        else
            local str1 = string.format(NoResultSearchStr, searchTerm)

            tbl1.noDataMessage = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Text = str1,
                TextColor3 = Constants.Color.Text,
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder
            })
        end
    end

    local createElement = Roact.createElement

    local tbl3 = {
        Header = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, HeaderFrameHeight),
            BackgroundTransparency = 1
        }, {
            Name = Roact.createElement(HeaderButton, {
                text = ChartHeaderNames[1],
                size = UDim2.new(1 - ValueCellWidth, -ValuePadding - CellPadding, 0, HeaderFrameHeight),
                pos = UDim2.new(0, CellPadding, 0, 0),
                sortfunction = arg1.onSortChanged
            }),
            ValueMB = Roact.createElement(HeaderButton, {
                text = ChartHeaderNames[2],
                size = UDim2.new(ValueCellWidth, -CellPadding, 0, HeaderFrameHeight),
                pos = UDim2.new(1 - ValueCellWidth, ValuePadding, 0, 0),
                sortfunction = arg1.onSortChanged
            }),
            TopHorizontal = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = LineColor, BorderSizePixel = 0 }),
            LowerHorizontal = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, LineWidth),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }),
            vertical = Roact.createElement("Frame", {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = UDim2.new(1 - ValueCellWidth, 0, 0, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })
        }),
        Entries = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight),
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight),
            BackgroundTransparency = 1,
            VerticalScrollBarInset = 1,
            ScrollBarThickness = 5,
            CanvasSize = UDim2.new(1, 0, 0, tbl2.scrollingFrameHeight),
            [Roact.Ref] = arg1.scrollingRef
        }, tbl1)
    }
    return createElement("Frame", { Size = size, BackgroundTransparency = 1, LayoutOrder = layoutOrder }, tbl3)
end

return var1

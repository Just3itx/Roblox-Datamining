-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local ProfilerUtil = require(script.Parent.ProfilerUtil)

local getDurations = ProfilerUtil.getDurations
local formatSessionLength = ProfilerUtil.formatSessionLength

local _ProfilerDataFormatV2 = require(script.Parent.ProfilerDataFormatV2)

local Components = script.Parent.Parent.Parent.Components
local HeaderButton = require(Components.HeaderButton)
local ProfilerViewEntry = require(script.Parent.ProfilerViewEntry)

local Constants = require(script.Parent.Parent.Parent.Constants)

local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local HeaderFrameHeight = Constants.GeneralFormatting.HeaderFrameHeight
local _EntryFrameHeight = Constants.GeneralFormatting.EntryFrameHeight
local _NoResultSearchStr = Constants.GeneralFormatting.NoResultSearchStr
local HeaderNames = Constants.ScriptProfilerFormatting.HeaderNames
local ValueCellWidth = Constants.ScriptProfilerFormatting.ValueCellWidth
local CellPadding = Constants.ScriptProfilerFormatting.CellPadding
local ValuePadding = Constants.ScriptProfilerFormatting.ValuePadding

local var1 = Roact.PureComponent:extend("ProfilerView")

function var1.renderChildren(arg1)
    local data = arg1.props.data
    assert(data.Version == 2)

    local durations = getDurations(data, 0)

    local average = if arg1.props.average > 0 and arg1.props.sessionLength then arg1.props.sessionLength / 1000 / arg1.props.average else 1

    return Roact.createElement(ProfilerViewEntry, {
        layoutOrder = 0,
        depth = 0,
        data = data,
        nodeId = arg1.props.rootNode,
        functionId = arg1.props.rootFunc,
        nodeName = arg1.props.rootNodeName,
        average = average,
        searchTerm = arg1.props.searchTerm,
        searchFilter = arg1.props.searchFilter,
        showPlugins = arg1.props.showPlugins,
        pluginOffsets = arg1.props.pluginOffsets,
        showGC = arg1.props.showGC,
        gcNodeOffsets = arg1.props.gcNodeOffsets,
        pluginGCOffsets = arg1.props.pluginGCOffsets,
        expandedNodes = arg1.props.expandedNodes,
        percentageRatio = if arg1.props.showAsPercentages then durations / 100 else nil
    })
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local size = arg1.props.size
    local element = nil

    if arg1.props.profiling and not arg1.props.data then
        element = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Press Stop to Finish Profiling",
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        })
    elseif not arg1.props.data then
        element = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Start Profiling to View Data",
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        })
    end

    local var2 = formatSessionLength(arg1.props.sessionLength)

    local text = var2 and "Session Duration: " .. var2

    return Roact.createElement("Frame", {
        Size = size,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        SessionInfo = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, HeaderFrameHeight),
                BackgroundTransparency = 1
            },
            {
                Name = Roact.createElement(HeaderButton, {
                    text = text or "Session Info",
                    size = UDim2.new(1 - ValueCellWidth * 2, -ValuePadding - CellPadding, 0, HeaderFrameHeight),
                    pos = UDim2.new(0, CellPadding, 0, 0)
                }),
                TopHorizontal = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = LineColor, BorderSizePixel = 0 })
            }
        ),
        Header = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, HeaderFrameHeight),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight)
        }, {
            Name = Roact.createElement(HeaderButton, {
                text = HeaderNames[1],
                size = UDim2.new(1 - ValueCellWidth * 2, -ValuePadding - CellPadding, 0, HeaderFrameHeight),
                pos = UDim2.new(0, CellPadding, 0, 0),
                sortfunction = arg1.onSortChanged
            }),
            Inclusive = Roact.createElement(HeaderButton, {
                text = HeaderNames[2],
                size = UDim2.new(ValueCellWidth, -CellPadding, 0, HeaderFrameHeight),
                pos = UDim2.new(1 - ValueCellWidth * 2, ValuePadding, 0, 0),
                sortfunction = arg1.onSortChanged
            }),
            Self = Roact.createElement(HeaderButton, {
                text = HeaderNames[3],
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
            Vertical1 = Roact.createElement("Frame", {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = UDim2.new(1 - ValueCellWidth, 0, 0, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            }),
            Vertical2 = Roact.createElement("Frame", {
                Size = UDim2.new(0, LineWidth, 1, 0),
                Position = UDim2.new(1 - ValueCellWidth * 2, 0, 0, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })
        }),
        Entries = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, -HeaderFrameHeight * 2),
            Position = UDim2.new(0, 0, 0, HeaderFrameHeight * 2),
            BackgroundTransparency = 1,
            VerticalScrollBarInset = Enum.ScrollBarInset.None,
            ScrollBarThickness = 5,
            CanvasSize = UDim2.fromScale(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, {
            Layout = Roact.createElement("UIListLayout", { FillDirection = Enum.FillDirection.Vertical }),
            Children = element or Roact.createFragment(arg1:renderChildren())
        })
    })
end

return var1

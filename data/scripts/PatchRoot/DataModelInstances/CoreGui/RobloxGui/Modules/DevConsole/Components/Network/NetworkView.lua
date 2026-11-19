-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)
local HeaderFrameHeight = Constants.NetworkFormatting.HeaderFrameHeight
local EntryFrameHeight = Constants.NetworkFormatting.EntryFrameHeight
local SummaryButtonHeight = Constants.NetworkFormatting.SummaryButtonHeight
local MinFrameWidth = Constants.NetworkFormatting.MinFrameWidth

local MainWindow = Constants.DefaultFontSize.MainWindow
local MainWindowHeader = Constants.Font.MainWindowHeader

local Components = script.Parent.Parent.Parent.Components
local BannerButton = require(Components.BannerButton)
local NetworkSummary = require(Components.Network.NetworkSummary)
local NetworkChart = require(Components.Network.NetworkChart)

local var1 = Roact.Component:extend("NetworkView")

function var1.init(arg1, arg2)
    assert(arg2.targetNetworkData, "Make sure the NetworkData is assigned for this NetworkView")

    local currentData = arg2.targetNetworkData:getCurrentData()

    function arg1.onSortChanged(arg3)
        if arg3 == arg2.targetNetworkData:getSortType() then
            arg1:setState({ reverseSort = not arg1.state.reverseSort })
            return
        end

        arg2.targetNetworkData:setSortType(arg3)
        arg1:setState({ reverseSort = false })
    end

    function arg1.onSummaryButton(_, _)
        arg1:setState({ summaryExpanded = not arg1.state.summaryExpanded })
    end

    function arg1.onDetailButton(_, _)
        arg1:setState({ entriesExpanded = not arg1.state.entriesExpanded })
    end

    arg1.ref = Roact.createRef()

    arg1.state = {
        httpSummaryTable = currentData.summaryTable,
        httpSummaryCount = currentData.summaryCount,
        httpEntryList = currentData.entryList,
        summaryExpanded = true,
        entriesExpanded = true,
        indexOfEntryExpanded = 0,
        reverseSort = false,
        absWidth = 0
    }
end

function var1.didUpdate(arg1)
    if arg1.ref.current and arg1.state.absWidth ~= arg1.ref.current.AbsoluteSize.X then
        arg1:setState({ absWidth = arg1.ref.current.AbsoluteSize.X })
    end
end

function var1.didMount(arg1)
    arg1.httpEntryAddedConnector = arg1.props.targetNetworkData:Signal():Connect(function(httpSummaryTable, httpSummaryCount, httpEntryList)
        arg1:setState(
            {
                httpSummaryTable = httpSummaryTable,
                httpSummaryCount = httpSummaryCount,
                httpEntryList = httpEntryList
            }
        )
    end)
    if arg1.ref.current then
        arg1:setState({ absWidth = arg1.ref.current.AbsoluteSize.X })
    end
end

function var1.willUnmount(arg1)
    arg1.httpEntryAddedConnector:Disconnect()
    arg1.httpEntryAddedConnector = nil
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local searchTerm = arg1.props.searchTerm
    local size = arg1.props.size

    local summaryExpanded = arg1.state.summaryExpanded
    local entriesExpanded = arg1.state.entriesExpanded
    local reverseSort = arg1.state.reverseSort
    local httpSummaryTable = arg1.state.httpSummaryTable
    local httpEntryList = arg1.state.httpEntryList
    local httpSummaryCount = arg1.state.httpSummaryCount

    local width = math.max(MinFrameWidth, arg1.state.absWidth)

    local var2 = SummaryButtonHeight * 2
    if summaryExpanded then
        var2 = var2 + httpSummaryCount * EntryFrameHeight + HeaderFrameHeight
    end

    local chartHeight = math.max(0, if arg1.ref.current then arg1.ref.current.AbsoluteSize.Y - var2 else size.Y.Offset - var2)

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = layoutOrder,
            [Roact.Ref] = arg1.ref
        },
        {
            UIListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            SummaryButton = Roact.createElement(BannerButton, {
                size = UDim2.new(1, 0, 0, SummaryButtonHeight),
                pos = UDim2.new(),
                isExpanded = summaryExpanded,
                onButtonPress = arg1.onSummaryButton,
                layoutOrder = 1
            }, {
                Text = Roact.createElement("TextLabel", {
                    Text = "Summary",
                    TextColor3 = Constants.Color.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = MainWindow,
                    Font = MainWindowHeader,
                    Size = UDim2.new(1, -30, 0, SummaryButtonHeight),
                    Position = UDim2.new(0, 30, 0, 0),
                    BackgroundTransparency = 1
                })
            }),
            Summary = summaryExpanded
                and Roact.createElement(NetworkSummary, { width = width, httpSummaryTable = httpSummaryTable, layoutOrder = 2 }),
            DetailsButton = Roact.createElement(BannerButton, {
                size = UDim2.new(1, 0, 0, SummaryButtonHeight),
                pos = UDim2.new(),
                isExpanded = entriesExpanded,
                onButtonPress = arg1.onDetailButton,
                layoutOrder = 3
            }, {
                Text = Roact.createElement("TextLabel", {
                    Text = "Details",
                    TextColor3 = Constants.Color.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = MainWindow,
                    Font = MainWindowHeader,
                    Size = UDim2.new(1, -30, 0, SummaryButtonHeight),
                    Position = UDim2.new(0, 30, 0, 0),
                    BackgroundTransparency = 1
                })
            }),
            Entries = entriesExpanded
                and Roact.createElement(NetworkChart, {
                    httpEntryList = httpEntryList,
                    chartHeight = chartHeight,
                    width = width,
                    searchTerm = searchTerm,
                    reverseSort = reverseSort,
                    layoutOrder = 4,
                    onSortChanged = arg1.onSortChanged
                })
        }
    )
end
return var1

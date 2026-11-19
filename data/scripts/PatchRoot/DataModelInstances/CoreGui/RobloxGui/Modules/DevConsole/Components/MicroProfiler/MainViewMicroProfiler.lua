-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _LogService = game:GetService("LogService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GameSettings = UserSettings().GameSettings

local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local UtilAndTab = require(Components.UtilAndTab)
local ServerProfilerInterface = require(script.Parent.ServerProfilerInterface)
local MicroProfilerView = require(script.Parent.MicroProfilerView)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding
local ButtonWidth = Constants.MicroProfilerFormatting.ButtonWidth
local ButtonTextSize = Constants.MicroProfilerFormatting.ButtonTextSize
local _MainWindow = Constants.Font.MainWindow
local MainWindowHeader = Constants.Font.MainWindowHeader
local UnselectedGray = Constants.Color.UnselectedGray
local SelectedBlue = Constants.Color.SelectedBlue

local UnselectedGray2 = Constants.Color.UnselectedGray

local FFlagDevConsoleMicroProfilerImproveWording = require(script.Parent.Flags.FFlagDevConsoleMicroProfilerImproveWording)
local bool1 = game:DefineFastFlag("DevConsoleMicroProfilerNewLayout", false)

local var1 = Roact.Component:extend("MainViewProfiler")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.changeProfilerState(arg2)
        return function()
            GameSettings.OnScreenProfilerEnabled = arg2
            arg1:setState({ clientProfilerEnabled = arg2 })

            RbxAnalyticsService:ReportCounter("MicroprofilerDevConsolePressed")
        end
    end

    arg1.microProfilerChangedConnection = GameSettings:GetPropertyChangedSignal("OnScreenProfilerEnabled"):Connect(function()
        arg1:setState({ clientProfilerEnabled = GameSettings.OnScreenProfilerEnabled })
    end)

    arg1.utilRef = Roact.createRef()

    arg1.state = { utilTabHeight = 0 }
end

function var1.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })
end

function var1.willUnmount(arg1)
    if arg1.microProfilerChangedConnection then
        arg1.microProfilerChangedConnection:Disconnect()
        arg1.microProfilerChangedConnection = nil
    end
end

function var1.didUpdate(arg1)
    local currentSize = arg1.utilRef.current.Size
    if currentSize.Y.Offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = currentSize.Y.Offset })
    end
end

function var1.renderNewLayout(arg1)
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList
    local utilTabHeight = arg1.state.utilTabHeight

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        },
        {
            UIListLayout = Roact.createElement("UIListLayout", { Padding = UDim.new(0, MainRowPadding), SortOrder = Enum.SortOrder.LayoutOrder }),
            UtilAndTab = Roact.createElement(UtilAndTab, {
                windowWidth = size.X.Offset,
                formFactor = formFactor,
                tabList = tabList,
                layoutOrder = 1,
                refForParent = arg1.utilRef,
                onHeightChanged = arg1.onUtilTabHeightChanged
            }),
            MicroProfilerView = Roact.createElement(
                MicroProfilerView,
                {
                    Size = UDim2.new(1, 0, 1, -utilTabHeight),
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                }
            )
        }
    )
end

function var1.render(arg1)
    if bool1 then
        return arg1:renderNewLayout()
    end

    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList

    local utilTabHeight = arg1.state.utilTabHeight

    local _frameRate = arg1.state.frameRate
    local _timeFrame = arg1.state.timeFrame
    local _waitingForData = arg1.state.waitingForData
    local clientProfilerEnabled = arg1.state.clientProfilerEnabled
    local _outputPath = arg1.state.outputPath

    local _uDim2 = UDim2.new(0.8, -ButtonWidth, 0, 30)
    local _uDim2_2 = UDim2.new(0.6, ButtonWidth, 0, 0)

    local createElement = Roact.createElement
    local tbl1 = {
        Size = size,
        BackgroundColor3 = Constants.Color.BaseGray,
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }

    local tbl2 = {
        UIListLayout = Roact.createElement("UIListLayout", { Padding = UDim.new(0, MainRowPadding), SortOrder = Enum.SortOrder.LayoutOrder }),
        UtilAndTab = Roact.createElement(UtilAndTab, {
            windowWidth = size.X.Offset,
            formFactor = formFactor,
            tabList = tabList,
            layoutOrder = 1,
            refForParent = arg1.utilRef,
            onHeightChanged = arg1.onUtilTabHeightChanged
        }),
        MainFrame = 0
    }

    local createElement2 = Roact.createElement
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, -utilTabHeight),
        CanvasSize = UDim2.new(1, 0, 1, -utilTabHeight),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl4 = {
        UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                Padding = UDim.new(0, MainRowPadding * 2),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        MicroProfilerRow = 0,
        HorizontalLine = 0,
        ServerProfiler = 0
    }

    local createElement3 = Roact.createElement
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, 90),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl6 = {
        Label = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, 30),
            Position = UDim2.new(0.1, 0, 0, 0),
            Text = if FFlagDevConsoleMicroProfilerImproveWording then "Client MicroProfiler" else "MicroProfiler",
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray2,
            BackgroundTransparency = 1
        }),
        HorizontalLine = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, 30) }),
        ToggleButton = 0
    }

    local createElement4 = Roact.createElement
    local tbl7 = {
        Size = UDim2.new(0.8, -ButtonWidth, 0, 30),
        Position = UDim2.new(0.09999999999999998, ButtonWidth, 0, 37.5),
        BackgroundTransparency = 1
    }
    local tbl8 = {
        OffButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0.5, 0, 1, 0),
            Text = "Off",
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = clientProfilerEnabled and UnselectedGray or SelectedBlue,
            [Roact.Event.Activated] = arg1.changeProfilerState(false)
        }),
        ClientButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0.5, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            Text = if FFlagDevConsoleMicroProfilerImproveWording then "On" else "Client",
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = clientProfilerEnabled and SelectedBlue or UnselectedGray,
            [Roact.Event.Activated] = arg1.changeProfilerState(true)
        })
    }
    tbl6.ToggleButton = createElement4("TextLabel", tbl7, tbl8)
    tbl4.MicroProfilerRow = createElement3("Frame", tbl5, tbl6)

    tbl4.HorizontalLine = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, MainRowPadding), BackgroundTransparency = 1, LayoutOrder = 3 })

    tbl4.ServerProfiler = Roact.createElement(
        ServerProfilerInterface,
        {
            Size = UDim2.new(1, 0, 0, 135),
            BackgroundTransparency = 1,
            LayoutOrder = 4
        }
    )
    tbl2.MainFrame = createElement2("ScrollingFrame", tbl3, tbl4)
    return createElement("Frame", tbl1, tbl2)
end

return var1

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local FFlagDevConsoleMicroProfilerImproveWording = require(script.Parent.Flags.FFlagDevConsoleMicroProfilerImproveWording)
local bool1 = game:DefineFastFlag("DevConsoleMicroProfilerFixAutoTextClear", false)

local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local _Components = script.Parent.Parent.Parent.Components

local Actions = script.Parent.Parent.Parent.Actions
local SetRCCProfilerState = require(Actions.SetRCCProfilerState)

local Constants = require(script.Parent.Parent.Parent.Constants)
local _MainRowPadding = Constants.GeneralFormatting.MainRowPadding
local ButtonWidth = Constants.MicroProfilerFormatting.ButtonWidth
local ButtonTextSize = Constants.MicroProfilerFormatting.ButtonTextSize
local MainWindow = Constants.Font.MainWindow
local MainWindowHeader = Constants.Font.MainWindowHeader
local UnselectedGray = Constants.Color.UnselectedGray
local SelectedBlue = Constants.Color.SelectedBlue

local UnselectedGray2 = Constants.Color.UnselectedGray

local var1 = Roact.Component:extend("ServerProfilerInteraface")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onFocusLostFrameRate(arg2, _, _)
        GameSettings.RCCProfilerRecordFrameRate = arg2.Text

        arg2.Text = GameSettings.RCCProfilerRecordFrameRate
    end

    function arg1.onFocusLostTimeFrame(arg2, _, _)
        GameSettings.RCCProfilerRecordTimeFrame = arg2.Text

        arg2.Text = GameSettings.RCCProfilerRecordTimeFrame
    end

    function arg1.requestRCCProfilerData(_)
        local clientReplicator = getClientReplicator()
        if clientReplicator then
            clientReplicator:RequestRCCProfilerData(
                GameSettings.RCCProfilerRecordFrameRate,
                GameSettings.RCCProfilerRecordTimeFrame
            )
            arg1.props.dispatchSetRCCProfilerState(true)
        end
    end

    function arg1.changeProfilerState(arg2)
        return function()
            GameSettings.OnScreenProfilerEnabled = arg2
            arg1:setState({ clientProfilerEnabled = arg2 })
        end
    end

    arg1.state = {
        frameRate = GameSettings.RCCProfilerRecordFrameRate,
        timeFrame = GameSettings.RCCProfilerRecordTimeFrame
    }
end

function var1.render(arg1)
    local _size = arg1.props.size
    local _formFactor = arg1.props.formFactor
    local _tabList = arg1.props.tabList
    local waitingForRecording = arg1.props.waitingForRecording
    local lastFileOutputLocation = arg1.props.lastFileOutputLocation

    local _utilTabHeight = arg1.state.utilTabHeight

    local frameRate = arg1.state.frameRate
    local timeFrame = arg1.state.timeFrame
    local _clientProfilerEnabled = arg1.state.clientProfilerEnabled

    local bool2 = not waitingForRecording and #lastFileOutputLocation > 0

    local uDim2 = UDim2.new(0.8, -ButtonWidth, 0, 30)
    local _uDim2 = UDim2.new(0.6, ButtonWidth, 0, 0)

    local createElement = Roact.createElement
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, 135),
        BackgroundTransparency = 1,
        LayoutOrder = 4
    }

    local tbl2 = {
        Label = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, 30),
            Position = UDim2.new(0.1, 0, 0, 0),
            Text = if FFlagDevConsoleMicroProfilerImproveWording then "Server MicroProfiler" else "ServerProfiler",
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray2,
            BackgroundTransparency = 1
        }),
        HorizontalLine = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, 30) }),
        LabelFPS = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, 30),
            Position = UDim2.new(0.1, 0, 0, 37.5),
            Text = if FFlagDevConsoleMicroProfilerImproveWording then "Frames to dump" else "Frames Per Second",
            Font = MainWindow,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray2,
            BackgroundTransparency = 1
        }),
        FPSTextBox = Roact.createElement("TextBox", {
            Size = uDim2,
            Position = UDim2.new(0.09999999999999998, ButtonWidth, 0, 37.5),
            Text = frameRate,
            Font = MainWindow,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray2,
            BackgroundTransparency = 0,
            ClearTextOnFocus = not bool1,
            [Roact.Event.FocusLost] = arg1.onFocusLostFrameRate
        }),
        LabelTimeFrame = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, 30),
            Position = UDim2.new(0.1, 0, 0, 67.5),
            Text = if FFlagDevConsoleMicroProfilerImproveWording then "Seconds to delay" else "Seconds to Record",
            Font = MainWindow,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundTransparency = 1
        }),
        TimeFrameTextBox = 0,
        OutputPath = 0
    }

    local createElement2 = Roact.createElement
    local tbl3 = {
        Size = uDim2,
        Position = UDim2.new(0.09999999999999998, ButtonWidth, 0, 67.5),
        Text = timeFrame,
        Font = MainWindow,
        TextSize = ButtonTextSize,
        TextColor3 = Constants.Color.Text,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundColor3 = UnselectedGray2,
        BackgroundTransparency = 0,
        ClearTextOnFocus = not bool1,
        [Roact.Event.FocusLost] = arg1.onFocusLostTimeFrame
    }
    local tbl4 = {
        GetDumpButton = Roact.createElement("TextButton", {
            Size = UDim2.new(0, ButtonWidth * 0.7, 0, 30),
            Position = UDim2.new(1, -ButtonWidth * 0.7, 1, 30),
            Text = if waitingForRecording then "Recording" else "Start Recording",
            Font = MainWindow,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = waitingForRecording and UnselectedGray or SelectedBlue,
            BackgroundTransparency = if waitingForRecording then 0.3 else 0,
            AutoButtonColor = not waitingForRecording,
            Active = not waitingForRecording,
            [Roact.Event.Activated] = arg1.requestRCCProfilerData
        })
    }
    tbl2.TimeFrameTextBox = createElement2("TextBox", tbl3, tbl4)

    tbl2.OutputPath = bool2
        and Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, 97.5),
            Text = lastFileOutputLocation,
            Font = MainWindow,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    return createElement("Frame", tbl1, tbl2)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        waitingForRecording = arg1.MicroProfiler.waitingForRecording,
        lastFileOutputLocation = arg1.MicroProfiler.lastFileOutputLocation
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetRCCProfilerState = function(arg1, arg2)
            callback(SetRCCProfilerState(arg1, arg2))
        end
    }
end)(var1)

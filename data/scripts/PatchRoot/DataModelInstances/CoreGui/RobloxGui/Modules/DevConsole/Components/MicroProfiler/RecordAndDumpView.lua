-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local MicroProfilerService = game:GetService("MicroProfilerService")
local TelemetryService = game:GetService("TelemetryService")

local BoxButton = require(script.Parent.Parent.BoxButton)
local Constants = require(script.Parent.Parent.Parent.Constants)
local MicroProfilerPanel = require(script.Parent.MicroProfilerPanel)
local NumberInput = require(script.Parent.Parent.NumberInput)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local GameSettings = UserSettings().GameSettings

local Actions = script.Parent.Parent.Parent.Actions
local AppendRecentDumpPath = require(Actions.AppendRecentDumpPath)
local SetRCCProfilerState = require(Actions.SetRCCProfilerState)

local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local var1 = Roact.Component:extend("RecordAndDumpView")

local config = {
    eventName = "DevConsoleMpRecordAndDumpCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2025, 11, 24 },
    description = "\t\tCounter to track the action of using the Developer Console to record and save MicroProfiler\n\t\tdumps for either the client or server.\n\t"
}

function var1.logRecordAndDumpAction(tbl1, context: string)
    TelemetryService:LogCounter(config, {
        customFields = {
            context = context,
            secondsToDelay = tbl1.state[`{context}SecondsToDelay`],
            framesToRecord = tbl1.state[`{context}FramesToRecord`]
        }
    }, 1)
end

function var1.numericInputRow(_, arg1)
    return {
        UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                Padding = UDim.new(0, 8),
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        UIPadding = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 4),
            PaddingLeft = UDim.new(0, Constants.MicroProfilerFormatting.OptionTextPadding),
            PaddingRight = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4)
        }),
        OptionLabel = Roact.createElement(
            "TextLabel",
            {
                Font = Constants.Font.MainWindow,
                Text = arg1.Text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = Constants.MicroProfilerFormatting.OptionTextSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                Position = UDim2.fromOffset(8, 0),
                Size = UDim2.fromScale(0, 1)
            },
            {
                UIFlexItem = Roact.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
            }
        ),
        NumberInput = Roact.createElement(NumberInput, {
            Size = UDim2.new(0, 72, 1, 0),
            LayoutOrder = 3,
            OnNumberInputChanged = arg1.OnNumberInputChanged,
            Range = arg1.Range,
            DefaultValue = arg1.DefaultValue,
            IntegerOnly = arg1.IntegerOnly
        }),
        NumberLimitsHint = Roact.createElement("TextLabel", {
            Font = Constants.Font.Log,
            Text = `({arg1.Range.Min}-{arg1.Range.Max})`,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 12,
            TextTransparency = 0.5,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            LayoutOrder = 2,
            Size = UDim2.new(0, 32, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Right
        })
    }
end

function var1.recordAndDumpRows(arg1, arg2)
    local bool1 = arg2.Context == "Client"

    local tbl1 = {
        Context = arg2.Context,
        Text = "Number of frames to record",
        DefaultValue = if bool1 then arg1.state.ClientFramesToRecord else arg1.state.ServerFramesToRecord,
        Range = NumberRange.new(1, 60),
        IntegerOnly = true,
        OnNumberInputChanged = 0
    }
    function tbl1.OnNumberInputChanged(num1: number)
        if bool1 then
            arg1:setState({ ClientFramesToRecord = num1 })
            return
        end

        GameSettings.RCCProfilerRecordFrameRate = num1
        arg1:setState({ ServerFramesToRecord = num1 })
    end

    local var2 = arg1:numericInputRow(tbl1)

    local tbl2 = {
        Context = arg2.Context,
        Text = "Seconds to delay",
        DefaultValue = if bool1 then arg1.state.ClientSecondsToDelay else arg1.state.ServerSecondsToDelay,
        Range = NumberRange.new(1, 4),
        IntegerOnly = true,
        OnNumberInputChanged = 0
    }
    function tbl2.OnNumberInputChanged(num1: number)
        if bool1 then
            arg1:setState({ ClientSecondsToDelay = num1 })
            return
        end

        GameSettings.RCCProfilerRecordTimeFrame = num1
        arg1:setState({ ServerSecondsToDelay = num1 })
    end

    local var3 = arg1:numericInputRow(tbl2)

    local tbl3 = {
        UIPadding = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2),
            PaddingTop = UDim.new(0, 2)
        }),
        Button = Roact.createElement(BoxButton, {
            text = if bool1 then if arg1.state.IsClientRecording then arg2.RecordButtonText.Recording else arg2.RecordButtonText.Idle elseif arg1.props.IsServerRecording then arg2.RecordButtonText.Recording else arg2.RecordButtonText.Idle,
            size = UDim2.fromScale(1, 1),
            pos = UDim2.new(0, 0, 0, 0),
            onClicked = arg2.OnRecordButtonClicked,
            enabled = if bool1 then not arg1.state.IsClientRecording else not arg1.props.IsServerRecording
        })
    }
    return { var2, var3, tbl3 }
end

function var1.init(arg1)
    arg1.state = {
        IsClientRecording = false,
        ClientFramesToRecord = 32,
        ClientSecondsToDelay = 1,
        ServerFramesToRecord = GameSettings.RCCProfilerRecordFrameRate,
        ServerSecondsToDelay = GameSettings.RCCProfilerRecordTimeFrame
    }

    arg1.RecordingTasks = { Client = nil }
end

function var1.willUnmount(arg1)
    if arg1.RecordingTasks.Client and coroutine.status(arg1.RecordingTasks.Client) ~= "dead" then
        task.cancel(arg1.RecordingTasks.Client)
    end
end

function var1.render(arg1)
    return Roact.createElement(MicroProfilerPanel, {
        Title = "Record and dump",
        LayoutOrder = arg1.props.LayoutOrder,
        Sections = {
            {
                Name = "Client",
                Rows = arg1:recordAndDumpRows({
                    Context = "Client",
                    RecordButtonText = {
                        Idle = "Begin client recording",
                        Recording = "Recording client..."
                    },
                    OnRecordButtonClicked = function()
                        if arg1.state.IsClientRecording then
                            return
                        end

                        arg1:logRecordAndDumpAction("Client")
                        arg1:setState({ IsClientRecording = true })

                        arg1.RecordingTasks.Client = task.spawn(function()
                            local str1 = MicroProfilerService:DumpToFileAsync(arg1.state.ClientSecondsToDelay, arg1.state.ClientFramesToRecord)

                            arg1.props.dispatchAppendRecentDumpPath(str1)

                            arg1:setState(function(_)
                                return { IsClientRecording = false }
                            end)

                            arg1.RecordingTasks.Client = nil
                        end)
                    end
                })
            },
            {
                Name = "Server",
                Rows = arg1:recordAndDumpRows({
                    Context = "Server",
                    RecordButtonText = {
                        Idle = "Begin server recording",
                        Recording = "Recording server..."
                    },
                    OnRecordButtonClicked = function()
                        if arg1.props.IsServerRecording then
                            return
                        end

                        local clientReplicator = getClientReplicator()
                        if not clientReplicator then
                            return
                        end

                        arg1:logRecordAndDumpAction("Server")

                        clientReplicator:RequestRCCProfilerData(arg1.state.ServerFramesToRecord, arg1.state.ServerSecondsToDelay)

                        arg1.props.dispatchSetRCCProfilerState(true)
                    end
                })
            }
        }
    })
end

return RoactRodux.connect(function(arg1, _) -- name: mapStateToProps
    return {
        IsServerRecording = arg1.MicroProfiler.waitingForRecording
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchAppendRecentDumpPath = function(str1: string)
            callback(AppendRecentDumpPath(str1))
        end,
        dispatchSetRCCProfilerState = function(bool1: boolean, str1: string?)
            callback(SetRCCProfilerState(bool1, str1))
        end
    }
end)(var1)

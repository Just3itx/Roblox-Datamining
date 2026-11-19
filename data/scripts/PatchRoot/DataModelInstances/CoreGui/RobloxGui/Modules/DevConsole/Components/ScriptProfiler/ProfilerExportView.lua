-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local _ScriptContext = game:GetService("ScriptContext")
local ScriptProfilerService = game:GetService("ScriptProfilerService")

local _ProfilerDataFormatV2 = require(script.Parent.ProfilerDataFormatV2)

local Components = script.Parent.Parent.Parent.Components
local ScrollingTextBox = require(Components.ScrollingTextBox)

local _Actions = script.Parent.Parent.Parent.Actions

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local MainWindowHeader = Constants.Font.MainWindowHeader
local MainWindow = Constants.Font.MainWindow
local ButtonTextSize = Constants.MicroProfilerFormatting.ButtonTextSize
local UnselectedGray = Constants.Color.UnselectedGray

local ButtonWidth = Constants.MicroProfilerFormatting.ButtonWidth

local var1 = Roact.PureComponent:extend("ProfilerExportView")

local function generateDefaultExportName(bool1: boolean, arg1, str1: string) -- Luacid: unused: defined but never referenced
    local sessionStartTime = arg1 and arg1.SessionStartTime
    return "scriptprofiler-" .. (sessionStartTime and os.date("%Y%b%d-%H%M%S-", sessionStartTime / 1000) or "") .. (if bool1 then "client" else "server") .. str1
end

function var1.init(_) end

function var1.didMount(arg1)
    local tbl1 = { exportFilenameClient = 0, exportFilenameServer = 0 }
    local data = arg1.props.client.data
    local sessionStartTime = data and data.SessionStartTime

    tbl1.exportFilenameClient = "scriptprofiler-" .. (sessionStartTime and os.date("%Y%b%d-%H%M%S-", sessionStartTime / 1000) or "") .. "client.json"
    local data2 = arg1.props.server.data
    local sessionStartTime2 = data2 and data2.SessionStartTime

    tbl1.exportFilenameServer = "scriptprofiler-" .. (sessionStartTime2 and os.date("%Y%b%d-%H%M%S-", sessionStartTime2 / 1000) or "") .. "server.json"
    arg1:setState(tbl1)
end

function var1.didUpdate(_) end

function var1.renderExportInputAndButton(tbl1, bool1: boolean, filename: string, jsonString: string)
    local createElement = Roact.createElement
    local str1 = "TextLabel"
    local tbl2 = {
        Size = UDim2.new(0.9, 0, 0, 30),
        Position = UDim2.new(0.05, 0, 0, 37.5),
        BackgroundTransparency = 0,
        BackgroundColor3 = UnselectedGray,
        Text = if jsonString then "" else "Complete a profiling session to export data",
        TextSize = ButtonTextSize,
        Font = MainWindow,
        TextColor3 = Constants.Color.Text
    }
    local tbl3

    if jsonString then
        tbl3 = {
            InputField = Roact.createElement(ScrollingTextBox, {
                Text = filename,
                TextSize = ButtonTextSize,
                Font = MainWindow,
                Size = UDim2.new(0.8, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                ShowNativeInput = true,
                TextColor3 = Constants.Color.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                PlaceholderText = "Filename for export",
                TextBoxFocusLost = function(arg1, _, _)
                    if bool1 then
                        tbl1:setState({ exportFilenameClient = arg1.text })
                        return
                    end

                    tbl1:setState({ exportFilenameServer = arg1.text })
                end
            }),
            ExportButton = 0
        }

        local createElement2 = Roact.createElement
        local tbl4 = {
            Size = UDim2.new(0.2, 0, 1, 0),
            Position = UDim2.new(0.8, 0, 0, 0),
            Text = "Export",
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray
        }
        tbl4[Roact.Event.Activated] = function()
            local str2 = ScriptProfilerService:SaveScriptProfilingData(jsonString, filename)

            if bool1 then
                tbl1:setState({ clientSavePath = str2 })
                return
            end

            tbl1:setState({ serverSavePath = str2 })
        end

        tbl3.ExportButton = createElement2("TextButton", tbl4)
    else
        tbl3 = {}
    end

    return createElement(str1, tbl2, tbl3)
end

function var1.renderExportSection(tbl1, bool1: boolean, text: string)
    local var2, serializedData, var3

    if bool1 then
        var2 = tbl1.state.exportFilenameClient
        serializedData = tbl1.props.client.serializedData
        var3 = tbl1.state.clientSavePath
    else
        var2 = tbl1.state.exportFilenameServer
        serializedData = tbl1.props.server.serializedData
        var3 = tbl1.state.serverSavePath
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 90),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl3 = {
        Label = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, ButtonWidth, 0, 30),
            Position = UDim2.new(0.1, 0, 0, 0),
            Text = text,
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray,
            BackgroundTransparency = 1
        }),
        HorizontalLine = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, 30) }),
        Export = tbl1:renderExportInputAndButton(bool1, var2, serializedData),
        SavedPath = 0
    }
    local element

    if var3 then
        element = Roact.createElement("TextBox", {
            Size = UDim2.new(0.95, 0, 0, 30),
            Position = UDim2.new(0.05, 0, 0, 75),
            Text = "Saved to " .. var3,
            Font = MainWindowHeader,
            TextSize = ButtonTextSize,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundColor3 = UnselectedGray,
            BackgroundTransparency = 1,
            TextEditable = false,
            ClearTextOnFocus = false
        })
    else
        element = nil
    end

    tbl3.SavedPath = element
    return createElement(str1, tbl2, tbl3)
end

function var1.render(arg1)
    return Roact.createElement(
        "Frame",
        {
            Size = arg1.props.size,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            LayoutOrder = 2
        },
        {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    Padding = UDim.new(0, MainRowPadding * 2),
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            Row = arg1:renderExportSection(true, "Client"),
            HorizontalLine = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, MainRowPadding), BackgroundTransparency = 1, LayoutOrder = 3 }),
            Row2 = arg1:renderExportSection(false, "Server")
        }
    )
end
return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        client = arg1.ScriptProfiler.client,
        server = arg1.ScriptProfiler.server
    }
end, nil)(var1)
